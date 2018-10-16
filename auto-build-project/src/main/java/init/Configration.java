package init;

/**
 * 配置文件对应实体
 * @author fdh
 */
public class Configration {
    /**
     * boss 基础部分
     */
    private String groupId;
    private String projectName;
    private String dbType;
    //private String dbIp; 加载配置文件的时候合并为dbUrl
    private String dbUrl;
    private String username;
    private String password;
    private String baseBossDir;
    //模板版本
    private String templateUrl;
    //项目包名命名习惯
    private String entityPackageName;
    private String daoPackageName;
    private String servicePackageName;
    private String controllerPackageName;
    //shiro基础表
    private String sysUser;
    private String sysRole;
    private String sysUserRole;
    private String sysPermission;
    private String sysRolePermission;
    /**
     * 子模块
     */
    private String tableName;

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getDbType() {
        return dbType;
    }

    public void setDbType(String dbType) {
        this.dbType = dbType;
    }

    public String getDbUrl() {
        return dbUrl;
    }

    public void setDbUrl(String dbUrl) {
        this.dbUrl = dbUrl;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getBaseBossDir() {
        return baseBossDir;
    }

    public void setBaseBossDir(String baseBossDir) {
        this.baseBossDir = baseBossDir;
    }

    public String getTemplateUrl() {
        return templateUrl;
    }

    public void setTemplateUrl(String templateUrl) {
        this.templateUrl = templateUrl;
    }

    public String getEntityPackageName() {
        return entityPackageName;
    }

    public void setEntityPackageName(String entityPackageName) {
        this.entityPackageName = entityPackageName;
    }

    public String getDaoPackageName() {
        return daoPackageName;
    }

    public void setDaoPackageName(String daoPackageName) {
        this.daoPackageName = daoPackageName;
    }

    public String getServicePackageName() {
        return servicePackageName;
    }

    public void setServicePackageName(String servicePackageName) {
        this.servicePackageName = servicePackageName;
    }

    public String getControllerPackageName() {
        return controllerPackageName;
    }

    public void setControllerPackageName(String controllerPackageName) {
        this.controllerPackageName = controllerPackageName;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getSysUser() {
        return sysUser;
    }

    public void setSysUser(String sysUser) {
        this.sysUser = sysUser;
    }

    public String getSysRole() {
        return sysRole;
    }

    public void setSysRole(String sysRole) {
        this.sysRole = sysRole;
    }

    public String getSysUserRole() {
        return sysUserRole;
    }

    public void setSysUserRole(String sysUserRole) {
        this.sysUserRole = sysUserRole;
    }

    public String getSysPermission() {
        return sysPermission;
    }

    public void setSysPermission(String sysPermission) {
        this.sysPermission = sysPermission;
    }

    public String getSysRolePermission() {
        return sysRolePermission;
    }

    public void setSysRolePermission(String sysRolePermission) {
        this.sysRolePermission = sysRolePermission;
    }
}
