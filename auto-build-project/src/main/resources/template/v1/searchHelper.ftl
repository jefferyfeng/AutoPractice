package ${basePackage};

import ${constantsPackage}.Operator;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SearchHelper implements Serializable {
    private String property;
    private String[] values;
    private Operator operator;

    public String getProperty() {
        return property;
    }

    public void setProperty(String property) {
        this.property = property;
    }

    public String[] getValues() {
        return values;
    }

    public void setValues(String[] values) {
        this.values = values;
    }

    public Operator getOperator() {
        return operator;
    }

    public void setOperator(Operator operator) {
        this.operator = operator;
    }

    public SearchHelper(String property, String[] values, Operator operator) {
        this.property = property;
        this.values = values;
        this.operator = operator;
    }

    /**
     * 获取搜索条件
     *
     * @param fieldName 字段映射到实体的属性
     * @param operator  操作符
     * @param values    值
     * @return
     */
    public static SearchHelper searcher(String fieldName, Operator operator, String[] values) {
        return new SearchHelper(fieldName, values, operator);
    }

    /**
     * 获取排序sql
     *
     * @param orders
     * @param clazz
     * @return
     */
    public static String getOrderSql(Order[] orders, Class clazz) {
        if (orders==null || orders.length <= 0) {
            throw new RuntimeException("Collection orders don't allow null");
        }
        if (clazz == null) {
            throw new RuntimeException("Class clazz don't allow null");
        }
        StringBuilder builder = new StringBuilder();
        for (Order order : orders) {
            try {
                Field declaredField = clazz.getDeclaredField(order.getProperty());
                Class<?> fieldClass = declaredField.getType();
                //判断是不是基本类型
                if (!(fieldClass.isPrimitive() || fieldClass == String.class || fieldClass == BigDecimal.class || fieldClass == Date.class)) {
                    throw new RuntimeException("Unsupported types");
                }

                String field = humpToUnderline(declaredField.getName());
                builder.append("order by ").append(field).append(order.getDirection().toString()).append(",");
            } catch (Exception e) {
                e.printStackTrace();
                continue;
            }
        }
        if (builder.length() > 0) {
            builder.deleteCharAt(builder.length() - 1);
        }
        return builder.toString();
    }

    /**
     * 获取查询sql
     *
     * @param searchers
     * @param clazz
     * @return
     */
    public static String getSelectSql(SearchHelper[] searchers, Class clazz) {
        if (clazz == null) {
            throw new RuntimeException("Class clazz don't allow null");
        }
        //获取表名
        String tableName = humpToUnderline(clazz.getSimpleName());
        StringBuilder builder = new StringBuilder();
        //查询逻辑有效的
        builder.append("select * from ").append(tableName).append(" where id_valid = 1").append(getSql(searchers,clazz)).append(" order by id desc");
        return builder.toString();
    }

    /**
     * 获取查询sql(去除逻辑字段)
     *
     * @param searchers
     * @param clazz
     * @return
     */
    public static String getSelectSqlWithoutIsValid(SearchHelper[] searchers, Class clazz) {
        if (clazz == null) {
            throw new RuntimeException("Class clazz don't allow null");
        }
        //获取表名
        String tableName = humpToUnderline(clazz.getSimpleName());
        StringBuilder builder = new StringBuilder();
        //查询逻辑有效的
        String sql = " where "+getSql(searchers, clazz).replaceFirst("and", "");
        builder.append("select * from ").append(tableName).append(sql).append(" order by id desc");
        return builder.toString();
    }

    /**
     * 获取查询sql(不带排序的)
     *
     * @param searchers
     * @param clazz
     * @return
     */
    public static String getSelectSqlWithoutOrder(SearchHelper[] searchers, Class clazz){
        if (clazz == null) {
            throw new RuntimeException("Class clazz don't allow null");
        }
        //获取表名
        String tableName = humpToUnderline(clazz.getSimpleName());
        StringBuilder builder = new StringBuilder();
        //查询逻辑有效的
        builder.append("select * from ").append(tableName).append(" where id_valid = 1").append(getSql(searchers,clazz));
        return builder.toString();
    }

    /**
     * 获取查询sql(不带排序和逻辑字段的)
     *
     * @param searchers
     * @param clazz
     * @return
     */
    public static String getSelectSqlWithoutIsValidAndOrder(SearchHelper[] searchers, Class clazz){
        if (clazz == null) {
            throw new RuntimeException("Class clazz don't allow null");
        }
        //获取表名
        String tableName = humpToUnderline(clazz.getSimpleName());
        StringBuilder builder = new StringBuilder();
        //查询逻辑有效的
        String sql = " where "+getSql(searchers, clazz).replaceFirst("and", "");
        builder.append("select * from ").append(tableName).append(sql).append(getSql(searchers,clazz));
        return builder.toString();
    }

    /**
     * 获取自定义排序的查询sql
     * @param searchers
     * @param orders
     * @param clazz
     * @return
     */
    public static String getSelectSqlAndOrder(SearchHelper[] searchers,Order[] orders,Class clazz){
        return getSelectSql(searchers,clazz) + getOrderSql(orders,clazz);
    }

    /**
     * 获取数量的sql
     * @param searchers
     * @param clazz
     * @return
     */
    public static String getCountSql(SearchHelper[] searchers, Class clazz){
        if (clazz == null) {
            throw new RuntimeException("Class clazz don't allow null");
        }
        //获取表名
        String tableName = humpToUnderline(clazz.getSimpleName());
        StringBuilder builder = new StringBuilder();
        //查询逻辑有效的
        builder.append("select count(1) from ").append(tableName).append(" where id_valid = 1").append(getSql(searchers,clazz));
        return builder.toString();
    }

    /**
     * 获取数量的sql(不带逻辑字段的)
     * @param searchers
     * @param clazz
     * @return
     */
    public static String getCountSqlWithOutIsValid(SearchHelper[] searchers, Class clazz){
        if (clazz == null) {
            throw new RuntimeException("Class clazz don't allow null");
        }
        //获取表名
        String tableName = humpToUnderline(clazz.getSimpleName());
        StringBuilder builder = new StringBuilder();
        //查询逻辑有效的
        String sql = " where "+getSql(searchers, clazz).replaceFirst("and", "");
        builder.append("select count(1) from ").append(tableName).append(sql).append(getSql(searchers,clazz));
        return builder.toString();
    }


    /**
     * 获取搜索条件sql
     *
     * @param searchers
     * @param clazz
     * @param <T>
     * @return
     */
    private static <T> String getSql(SearchHelper[] searchers, Class<T> clazz) {
        if ( searchers == null && searchers.length <= 0) {
            throw new RuntimeException("Collection searchers don't allow null");
        }
        StringBuilder builder = new StringBuilder();
        for (SearchHelper searcher : searchers) {
            try {
                Field declaredField = clazz.getDeclaredField(searcher.getProperty());
                Class<?> fieldClass = declaredField.getType();
                //判断是不是基本类型
                if (!(fieldClass.isPrimitive() || fieldClass == String.class || fieldClass == BigDecimal.class || fieldClass == Date.class)) {
                    throw new RuntimeException("Unsupported types");
                }
                String field = humpToUnderline(declaredField.getName());
                Operator operator = searcher.getOperator();
                String value = dealSqlAttack(searcher.getValues()[0]);
                builder.append(" and ");
                switch (operator) {
                    case EQ:
                        builder.append(field).append(" = ").append("'").append(value).append("'");
                        break;
                    case NOTEQ:
                        builder.append(field).append(" != ").append("'").append(value).append("'");
                        break;
                    case CONTAIN:
                        builder.append(field).append(" like ").append("'%").append(value).append("%'");
                        break;
                    case NOTCONTAIN:
                        builder.append(field).append(" not like ").append("'%").append(value).append("%'");
                        break;
                    case STARTWITH:
                        builder.append(field).append(" like ").append("'").append(value).append("%'");
                        break;
                    case NOTSTARTWITH:
                        builder.append(field).append(" not like ").append("'").append(value).append("%'");
                        break;
                    case ENDWITH:
                        builder.append(field).append(" like ").append("'%").append(value).append("'");
                        break;
                    case NOTENDWITH:
                        builder.append(field).append(" not like ").append("'%").append(value).append("'");
                        break;
                    case GT:
                        builder.append(field).append(" > ").append("'").append(value).append("'");
                        break;
                    case LT:
                        builder.append(field).append(" < ").append("'").append(value).append("'");
                        break;
                    case GE:
                        builder.append(field).append(" >= ").append("'").append(value).append("'");
                        break;
                    case LE:
                        builder.append(field).append(" <= ").append("'").append(value).append("'");
                        break;
                    case IN:
                        builder.append(field).append(" in ").append(dealArrayValues(searcher.values));
                        break;
                    case NOTIN:
                        builder.append(field).append(" not in ").append(dealArrayValues(searcher.values));
                        break;
                    case ISNULL:
                        builder.append(field).append(" is null ");
                        break;
                    case ISNOTNULL:
                        builder.append(field).append(" is not null ");
                        break;
                }

            } catch (Exception e) {
                e.printStackTrace();
                continue;
            }
        }
        return builder.toString();
    }

    /**
     * 将驼峰风格替换为下划线风格
     */
    private static String humpToUnderline(String str) {
        Matcher matcher = Pattern.compile("[A-Z]").matcher(str);
        StringBuilder builder = new StringBuilder(str);
        for (int i = 0; matcher.find(); i++) {
            //每一段全部转为小写
            builder.replace(matcher.start() + i, matcher.end() + i, "_" + matcher.group().toLowerCase());
        }
        if (builder.charAt(0) == '_') {
            builder.deleteCharAt(0);
        }
        return builder.toString();
    }

    /**
     * 处理数组的value值主要用于(in,not in)
     * @param values
     * @return
     */
    private static String dealArrayValues(String[] values){
        if(values==null || values.length <= 0){
            throw new RuntimeException("Array values don't allow null");
        }
        StringBuilder builder = new StringBuilder();
        builder.append("(");
        for (String value : values) {
            builder.append("'").append(value).append("', ");
        }
        builder.deleteCharAt(builder.length()-1);
        builder.append(")");
        return builder.toString();
    }

    /**
     * 处理sql注入
     * @param value
     * @return
     */
    private static String dealSqlAttack(String value){
        if( value==null || "".equals(value)){
            throw new RuntimeException("value is Attacking");
        }
        return value.replaceAll("'","''").replaceAll("\\\\","\\\\\\\\");
    }
}
