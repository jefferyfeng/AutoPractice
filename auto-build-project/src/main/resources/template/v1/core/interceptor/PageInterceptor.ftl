package ${interceptorPackage};

import ${basePackage}.PageBean;
import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.factory.DefaultObjectFactory;
import org.apache.ibatis.reflection.factory.ObjectFactory;
import org.apache.ibatis.reflection.wrapper.DefaultObjectWrapperFactory;
import org.apache.ibatis.reflection.wrapper.ObjectWrapperFactory;
import org.apache.ibatis.scripting.defaults.DefaultParameterHandler;
import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Stack;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @description:  用于拦截分页方法 自动化分页
 * @date: 2019/5/16 18:03
 * @author: fdh
 */
@Intercepts({@Signature(type = StatementHandler.class, method = "prepare", args = {Connection.class})})
public class PageInterceptor implements Interceptor {
    /**记录日志*/
    private static final Logger LOGGER = LoggerFactory.getLogger(PageInterceptor.class);
    private static final ObjectFactory DEFAULT_OBJECT_FACTORY = new DefaultObjectFactory();
    private static final ObjectWrapperFactory DEFAULT_OBJECT_WRAPPER_FACTORY = new DefaultObjectWrapperFactory();
    /**数据库类型(默认为mysql*/
    private String dialect;
    /**需要拦截的ID(正则匹配)*/
    private String pageSqlId;

    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        StatementHandler statementHandler = (StatementHandler) invocation.getTarget();
        MetaObject metaStatementHandler = MetaObject.forObject(statementHandler, DEFAULT_OBJECT_FACTORY,
                DEFAULT_OBJECT_WRAPPER_FACTORY);
        // 分离代理对象链(由于目标类可能被多个拦截器拦截，从而形成多次代理，通过下面的两次循环可以分离出最原始的的目标类)
        while (metaStatementHandler.hasGetter("h")) {
            Object object = metaStatementHandler.getValue("h");
            metaStatementHandler = MetaObject.forObject(object, DEFAULT_OBJECT_FACTORY, DEFAULT_OBJECT_WRAPPER_FACTORY);
        }
        // 分离最后一个代理对象的目标类
        while (metaStatementHandler.hasGetter("target")) {
            Object object = metaStatementHandler.getValue("target");
            metaStatementHandler = MetaObject.forObject(object, DEFAULT_OBJECT_FACTORY, DEFAULT_OBJECT_WRAPPER_FACTORY);
        }

        MappedStatement mappedStatement = (MappedStatement) metaStatementHandler.getValue("delegate.mappedStatement");

