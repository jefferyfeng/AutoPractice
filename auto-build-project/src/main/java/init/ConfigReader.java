package init;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/**
 * 读取项目初始化参数
 *
 * @author fdh
 */
public class ConfigReader {
    private static Properties pro = new Properties();
    //配置文件实例
    private static Configration config = new Configration();
    static {
        try {
            //加载配置文件
            pro.load(ConfigReader.class.getResourceAsStream("/config/auto.properties"));
            /**
             * 为配置实体赋值
             */
            //基础 boss 部分
            config.setTemplateUrl(pro.getProperty("template.url"));
            config.setGroupId(pro.getProperty("project.groupId"));
            config.setProjectName(pro.getProperty("project.projectName"));
            config.setDbType(pro.getProperty("jdbc.dbType").toLowerCase());
            if("mysql".equals(config.getDbType().toLowerCase())){
                config.setDbName(pro.getProperty("jdbc.database"));
                config.setDbUrl("jdbc:mysql://"+pro.getProperty("jdbc.dbIp")+":3306/"+config.getDbName()+"?characterEncoding=UTF-8&useSSL=false");//解决mysql ssl警告问题
            }else if("oracle".equals(config.getDbType().toLowerCase())){
                //TODO 暂时没有oracle需求，默认使用thin方式连接xe实例
                config.setDbUrl("jdbc:oracle:thin:@//"+pro.getProperty("jdbc.dbIp")+":1521/XE");
            }
            config.setUsername(pro.getProperty("jdbc.username"));
            config.setPassword(pro.getProperty("jdbc.password"));
            config.setBaseBossDir(pro.getProperty("base.boss.dir"));
            config.setEntityPackageName(pro.getProperty("package.entity"));
            config.setDaoPackageName(pro.getProperty("package.dao"));
            config.setMapperPackageName(pro.getProperty("package.mapper"));
            config.setServicePackageName(pro.getProperty("package.service"));
            config.setControllerPackageName(pro.getProperty("package.controller"));
            //权限表名
            config.setSysUser(pro.getProperty("boss.userTable"));
            config.setSysRole(pro.getProperty("boss.roleTable"));
            config.setSysUserRole(pro.getProperty("boss.userRoleTable"));
            config.setSysPermission(pro.getProperty("boss.permissionTable"));
            config.setSysRolePermission(pro.getProperty("boss.rolePermissionTable"));

            //子模块部分
            config.setTableName(pro.getProperty("module.tableName"));
            config.setModuleDir(pro.getProperty("module.dir"));
            config.setModuleType(pro.getProperty("module.type"));


            //读取mysqlToJavaMapping配置文件
            pro.clear();
            pro.load(ConfigReader.class.getResourceAsStream("/config/mysqlToJavaMapping.properties"));
            Map<String,String> mysqlToJavaMap = new HashMap<String,String>();
            Enumeration<?> enumeration = pro.propertyNames();
            while(enumeration.hasMoreElements()){
                Object o = enumeration.nextElement();
                mysqlToJavaMap.put(o.toString(),pro.getProperty(o.toString()));
            }
            config.setMysqlToJavaMap(mysqlToJavaMap);
        } catch (IOException e) {
            new RuntimeException("配置文件不存在！");
        }
    }

    public static Configration getConfig(){
        return config;
    }
}
