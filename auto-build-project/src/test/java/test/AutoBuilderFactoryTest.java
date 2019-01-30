package test;

import authority.BaseDBTables;
import db.ColumnModel;
import db.TableModel;
import init.ConfigReader;
import init.Configration;
import init.DBInfo;
import util.FileUtil;
import util.FreemarkerUtil;
import util.StringUtil;

import java.io.*;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

/**
 * 自动构建项目入口
 */
public class AutoBuilderFactoryTest {
    private static Configration config = ConfigReader.getConfig();
    //获取模板路径
    private static String templateUrl = config.getTemplateUrl();

    public static void main(String[] args) throws SQLException {
        //1. 建立权限相关基表
        //createPermissionTables();
        //2. 构建项目
        buildProject();
    }

    /**
     * 建立权限相关基表
     */
    private static void createPermissionTables(){
        BaseDBTables.createUserTable();
        BaseDBTables.createRoleTable();
        BaseDBTables.createUserRoleTable();
        BaseDBTables.createPermissionTable();
        BaseDBTables.createRolePermissionTable();
    }

    /**
     * 构建项目
     */
    private static void buildProject(){
        //1. 创建根目录
        //1.1初始化项目根目录
        String projectDir = config.getBaseBossDir()+"/"+config.getProjectName();
        System.out.println("初始化project : "+projectDir);
        File projectPath = new File(projectDir);
        FileUtil.mkdirs(projectPath);

        //2. 创建pom文件
        //输出路径
        String pomPath = projectDir + "/pom.xml";
        System.out.println("\t|--创建pom文件 : "+pomPath);
        Map<String,Object> dataModel=new HashMap<String, Object>();
        dataModel.put("groupId",config.getGroupId());
        dataModel.put("projectName",config.getProjectName());
        FreemarkerUtil.createFile(templateUrl+"/pom","pom.ftl",pomPath,dataModel,null);

        //3. 创建src目录
        String srcDir = projectDir+"/src";
        System.out.println("\t|--创建src : "+srcDir);
        File basePath = new File(srcDir);
        FileUtil.mkdirs(basePath);
        //source,resource目录
        String sourceDir = srcDir + "/main/java";
        String resourcesDir = srcDir + "/main/resources";
        String webAppDir = srcDir + "/main/webapp";

        //4. 创建基包
        String packageDir = sourceDir+"/"+StringUtil.getPathStr(config.getGroupId());
        File packagePath = new File(packageDir);
        System.out.println("\t\t|--创建package ："+ packagePath);
        FileUtil.mkdirs(packagePath);
        //创建resource目录
        File resourcesFile = new File(resourcesDir);
        System.out.println("\t\t|--创建resource ："+ resourcesFile);
        FileUtil.mkdirs(resourcesFile);

        //5. 创建core目录下文件
        createCoreFiles(packageDir);

        //6. 创建modules目录下文件
        createModulesFiles(packageDir);

        //7. 创建resource目录下文件
        createResourcesFiles(resourcesDir);

        //8. 创建webapp目录下文件
        createWebAppFiles(webAppDir);

    }

    /**
     * 创建core目录下文件
     */
    private static void createCoreFiles(String packageDir){
        //创建core目录
        String coreDir = packageDir + "/core";
        System.out.println("\t\t\t|--创建core ："+ coreDir);
        File corePath = new File(coreDir);
        FileUtil.mkdirs(corePath);

        //创建base目录
        String basePath = coreDir + "/base";
        System.out.println("\t\t\t\t|--创建base : "+basePath);
        FileUtil.mkdirs(new File(basePath));
        //包名
        Map<String,Object> dataModel=new HashMap<String, Object>();
        dataModel.put("basePackage",config.getGroupId()+".core.base");
        dataModel.put("constantsPackage",config.getGroupId()+".core.constants");
        dataModel.put("utilPackage",config.getGroupId()+".core.util");
        //创建core-base包下文件
        createPackageFiles(basePath,"/core/base", ".java", "\t\t\t\t\t", dataModel);


        //创建constants目录
        String constantsPath = coreDir + "/constants";
        System.out.println("\t\t\t\t|--创建constants : "+constantsPath);
        FileUtil.mkdirs(new File(constantsPath));
        //创建core-constants包下文件
        createPackageFiles(constantsPath,"/core/constants", ".java", "\t\t\t\t\t", dataModel);


        //创建util目录
        String utilPath = coreDir + "/util";
        System.out.println("\t\t\t\t|--创建util : "+utilPath);
        FileUtil.mkdirs(new File(utilPath));
        //创建core-util包下文件
        createPackageFiles(utilPath,"/core/util", ".java", "\t\t\t\t\t", dataModel);
    }

    /**
     * 创建modules目录下文件
     */
    private static void createModulesFiles(String packageDir) {
        //创建modules目录
        String modulesDir = packageDir + "/modules";
        System.out.println("\t\t\t|--创建modules ："+ modulesDir);
        File modulesPath = new File(modulesDir);
        FileUtil.mkdirs(modulesPath);

        //创建权限目录
        String permissionDir = modulesDir + "/permission";
        System.out.println("\t\t\t\t|--创建permission : "+permissionDir);

        //创建权限
        String basePackage = config.getGroupId() + ".core.base";
        String[] permissions = {config.getSysUser(),config.getSysRole(),config.getSysUserRole(),config.getSysPermission(),config.getSysRolePermission()};
        createPermissions(permissionDir,permissions,basePackage);
        


    }