        // 只重写需要分页的sql语句。通过MappedStatement的ID匹配，默认重写以Page结尾的MappedStatement的sql
        if (mappedStatement.getId().matches(pageSqlId)) {
            BoundSql boundSql = (BoundSql) metaStatementHandler.getValue("delegate.boundSql");
            Object parameterObject = boundSql.getParameterObject();
            if (parameterObject == null) {
                throw new NullPointerException("parameterObject is null!");
            } else {
                PageBean pageBean =null;
                // 如果mybatis Dao的参数为Map类型
                if(parameterObject instanceof Map<?,?>){
                    Map<String, Object> daoParam = (Map<String, Object>) parameterObject;
                    pageBean = (PageBean) daoParam.get("pageBean");
                }
                // 如果mybatis Dao的参数类型为对象
                else{
                    Class<?> superclass = parameterObject.getClass().getSuperclass();
                    Method getPageBean = superclass.getDeclaredMethod("getPageBean", null);
                    pageBean = (PageBean)getPageBean.invoke(parameterObject, null);
                }
                //如果仍然是空 手动初始化一个
                if(pageBean == null){
                    pageBean = new PageBean();
                }

                String sql = boundSql.getSql();

                // 重设分页参数里的总页数等
                Connection connection = (Connection) invocation.getArgs()[0];
                setPageBean(sql, connection, mappedStatement, boundSql, pageBean);

                // 重写sql
                String pageSql = buildPageSql(sql, pageBean);
                metaStatementHandler.setValue("delegate.boundSql.sql", pageSql);
                // 采用物理分页后，就不需要mybatis的内存分页了，所以重置下面的两个参数
                metaStatementHandler.setValue("delegate.rowBounds.offset", RowBounds.NO_ROW_OFFSET);
                metaStatementHandler.setValue("delegate.rowBounds.limit", RowBounds.NO_ROW_LIMIT);
            }
        }
        // 将执行权交给下一个拦截器
        return invocation.proceed();
    }

    /**
     * 根据数据库类型，生成特定的分页sql
     * @param sql
     * @param page
     * @return
     */
    private String buildPageSql(String sql, PageBean page) {
        if (page != null) {
            StringBuilder pageSql = new StringBuilder();
            if ("mysql".equals(dialect)) {
                pageSql = buildPageSqlForMysql(sql, page);
            } else if ("oracle".equals(dialect)) {
                pageSql = buildPageSqlForOracle(sql, page);
            } else {
                return sql;
            }
            return pageSql.toString();
        } else {
            return sql;
        }
    }

    /**
     * 构建mysql的分页语句
     * @param sql
     * @param page
     * @return String
     */
    public StringBuilder buildPageSqlForMysql(String sql, PageBean page) {
        StringBuilder pageSql = new StringBuilder(100);
        String beginrow = String.valueOf(page.getBegin());
        pageSql.append(sql);
        pageSql.append(" limit " + beginrow + "," + page.getPageSize());
        return pageSql;
    }


    /**
     * 构建oracle的分页语句
     * @param sql
     * @param page
     * @return String
     */
    public StringBuilder buildPageSqlForOracle(String sql, PageBean page) {
        StringBuilder pageSql = new StringBuilder(100);
        String beginrow = String.valueOf((page.getCurrentPage() - 1) * page.getPageSize());
        String endrow = String.valueOf(page.getCurrentPage() * page.getPageSize());

        pageSql.append("select * from ( select temp.*, rownum row_id from ( ");
        pageSql.append(sql);
        pageSql.append(" ) temp where rownum <= ").append(endrow);
        pageSql.append(") where row_id > ").append(beginrow);
        return pageSql;
    }

    /**
     * 对SQL参数(?)设值
     * @param ps
     * @param mappedStatement
     * @param boundSql
     * @param parameterObject
     * @throws SQLException
     */
    private void setParameters(PreparedStatement ps, MappedStatement mappedStatement, BoundSql boundSql,
                               Object parameterObject) throws SQLException {
        ParameterHandler parameterHandler = new DefaultParameterHandler(mappedStatement, parameterObject, boundSql);
        parameterHandler.setParameters(ps);
    }

    /**
     * @description: 从数据库里查询总的记录数并计算总页数，回写进分页参数PageBean,这样调用者就可用通过 分页参数
     * @date: 2019/5/17 10:26
     * @author: fdh
     * @param: [sql, connection, mappedStatement, boundSql, page]
     * @return: void
     */
    private void setPageBean(String sql, Connection connection, MappedStatement mappedStatement,
                                  BoundSql boundSql, PageBean page) {
        // 记录总记录数
        String countSql =buildCountSql(sql);
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            pstm = connection.prepareStatement(countSql);
            BoundSql countBS = new BoundSql(mappedStatement.getConfiguration(), countSql,
                    boundSql.getParameterMappings(), boundSql.getParameterObject());
            // 优化MyBatis分页 foreach参数失效
            Field metaParamsField = null;
            for (Class<?> superClass = countBS.getClass(); superClass != Object.class; superClass = superClass.getSuperclass()) {
                metaParamsField = superClass.getDeclaredField("metaParameters");
            }

            if (metaParamsField != null) {
                MetaObject mo = null;
                Object value = null;
                if (metaParamsField != null) {
                    if (metaParamsField.isAccessible()) {
                        value = metaParamsField.get(countBS);
                    } else {
                        metaParamsField.setAccessible(true);
                        value = metaParamsField.get(countBS);
                        metaParamsField.setAccessible(false);
                    }
                }
                mo = (MetaObject) value;
                if (metaParamsField.isAccessible()) {
                    metaParamsField.set(countBS, value);
                } else {
                    metaParamsField.setAccessible(true);
                    metaParamsField.set(countBS, value);
                    metaParamsField.setAccessible(false);
                }
            }
            setParameters(pstm, mappedStatement, countBS, boundSql.getParameterObject());
            rs = pstm.executeQuery();
            int totalCount = 0;
            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
            //设置total 并重新计算 TODO 待优化，pageBean只处理的mysql
            page.setAll(totalCount);
        } catch (Exception e) {
            LOGGER.error("count sql执行异常：",e);
        } finally {
            try {
                if(rs != null){
                    rs.close();
                }
            } catch (SQLException e) {
                LOGGER.error("ResultSet 资源关闭异常：", e);
            }
            try {
                if( null != pstm){
                    pstm.close();
                }
            } catch (SQLException e) {
                LOGGER.error("PrepareStatement 资源关闭异常：", e);
            }
        }
    }

    /**
     * @description: 构建countsql
     * @date: 2019/5/16 18:26
     * @author: fdh
     */
    private String buildCountSql(String originalSql){
        //替换空格 将sql关键字置为1个空格
        originalSql.replaceAll("[\r\n]", " ").replaceAll("\\s{2,}", " ");
        //取order by坐标
        int orderIndex = getLastOrderInsertPoint(originalSql);
        //取from坐标
        int formIndex = getAfterFormInsertPoint(originalSql);
        //剔除select映射列 改为count
        String select = originalSql.substring(0, formIndex);

        // 如果SELECT 中包含 DISTINCT 只能在外层包含COUNT
        if (select.toLowerCase().indexOf("select distinct") != -1 || originalSql.toLowerCase().indexOf("group by") != -1) {
            return new StringBuffer(originalSql.length()).append("select count(1) count from (").append(originalSql.substring(0, orderIndex)).append(" ) total").toString();
        } else {
            return new StringBuffer(originalSql.length()).append("select count(1) count ").append(originalSql.substring(formIndex, orderIndex)).toString();
        }
    }

    /**
     * @description: 匹配括号是否成对出现 未匹配中文
     * @date: 2019/5/17 9:26
     * @author: fdh
     * @param: [text]
     * @return: boolean
     */
    private static boolean isBracketCanPartnership(String text) {
        Map<Character,Character> matchMap = new HashMap<>(3);
        matchMap.put('(', ')');
        matchMap.put('[', ']');
        matchMap.put('{', '}');
        Stack<Character> stack = new Stack<>();

        char[] chars = text.toCharArray();
        for (char temp : chars) {
            //向栈中push左括号
            if(matchMap.containsKey(temp)){
                stack.push(temp);
            }
            //校验右括号
            if(matchMap.containsValue(temp)){
                if(stack.isEmpty()) return false;
                //存在左括号 但栈为空必定不匹配
                if( Character.valueOf(temp).equals(matchMap.get(stack.peek())) ){
                    stack.pop();
                }
            }
        }
        return stack.isEmpty();
    }

    /**
     * @description:  得到最后一个Order By的插入点位置
     * @date: 2019/5/17 10:25
     * @author: fdh
     * @param: [querySelect]
     * @return: int
     */
    private static int getLastOrderInsertPoint(String querySelect) {
        int orderIndex = querySelect.toLowerCase().lastIndexOf("order by");
        if (orderIndex == -1 || !isBracketCanPartnership(querySelect.substring(orderIndex, querySelect.length()))) {
            throw new RuntimeException("My SQL 分页必须要有Order by 语句!");
        }
        return orderIndex;
    }

    /**
     * 得到SQL第一个正确的FROM的的插入点
     */
    private static int getAfterFormInsertPoint(String querySelect) {
        String regex = "\\s+FROM\\s+";
        Pattern pattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(querySelect);
        while (matcher.find()) {
            int fromStartIndex = matcher.start(0);
            String text = querySelect.substring(0, fromStartIndex);
            if (isBracketCanPartnership(text)) {
                return fromStartIndex;
            }
        }
        return 0;
    }

    @Override
    public Object plugin(Object target) {
        // 当目标类是StatementHandler类型时，才包装目标类，否者直接返回目标本身,减少目标被代理的次数
        if (target instanceof StatementHandler) {
            return Plugin.wrap(target, this);
        } else {
            return target;
        }
    }

    @Override
    public void setProperties(Properties properties) {

    }

    public String getDialect() {
        return dialect;
    }

    public void setDialect(String dialect) {
        this.dialect = dialect;
    }

    public String getPageSqlId() {
        return pageSqlId;
    }

    public void setPageSqlId(String pageSqlId) {
        this.pageSqlId = pageSqlId;
    }
}
