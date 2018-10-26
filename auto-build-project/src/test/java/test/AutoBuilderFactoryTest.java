package test;

import authority.BaseDBTables;
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
        FreemarkerUtil.createFile(templateUrl,"pom.ftl",pomPath,dataModel,null);

        //3. 创建src目录
        String srcDir = projectDir+"/src";
        System.out.println("\t|--创建src : "+srcDir);
        File basePath = new File(srcDir);
        FileUtil.mkdirs(basePath);
        //source,resource目录
        String sourceDir = srcDir + "/main/java";
        String resourcesDir = srcDir + "/main/resources";

        //4. 创建基包
        String packageDir = sourceDir+"/"+StringUtil.getPathStr(config.getGroupId());
        File packagePath = new File(packageDir);
        System.out.println("\t\t|--创建package ："+ packagePath);
        FileUtil.mkdirs(packagePath);

        //5. 创建core目录下文件
        createCoreFiles(packageDir);

        //6. 创建modules目录下文件
        createModulesFiles(packageDir);

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
        //创建pojo目录
        String pojoPath = coreDir + "/pojo";
        System.out.println("\t\t\t\t|--创建pojo : "+pojoPath);
        FileUtil.mkdirs(new File(pojoPath));
        //包名
        Map<String,Object> dataModel=new HashMap<String, Object>();
        dataModel.put("pojoPackage",config.getGroupId()+".core.pojo");

        //创建PageParameter对象
        String paperParameterPath = pojoPath + "/PageParameter.java";
        System.out.println("\t\t\t\t\t|--创建PageParameter : "+paperParameterPath);
        FreemarkerUtil.createFile(templateUrl,"pageParameter.ftl",paperParameterPath,dataModel,null);
        //创建BasePojo对象

        String basePojoPath = pojoPath + "/BasePojo.java";
        System.out.println("\t\t\t\t\t|--创建BasePojo : "+basePojoPath);
        FreemarkerUtil.createFile(templateUrl,"basePojo.ftl",basePojoPath,dataModel,null);
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

        //创建model
        System.out.println("\t\t\t\t|--创建permission : "+permissionDir);
        String modelDir = permissionDir +"/"+ StringUtil.getPathStr(config.getEntityPackageName());
        System.out.println("\t\t\t\t\t|--创建model : "+modelDir);
        File modelPath = new File(modelDir);
        FileUtil.mkdirs(modelPath);
        //创建权限实体
        String corePojoPackage = config.getGroupId() + ".core.pojo.BasePojo";
        createPermissionModel(modelDir,config.getSysUser(),corePojoPackage);
        createPermissionModel(modelDir,config.getSysRole(),corePojoPackage);
        createPermissionModel(modelDir,config.getSysUserRole(),corePojoPackage);
        createPermissionModel(modelDir,config.getSysPermission(),corePojoPackage);
        createPermissionModel(modelDir,config.getSysRolePermission(),corePojoPackage);

    }

    private static void createPermissionModel(String modelDir,String modelName,String basePojoPackage){
        TableModel tableModel = DBInfo.initTableModel(modelName);
        Map<String,Object> dataModel = new HashMap<String,Object>();
        dataModel.put("package",config.getGroupId()+".modules.permission."+config.getEntityPackageName());
        dataModel.put("tableModel",tableModel);
        dataModel.put("pojoPackage",basePojoPackage);
        FreemarkerUtil.createFile(templateUrl,"model.ftl",modelDir+"/"+tableModel.getTableName()+".java",dataModel,null);
    }
}