    private static void createPermissions(String permissionDir,String[] permissions,String basePackage){
        //创建model目录
        String modelDir = permissionDir +"/" + StringUtil.getPathStr(config.getEntityPackageName());
        System.out.println("\t\t\t\t\t|--创建model : "+modelDir);
        File modelPath = new File(modelDir);
        FileUtil.mkdirs(modelPath);

        //创建dao目录
        String daoDir = permissionDir + "/" + StringUtil.getPathStr(config.getDaoPackageName());
        System.out.println("\t\t\t\t\t|--创建dao : "+daoDir);
        File daoPath = new File(daoDir);
        FileUtil.mkdirs(daoPath);

        //创建mapper目录
        String mapperDir = permissionDir + "/" + StringUtil.getPathStr(config.getMapperPackageName());
        System.out.println("\t\t\t\t\t|--创建mapper : "+mapperDir);
        File mapperPath = new File(mapperDir);
        FileUtil.mkdirs(mapperPath);

        //创建service目录
        String serviceDir = permissionDir + "/" + StringUtil.getPathStr(config.getServicePackageName());
        System.out.println("\t\t\t\t\t|--创建service : "+serviceDir);
        File servicePath = new File(serviceDir);
        FileUtil.mkdirs(servicePath);

        //创建controller目录
        String conrollerDir = permissionDir + "/" + StringUtil.getPathStr(config.getControllerPackageName());
        System.out.println("\t\t\t\t\t|--创建controller : "+conrollerDir);
        File controllerPath = new File(conrollerDir);
        FileUtil.mkdirs(controllerPath);

        String permissionPackage = config.getGroupId()+".modules.permission.";
        for (String modelName : permissions) {
            //获取表信息和字段信息

            TableModel tableModel = DBInfo.initTableModel(modelName);

            Map<String,Object> dataMap = new HashMap<String,Object>();
            dataMap.put("modelPackage",permissionPackage+config.getEntityPackageName());
            dataMap.put("daoPackage",permissionPackage+config.getDaoPackageName());
            dataMap.put("mapperPackage",permissionPackage+config.getMapperPackageName());
            dataMap.put("servicePackage",permissionPackage+config.getServicePackageName());
            dataMap.put("controllerPackage",permissionPackage+config.getControllerPackageName());
            dataMap.put("tableModel",tableModel);
            dataMap.put("basePackage",basePackage);
            dataMap.put("config",config);

            //获取主键列
            for (ColumnModel columnModel : tableModel.getColumnModelList()) {
                if(columnModel.getIsPrimaryKey()){
                    dataMap.put("pkColumnModel",columnModel);
                }
            }

            //创建实体对象
            String modelObjectDir = modelDir + "/" + tableModel.getTableName() + ".java";
            System.out.println("\t\t\t\t\t\t|--创建"+ tableModel.getTableName() +": "+modelObjectDir);
            FreemarkerUtil.createFile(templateUrl + "/modules/model","model.ftl",modelObjectDir,dataMap,null);

            //创建dao接口
            String daoInterfaceDir = daoDir + "/" + tableModel.getTableName() + "Dao.java";
            System.out.println("\t\t\t\t\t\t|--创建"+ tableModel.getTableName() +"Dao : "+daoInterfaceDir);
            FreemarkerUtil.createFile(templateUrl + "/modules/dao","dao.ftl",daoInterfaceDir,dataMap,null);
            //创建mapper实现
            String mapperImplDir = mapperDir + "/" + tableModel.getTableName() + "Mapper.xml";
            System.out.println("\t\t\t\t\t\t|--创建"+ tableModel.getTableName() +"Mapper : "+mapperImplDir);
            FreemarkerUtil.createFile(templateUrl + "/modules/mapper","mapper.ftl",mapperImplDir,dataMap,null);

            //创建service接口
            String serviceInterfaceDir = serviceDir + "/" + tableModel.getTableName() + "Service.java";
            System.out.println("\t\t\t\t\t\t|--创建"+ tableModel.getTableName() +"Service : "+serviceInterfaceDir);
            FreemarkerUtil.createFile(templateUrl + "/modules/service","service.ftl",serviceInterfaceDir,dataMap,null);
            //创建service实现
            String serviceImplDir = serviceDir + "/" +tableModel.getTableName() + "ServiceImpl.java";
            System.out.println("\t\t\t\t\t\t|--创建"+ tableModel.getTableName() +"ServiceImpl : "+serviceImplDir);
            FreemarkerUtil.createFile(templateUrl + "/modules/service","serviceImpl.ftl",serviceImplDir,dataMap,null);

            //创建controller实现
            String controllerClassDir = conrollerDir + "/" +tableModel.getTableName() + "Controller.java";
            System.out.println("\t\t\t\t\t\t|--创建"+ tableModel.getTableName() +"Controller : "+controllerClassDir);
            FreemarkerUtil.createFile(templateUrl + "/modules/controller","controller.ftl",controllerClassDir,dataMap,null);
        }
    }


