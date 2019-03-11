package authority;

import init.ConfigReader;
import init.Configration;
import util.ConnectionUtil;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class BaseDBTables {
    private static Configration config = ConfigReader.getConfig();
    /**
     * 创建用户表
     */
    public static void createUserTable() {
        String sysUserTableName = "sys_user";
        if (config.getSysUser() != null) {
            sysUserTableName = config.getSysUser();
        }
        try {
            Connection conn = ConnectionUtil.getConn();
            Statement stm = conn.createStatement();
            String sql = "CREATE TABLE " + sysUserTableName + "(\n" +
                    "\tid BIGINT (20) PRIMARY KEY AUTO_INCREMENT COMMENT 'id',\n " +
                    "\tusername VARCHAR (255) UNIQUE NOT NULL COMMENT '用户名',\n" +
                    "\tsex INT (2) COMMENT '性别 0.未知 1.男 2.女',\n" +
                    "\tphoto VARCHAR (512) COMMENT '头像',\n" +
                    "\temail VARCHAR (255) UNIQUE COMMENT '邮箱',\n" +
                    "\tpassword VARCHAR (40) NOT NULL COMMENT '密码',\n" +
                    "\tphone VARCHAR (32) COMMENT '手机号',\n" +
                    "\tsalt VARCHAR (20) NOT NULL COMMENT '盐值',\n" +
                    "\tstatus INT NOT NULL COMMENT '用户状态0.禁用 1.启用',\n" +
                    "\tis_valid INT (2) NOT NULL COMMENT '是否有效 0.无效 1.有效',\n" +
                    "\tcreate_date datetime COMMENT '创建时间',\n" +
                    "\tcreate_user BIGINT (20) DEFAULT NULL COMMENT '创建人',\n" +
                    "\tupdate_date datetime COMMENT '修改时间',\n" +
                    "\tupdate_user BIGINT (20) DEFAULT NULL COMMENT '更新人'\n" +
                    ")";
            stm.executeUpdate(sql);
            System.out.println("Table :" + sysUserTableName + " 创建成功！");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 创建角色表
     */
    public static void createRoleTable() {
        String sysRoleTableName = "sys_role";
        if (config.getSysRole() != null) {
            sysRoleTableName = config.getSysRole();
        }
        try {
            Connection conn = ConnectionUtil.getConn();
            Statement stm = conn.createStatement();
            String sql = "CREATE TABLE "+ sysRoleTableName +"(\n" +
                    "\tid BIGINT (20) PRIMARY KEY AUTO_INCREMENT COMMENT 'id',\n" +
                    "\trole_name VARCHAR (255) DEFAULT NULL COMMENT '角色名称',\n" +
                    "\tdescription VARCHAR (512) DEFAULT NULL COMMENT '角色描述',\n" +
                    "\tsequence INT(2) DEFAULT NULL COMMENT '次序',\n" +
                    "\tstatus INT (2) DEFAULT NULL COMMENT '状态 0.禁用 1.启用',\n" +
                    "\tis_valid INT (11) DEFAULT NULL COMMENT '是否有效 0.无效 1.有效',\n" +
                    "\tcreate_date datetime DEFAULT NULL COMMENT '创建时间',\n" +
                    "\tcreate_user BIGINT (20) DEFAULT NULL COMMENT '创建人',\n" +
                    "\tupdate_date datetime DEFAULT NULL COMMENT '更新时间',\n" +
                    "\tupdate_user BIGINT (20) DEFAULT NULL COMMENT '更新人'\n" +
                    ")";
            stm.executeUpdate(sql);
            System.out.println("Table :" + sysRoleTableName + " 创建成功！");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 创建用户角色表
     */
    public static void createUserRoleTable() {
        String sysUserRoleTableName = "sys_user_role";
        if (config.getSysUserRole() != null) {
            sysUserRoleTableName = config.getSysUserRole();
        }
        try {
            Connection conn = ConnectionUtil.getConn();
            Statement stm = conn.createStatement();
            String sql = "CREATE TABLE "+sysUserRoleTableName +"(\n" +
                    "\tid BIGINT (20) PRIMARY KEY AUTO_INCREMENT COMMENT 'id',\n" +
                    "\tuser_id BIGINT (32) NOT NULL COMMENT '用户id',\n" +
                    "\trole_id VARCHAR (32) NOT NULL COMMENT '角色id',\n" +
                    "\tis_valid INT (11) DEFAULT NULL COMMENT '是否有效 0.无效 1.有效',\n" +
                    "\tcreate_date datetime DEFAULT NULL COMMENT '创建时间',\n" +
                    "\tcreate_user BIGINT (20) DEFAULT NULL COMMENT '创建人',\n" +
                    "\tupdate_date datetime DEFAULT NULL COMMENT '更新时间',\n" +
                    "\tupdate_user BIGINT (20) DEFAULT NULL COMMENT '更新人'\n" +
                    ")";
            stm.executeUpdate(sql);
            System.out.println("Table :" + sysUserRoleTableName + " 创建成功！");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 创建权限表
     */
    public static void createPermissionTable() {
        String sysPermissionTableName = "sys_permission";
        if (config.getSysPermission() != null) {
            sysPermissionTableName = config.getSysPermission();
        }
        try {
            Connection conn = ConnectionUtil.getConn();
            Statement stm = conn.createStatement();
            String sql = "CREATE TABLE " + sysPermissionTableName+" (\n" +
                    "  id BIGINT(20) PRIMARY KEY AUTO_INCREMENT COMMENT 'id',\n" +
                    "  permission_name VARCHAR(128) DEFAULT NULL COMMENT '权限名称',\n" +
                    "  parent_id VARCHAR(128) DEFAULT NULL COMMENT '父级权限id',\n" +
                    "  permission_url VARCHAR(128) DEFAULT NULL COMMENT '权限URL',\n" +
                    "  sequence INT(2) DEFAULT NULL COMMENT '次序',\n" +
                    "  layer INT(2) DEFAULT NULL COMMENT '层级',\n" +
                    "  permission_icon VARCHAR(64) DEFAULT NULL,\n" +
                    "  is_valid INT(11) DEFAULT NULL COMMENT '是否有效0.无效 1.有效',\n" +
                    "  create_date datetime DEFAULT NULL COMMENT '创建时间',\n" +
                    "  create_user BIGINT(20) DEFAULT NULL COMMENT '创建人',\n" +
                    "  update_date datetime DEFAULT NULL COMMENT '更新时间',\n" +
                    "  update_user BIGINT(20) DEFAULT NULL COMMENT '更新人'\n" +
                    ")";
            stm.executeUpdate(sql);
            System.out.println("Table :" + sysPermissionTableName + " 创建成功！");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 创建角色权限表
     */
    public static void createRolePermissionTable() {
        String sysRolePermissionTableName = "sys_role_permission";
        if (config.getSysRolePermission() != null) {
            sysRolePermissionTableName = config.getSysRolePermission();
        }
        try {
            Connection conn = ConnectionUtil.getConn();
            Statement stm = conn.createStatement();
            String sql = "CREATE TABLE " + sysRolePermissionTableName +" (\n" +
                    "  id bigint(20) PRIMARY KEY AUTO_INCREMENT COMMENT 'id',\n" +
                    "  role_id varchar(32) NOT NULL COMMENT '角色id',\n" +
                    "  permission_id varchar(32) NOT NULL COMMENT '权限id',\n" +
                    "  is_valid int(11) DEFAULT NULL COMMENT '是否有效0.无效 1.有效',\n" +
                    "  create_date datetime DEFAULT NULL COMMENT '创建时间',\n" +
                    "  create_user bigint(20) DEFAULT NULL COMMENT '创建人',\n" +
                    "  update_date datetime DEFAULT NULL COMMENT '更新时间',\n" +
                    "  update_user bigint(20) DEFAULT NULL COMMENT '更新人'\n" +
                    ")";
            stm.executeUpdate(sql);
            System.out.println("Table :" + sysRolePermissionTableName + " 创建成功！");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 释放连接
     */
    public static void close() {
        ConnectionUtil.realseConn();
    }
}
