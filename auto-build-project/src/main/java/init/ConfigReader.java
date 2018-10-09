package init;

import java.io.IOException;
import java.util.Properties;

/**
 * 读取项目初始化参数
 */
public class ConfigReader {
    private static Properties pro = new Properties();
    //配置文件实例
    private static Configration config = new Configration();
    static {
        try {
            //加载配置文件
            pro.load(ConfigReader.class.getResourceAsStream("/config/auto.properties"));
            //为配置实体赋值
            config.setTemplateUrl(pro.getProperty("template.url"));
            config.setGroupId(pro.getProperty("project.groupId"));
            config.setProjectName(pro.getProperty("project.projectName"));
            config.setDbType(pro.getProperty("jdbc.dbType").toLowerCase());
            if("mysql".equals(config.getDbType().toLowerCase())){
                config.setDbUrl("jdbc:mysql://"+pro.getProperty("jdbc.dbIp")+":3306/"+pro.getProperty("jdbc.database")+"?characterEncoding=UTF-8");
            }else if("oracle".equals(config.getDbType().toLowerCase())){
                //TODO 暂时没有oracle需求，默认使用thin方式连接xe实例
                config.setDbUrl("jdbc:oracle:thin:@//"+pro.getProperty("jdbc.dbIp")+":1521/XE");
            }
            config.setUsername(pro.getProperty("jdbc.username"));
            config.setPassword(pro.getProperty("jdbc.password"));
            config.setTableName(pro.getProperty("jdbc.tableName"));
            config.setOutputDir(pro.getProperty("output.baseUrl"));
            config.setEntityPackageName(pro.getProperty("package.entity"));
            config.setDaoPackageName(pro.getProperty("package.dao"));
            config.setServicePackageName(pro.getProperty("package.service"));
            config.setControllerPackageName(pro.getProperty("package.controller"));
        } catch (IOException e) {
            new RuntimeException("配置文件不存在！");
        }
    }

    public static Configration getConfig(){
        return config;
    }
}