    /**
     * 创建resources目录下文件
     */
    private static void createResourcesFiles(String resourcesDir){

        Map<String,Object> dataMap = new HashMap<String,Object>();
        dataMap.put("config",config);
        dataMap.put("typeAliasesPackage",config.getGroupId()+".modules.**."+config.getEntityPackageName());
        dataMap.put("mapperLocations","classpath:/" + StringUtil.getPathStr(config.getGroupId())+"/modules/**/"+config.getMapperPackageName()+"/*.xml");
        dataMap.put("basePackage",config.getGroupId()+".modules.**."+config.getDaoPackageName());

        //logback配置文件
        String logbackDir = resourcesDir + "/logback.xml";
        System.out.println("\t\t\t|--创建logback.xml ："+ logbackDir);
        FreemarkerUtil.createFile(templateUrl,"resources/logback/logback.ftl",logbackDir,dataMap,null);

        //创建config目录下文件
        String configDir = resourcesDir + "/config";
        File configPath = new File(configDir);
        System.out.println("\t\t|--创建config ："+ configPath);
        FileUtil.mkdirs(configPath);

        //创建db目录下文件
        String dbDir = configDir + "/db";
        File dbPath = new File(dbDir);
        System.out.println("\t\t\t|--创建db ："+ dbPath);
        FileUtil.mkdirs(dbPath);
        //创建db.properties
        String dbPropertiesDir = dbPath + "/db.properties";
        System.out.println("\t\t\t\t|--创建db.properties ："+ dbPropertiesDir);
        FreemarkerUtil.createFile(templateUrl,"resources/db/db.ftl",dbPropertiesDir,dataMap,null);

        //创建spring目录下文件
        String springDir = configDir + "/spring";
        File springPath = new File(springDir);
        System.out.println("\t\t\t|--创建spring ："+ springPath);
        FileUtil.mkdirs(springPath);
        //创建spring.xml
        String applicationContextDir = springPath + "/spring.xml";
        System.out.println("\t\t\t\t|--创建spring.xml : "+applicationContextDir);
        FreemarkerUtil.createFile(templateUrl,"resources/spring/spring.ftl",applicationContextDir,dataMap,null);
        //创建spring-mvc.xml
        String springMvcDir = springPath + "/spring-mvc.xml";
        System.out.println("\t\t\t\t|--创建spring-mvc.xml : "+springMvcDir);
        FreemarkerUtil.createFile(templateUrl,"resources/spring/springmvc.ftl",springMvcDir,dataMap,null);
    }

    /**
     * 创建webapp目录下文件
     */
    private static void createWebAppFiles(String webAppDir) {
        //创建WEB-INF目录
        String webInfoDir = webAppDir + "/WEB-INF";
        File webInfoPath = new File(webInfoDir);
        System.out.println("\t\t\t|--创建WEB-INF ："+ webInfoDir);
        FileUtil.mkdirs(webInfoPath);

        //引入layui组件
        //String path = config.getTemplateUrl().substring(1)+ "/static";
        String path = config.getTemplateUrl().substring(1);
        File sourcePath = new File(FileUtil.getResourcesFilePath(path));
        String staticPath = webAppDir + "/static";
        File targetPath = new File(staticPath);
        FileUtil.copyDirectory(sourcePath,targetPath);
        System.out.println("\t\t\t|--创建静态资源 ："+ staticPath);

        //创建初始index.jsp
        String indexDir = webAppDir + "/index.jsp";
        System.out.println("\t\t\t|--创建index.jsp ："+ indexDir);
        FreemarkerUtil.createFile(templateUrl,"webapp/template/index.ftl",indexDir,null,null);

        //创建web.xml
        String webxmlDir = webInfoDir + "/web.xml";
        System.out.println("\t\t\t\t|--创建web.xml : "+webxmlDir);
        FreemarkerUtil.createFile(templateUrl,"webapp/xml/web.ftl",webxmlDir,null,null);
    }


    /**
     * 创建某个子包下面的文件
     * @param superPackage 父路径
     * @param subPath 子路径
     * @param fileType 文件类型 即文件后缀 例如：".java"
     * @param level 打印生成文件的目录等级 例如： "\t\t\t"
     * @param dataModel freemarker模板文件需要的作用域值
     */
    private static void createPackageFiles(String superPackage,String subPath,String fileType,String level,Map<String,Object> dataModel){
        String path = config.getTemplateUrl().substring(1)+subPath;
        File file = new File(FileUtil.getResourcesFilePath(path));
        File[] files = file.listFiles();
        for (File temp : files) {
            String name = temp.getName().substring(0,temp.getName().indexOf(".ftl"));
            String fileName = name + fileType;

            String tempPath = superPackage + "/"+ fileName;
            System.out.println(level + "|--创建" + name + " : " + tempPath);
            FreemarkerUtil.createFile(templateUrl+subPath,name+".ftl",tempPath,dataModel,null);
        }
    }
}
