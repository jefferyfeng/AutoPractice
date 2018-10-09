package authority;

import util.ConnectionUtil;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class BaseDBTables {
    /**
     * 创建用户表
     */
    public static void createUserTable(){
        try {
            Connection conn = ConnectionUtil.getConn();
            Statement stm = conn.createStatement();
            String sql = "CREATE TABLE boss_user (\n" +
                    "  id bigint(20) PRIMARY KEY AUTO_INCREMENT COMMENT 'id' ,\n" +
                    "  username varchar(40) NOT NULL UNIQUE COMMENT '用户名' ,\n" +
                    "  password varchar(40) DEFAULT NULL COMMENT '密码',\n" +
                    "  user_name varchar(32) DEFAULT NULL COMMENT '姓名',\n" +
                    "  sex int(2) DEFAULT NULL COMMENT '性别',\n" +
                    "  type int(11) DEFAULT NULL COMMENT '类型:0.总管理员/1.管理员/2.管理员',\n" +
                    "  email varchar(32) DEFAULT NULL UNIQUE COMMENT '邮箱',\n" +
                    "  mobile varchar(32) DEFAULT NULL UNIQUE COMMENT '手机号',\n" +
                    "  salt varchar(32) DEFAULT NULL COMMENT '盐值',\n" +
                    "  user_status int(11) DEFAULT '1' COMMENT '用户状态 0.禁用/1.启用',\n" +
                    "  last_login_time datetime DEFAULT NULL COMMENT '最近一次的登陆时间',\n" +
                    "  is_valid int(1) DEFAULT NULL COMMENT '是否有效 0.无效 /1.有效',\n" +
                    "  create_date datetime DEFAULT NULL COMMENT '创建日期',\n" +
                    "  create_user bigint(20) DEFAULT NULL COMMENT '创建人',\n" +
                    "  update_date datetime DEFAULT NULL COMMENT '更新日期',\n" +
                    "  update_user bigint(20) DEFAULT NULL COMMENT '更新人'\n" +
                    ")";
            stm.executeUpdate(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void createRole(){
        try {
            Connection conn = ConnectionUtil.getConn();
            Statement stm = conn.createStatement();
            String sql = "CREATE TABLE boss_role (\n" +
                    "  id bigint(20) PRIMARY KEY AUTO_INCREMENT COMMENT 'id',\n" +
                    "  role_name varchar(255) DEFAULT NULL COMMENT '角色名称',\n" +
                    "  description varchar(255) DEFAULT NULL COMMENT '角色描述',\n" +
                    "  status int(2) DEFAULT NULL COMMENT '状态 0禁用 1启用',\n" +
                    "  is_valid int(11) DEFAULT NULL COMMENT '是否有效 0.无效 /1.有效',\n" +
                    "  create_date datetime DEFAULT NULL COMMENT '创建日期',\n" +
                    "  create_user bigint(20) DEFAULT NULL COMMENT '创建人',\n" +
                    "  update_date datetime DEFAULT NULL COMMENT '更新日期',\n" +
                    "  update_user bigint(20) DEFAULT NULL COMMENT '更新人'\n" +
                    ")";
            stm.executeUpdate(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public static void release(){
        ConnectionUtil.realseConn();
    }
}
