package ${controllerPackage};

import ${config.groupId}.core.base.BaseResult;
import ${basePackage}.PageBean;
import ${config.groupId}.core.util.ResultUtil;
import ${config.groupId}.core.constants.Constants;
import ${config.groupId}.core.constants.ResultConstants;
import ${modelPackage}.${tableModel.tableName};
import ${config.groupId}.core.constants.Constants;
<#if config.sysUser == tableModel.tableNameDB>import ${modelPackage}.${SysRole};</#if>
import ${servicePackage}.${tableModel.tableName}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *  ${tableModel.tableName}Controller  <#if tableModel.comment??>${tableModel.comment}控制器</#if>
 *
 *  @author fdh
 */
@RequestMapping("/${tableModel.tableNameLowFirstChar}")
@RestController
public class ${tableModel.tableName}Controller {
    @Autowired
    private ${tableModel.tableName}Service ${tableModel.tableNameLowFirstChar}Service;
    <#if config.sysUser == tableModel.tableNameDB>
    @Autowired
    private ${SysRole}Service ${sysRole}Service;
    </#if>

    /**
     * 新增${tableModel.tableName}
     * @param ${tableModel.tableNameLowFirstChar}
     */
    @RequestMapping(value="/add", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
    public BaseResult add(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        ${tableModel.tableNameLowFirstChar}Service.add(${tableModel.tableNameLowFirstChar});
        return ResultUtil.result(ResultConstants.SUCCESS);
    }

    /**
     * 删除${tableModel.tableName} (物理删除)
     * @param ${pkColumnModel.columnName}
     */
    /*
    @RequestMapping(value="/delete", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
    public BaseResult delete(${pkColumnModel.columnType} ${pkColumnModel.columnName}){
        ${tableModel.tableNameLowFirstChar}Service.delete(${pkColumnModel.columnName});
        return ResultUtil.result(ResultConstants.SUCCESS);
    }
    */

    /**
     * 删除${tableModel.tableName} (逻辑删除)
     * @param ${pkColumnModel.columnName}
     */
    @RequestMapping(value="/remove", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
    public BaseResult remove(${pkColumnModel.columnType} ${pkColumnModel.columnName}){
        ${tableModel.tableNameLowFirstChar}Service.remove(${pkColumnModel.columnName});
        return ResultUtil.result(ResultConstants.SUCCESS);
    }

    /**
     * 修改${tableModel.tableName}
     * @param ${tableModel.tableNameLowFirstChar}
     */
    @RequestMapping(value="/modify", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
    public BaseResult modify(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        ${tableModel.tableNameLowFirstChar}Service.modify(${tableModel.tableNameLowFirstChar});
        return ResultUtil.result(ResultConstants.SUCCESS);
    }

    /**
     * 查询单个${tableModel.tableName}
     * @param ${pkColumnModel.columnName}
     */
    @RequestMapping(value="/queryOne/{${pkColumnModel.columnName}}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.GET)
    public BaseResult queryOne(@PathVariable(value="${pkColumnModel.columnName}")${pkColumnModel.columnType} ${pkColumnModel.columnName}){
        Map<String,Object> bodyMap = new HashMap<String,Object>();
        ${tableModel.tableName} ${tableModel.tableNameLowFirstChar} = ${tableModel.tableNameLowFirstChar}Service.queryOne(${pkColumnModel.columnName});
        bodyMap.put("${tableModel.tableNameLowFirstChar}",${tableModel.tableNameLowFirstChar});
        return ResultUtil.result(ResultConstants.SUCCESS,bodyMap);
    }

    /**
     * 查全部${tableModel.tableName}
     */
    @RequestMapping(value="/queryAll", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.GET)
    public BaseResult queryAll(){
        Map<String,Object> bodyMap = new HashMap<String,Object>();
        List<${tableModel.tableName}> ${tableModel.tableNameLowFirstChar}s = ${tableModel.tableNameLowFirstChar}Service.queryAll();
        bodyMap.put("${tableModel.tableNameLowFirstChar}s",${tableModel.tableNameLowFirstChar}s);
        return ResultUtil.result(ResultConstants.SUCCESS,bodyMap);
    }

    /**
     * 根据字段查询（如需分页请setPageBean）
     * @param ${tableModel.tableNameLowFirstChar}
     */
    @RequestMapping(value="/queryByFieldsAndPage", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.GET)
    public BaseResult queryByFieldsAndPage(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}){
        Map<String,Object> bodyMap = new HashMap<String,Object>();
        List<${tableModel.tableName}> ${tableModel.tableNameLowFirstChar}s = ${tableModel.tableNameLowFirstChar}Service.queryByFieldsAndPage(${tableModel.tableNameLowFirstChar});
        bodyMap.put("${tableModel.tableNameLowFirstChar}s",${tableModel.tableNameLowFirstChar}s);
        bodyMap.put("pageBean",${tableModel.tableNameLowFirstChar}.getPageBean());
        return ResultUtil.result(ResultConstants.SUCCESS,bodyMap);
    }

    /**
     * 批量删除
     * @param ${pkColumnModel.columnName}s
     */
    @RequestMapping(value="/batchRemove", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
    public BaseResult batchRemove(@RequestParam("${pkColumnModel.columnName}s[]") Long[] ${pkColumnModel.columnName}s){
        ${tableModel.tableNameLowFirstChar}Service.batchRemove(${pkColumnModel.columnName}s);
        return ResultUtil.result(ResultConstants.SUCCESS);
    }

    <#list tableModel.columnModelList as columnModel>
        <#if columnModel.columnName?contains("status")>
    /**
     * 批量状态修改
     * @return
     */
    @RequestMapping(value="/batchModifyStatus", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
    public BaseResult batchModifyStatus(@RequestParam("${pkColumnModel.columnName}s[]") Long[] ${pkColumnModel.columnName}s,@RequestParam(value = "status",required = true)Integer status){
        ${tableModel.tableNameLowFirstChar}Service.batchModifyStatus(${pkColumnModel.columnName}s,status);
        return ResultUtil.result(ResultConstants.SUCCESS);
    }
        </#if>
    </#list>


    <#-- 权限相关 -->
    <#if config.sysUser == tableModel.tableNameDB><#-- 用户表 -->
    /**
     * 跳转到用户管理页面
     * @param modelAndView
     * @return
     */
    @RequestMapping("/toUsers")
    public ModelAndView toUsers(ModelAndView modelAndView){
        List<${SysRole}> rolesList = ${sysRole}Service.queryAll();
        modelAndView.addObject("rolesList",rolesList);
        modelAndView.setViewName("modules/per/${tableModel.tableNameLowFirstChar}/${tableModel.tableNameLowFirstChar}_list");
        return modelAndView;
    }

    /**
    * 跳转到用户添加页面
    * @param modelAndView
    * @return
    */
    @RequestMapping("/toAddUser")
        public ModelAndView toAddUser(ModelAndView modelAndView){
        modelAndView.setViewName("modules/per/${tableModel.tableNameLowFirstChar}/${tableModel.tableNameLowFirstChar}_add");
        return modelAndView;
    }

    /**
    * 跳转到用户管理页面
    * @param userId 用户id
    * @param modelAndView
    * @return
    */
    @RequestMapping("/toEditUser")
        public ModelAndView toEditUser(@@RequestParam("userId") ${pkColumnModel.columnType} userId, ModelAndView modelAndView){
        UserVo userVo = perService.queryUser(userId);
        modelAndView.addObject("userVo",userVo);
        modelAndView.setViewName("modules/per/${tableModel.tableNameLowFirstChar}/${tableModel.tableNameLowFirstChar}_edit");
        return modelAndView;
    }

    /**
    * 跳转到角色配置页面
    * @param userId 用户id
    * @param modelAndView
    * @return
    */
    @RequestMapping("/toUserRoleEdit")
        public ModelAndView toUserRoleEdit(@RequestParam("userId")${pkColumnModel.columnType} userId, ModelAndView modelAndView){
        modelAndView.addObject("userId",userId);
        modelAndView.setViewName("modules/per/${tableModel.tableNameLowFirstChar}/${tableModel.tableNameLowFirstChar}_role_edit");
        return modelAndView;
    }

    /**
    * 获取用户数据表格
    * @param user
    * @param pageBean
    * @return
    */
    @RequestMapping(value = "/listUsers",produces = MediaType.APPLICATION_JSON_UTF8_VALUE,method=RequestMethod.GET)
    public LayuiData listUsers(UserVo user, PageBean pageBean){
        LayuiData layuiData = new LayuiData();
        List<UserVo> usersList = ${tableModel.tableNameLowFirstChar}Service.listUsersByPage(user,pageBean);
        layuiData.setCode(ResultConstants.SUCCESS.getCode());
        layuiData.setMsg(ResultConstants.SUCCESS.getMsg());
        layuiData.setCount(pageBean.getTotal());
        layuiData.setData(usersList);
        return layuiData;
    }

    /**
    * 新增${tableModel.tableName}
    * @param ${tableModel.tableNameLowFirstChar}
    */
    @RequestMapping(value="/addUser", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
    public BaseResult addUser(${tableModel.tableName} ${tableModel.tableNameLowFirstChar}) {
        ${tableModel.tableNameLowFirstChar}Service.addUser(${tableModel.tableNameLowFirstChar});
        return ResultUtil.result(ResultConstants.SUCCESS);
    }

    /**
    * 重置密码
    * @param ${pkColumnModel.columnName}s 用户ids
    * @return
    */
    @RequestMapping(value="/resetPassword", produces = MediaType.APPLICATION_JSON_UTF8_VALUE ,method = RequestMethod.POST)
    public BaseResult resetPassword(@RequestParam("${pkColumnModel.columnName}s[]") ${pkColumnModel.columnType}[] ${pkColumnModel.columnName}s){
        ${tableModel.tableNameLowFirstChar}Service.resetPassword(${pkColumnModel.columnName}s);
        return ResultUtil.result(ResultConstants.SUCCESS);
    }


    /**
    * 批量删除用户
    * @param ids
    * @return
    */
    @RequestMapping(value="/batchRemoveUsers", produces = MediaType.APPLICATION_JSON_UTF8_VALUE ,method = RequestMethod.POST)
    public BaseResult batchRemoveUsers(@RequestParam("${pkColumnModel.columnName}s[]") ${pkColumnModel.columnType}[] ${pkColumnModel.columnName}s){
        ${tableModel.tableNameLowFirstChar}Service.batchRemoveUsers(${pkColumnModel.columnName}s);
        return ResultUtil.result(ResultConstants.SUCCESS);
    }

    /**
    * 跳转到修改密码
    */
    @RequestMapping("/toChangePwd")
    public ModelAndView toChangePwd(ModelAndView modelAndView){
        modelAndView.setViewName("modules/per/${tableModel.tableNameLowFirstChar}/${tableModel.tableNameLowFirstChar}_pwd_edit");
        return modelAndView;
    }

    /**
    * 跳转到用户信息
    */
    @RequestMapping("/toUserInfo")
    public ModelAndView toUserInfo(ModelAndView modelAndView){
        modelAndView.setViewName("modules/per/${tableModel.tableNameLowFirstChar}/${tableModel.tableNameLowFirstChar}_info");
        return modelAndView;
    }


    /**
    * 修改密码
    * @param userId 用户id
    * @param oldPwd 原始密码
    * @param newPwd 新密码
    * @return
    */
    @RequestMapping(value="/changePwd", produces = MediaType.APPLICATION_JSON_UTF8_VALUE ,method = RequestMethod.POST)
    public BaseResult resetPassword(Long userId,String oldPwd,String newPwd){
        try {
            ${tableModel.tableNameLowFirstChar}Service.changePwd(userId, oldPwd, newPwd);
            return ResultUtil.result(ResultConstants.SUCCESS);
        } catch (UserException e) {
            return ResultUtil.result(ResultConstants.FAILED.getCode(),e.getMessage());
        }
    }
    <#elseif config.sysRole == tableModel.tableNameDB><#-- 角色表 -->
    /**
     * 跳转到角色列表页面
     */
    @RequestMapping("/toRoles")
    public ModelAndView toRoles(ModelAndView modelAndView){
        modelAndView.setViewName("modules/per/${tableModel.tableNameLowFirstChar}/${tableModel.tableNameLowFirstChar}_list");
        return modelAndView;
    }


    /**
     * 跳转到角色添加页面
     */
    @RequestMapping("/toAddRole")
    public ModelAndView toAddRoles(ModelAndView modelAndView){
        modelAndView.setViewName("modules/per/${tableModel.tableNameLowFirstChar}/${tableModel.tableNameLowFirstChar}_add");
        return modelAndView;
    }

    /**
     * 跳转到角色修改页面
     */
    @RequestMapping("/toEditRole")
    public ModelAndView toEditRole(@RequestParam("roleId") ${pkColumnModel.columnType} roleId,ModelAndView modelAndView){
        ${tableModel.tableName} role = sysRoleService.queryOne(roleId);
        modelAndView.addObject("role",role);
        modelAndView.setViewName("modules/per/${tableModel.tableNameLowFirstChar}/${tableModel.tableNameLowFirstChar}_edit");
        return modelAndView;
    }

    /**
     * 跳转到角色配置页面
     */
    @RequestMapping("/toEditRolePermission")
    public ModelAndView toEditRolePermission(@RequestParam("roleId") ${pkColumnModel.columnType} roleId,ModelAndView modelAndView){
        modelAndView.addObject("roleId",roleId);
        modelAndView.setViewName("modules/per/${tableModel.tableNameLowFirstChar}/${tableModel.tableNameLowFirstChar}_permission_edit");
        return modelAndView;
    }

    /**
     * 获取角色数据表格
     * @param role
     * @param pageBean
     * @return
     */
    @RequestMapping("/listRoles")
    public LayuiData listRoles(RoleVo role, PageBean pageBean){
        LayuiData layuiData = new LayuiData();
        try {
            List<RoleVo> rolesList = ${tableModel.tableNameLowFirstChar}Service.listRolesByPage(role,pageBean);
            layuiData.setCode(0);
            layuiData.setMsg("成功!");
            layuiData.setCount(pageBean.getTotal());
            layuiData.setData(rolesList);
            return layuiData;
        } catch (Exception e) {
            e.printStackTrace();
            layuiData.setCode(1);
            layuiData.setMsg("失败!");
            return layuiData;
        }
    }
    <#elseif config.sysPermission == tableModel.tableNameDB><#-- 权限菜单表 -->
    /**
     * 获取权限菜单
     * @param parentId
     * @return
     */
    @RequestMapping("/listAllLayuiNavs/{parentId}")
    public BaseResult getAllLayuiNavs(@PathVariable("parentId") Long parentId){
        Map<String,Object> bodyMap = new HashMap<String,Object>();

        UserVo userVo = (UserVo) MyUtil.getSession().getAttribute("user");
        List<LayuiNav> navsList = ${tableModel.tableNameLowFirstChar}Service.listAllNavsByParentId(parentId, userVo.getPermissions());

        bodyMap.put("navsList",navsList);
        return ResultUtil.result(ResultConstants.SUCCESS,bodyMap);
    }


    /**
     * 跳转到权限菜单管理页面
     */
    @RequestMapping("/toPermissions")
    public ModelAndView toPermissions(ModelAndView modelAndView){
        modelAndView.setViewName("modules/per/${tableModel.tableNameLowFirstChar}/${tableModel.tableNameLowFirstChar}_list");
        return modelAndView;
    }

    /**
     * 跳转到添加下级权限菜单页面
     */
    @RequestMapping("/toAddChildPermission")
    public ModelAndView toAddChildPermission(@RequestParam("parentId")Long parentId, ModelAndView modelAndView){
        ${tableModel.tableName} parentPermission = ${tableModel.tableNameLowFirstChar}Service.queryOne(parentId);
        Integer sequence = ${tableModel.tableNameLowFirstChar}Service.queryMaxSequence(parentId);
        modelAndView.addObject("parentPermission",parentPermission);
        modelAndView.addObject("sequence",sequence==null ? "无":sequence);
        modelAndView.setViewName("modules/per/${tableModel.tableNameLowFirstChar}/${tableModel.tableNameLowFirstChar}_addChild");
        return modelAndView;
    }

    /**
     * 跳转到添加同级权限菜单页面
     */
    @RequestMapping("/toAddBrotherPermission")
    public ModelAndView toAddBrotherPermission(@RequestParam("brotherId")Long brotherId, ModelAndView modelAndView){
        ${tableModel.tableName} childPermission = ${tableModel.tableNameLowFirstChar}Service.queryOne(brotherId);
        ${tableModel.tableName} parentPermission = ${tableModel.tableNameLowFirstChar}Service.queryOne(Long.valueOf(childPermission.getParentId()));
        Integer sequence = ${tableModel.tableNameLowFirstChar}Service.queryMaxSequence(Long.valueOf(parentPermission.getId()));
        modelAndView.addObject("parentPermission",parentPermission);
        modelAndView.addObject("sequence",sequence==null ? "无":sequence);
        modelAndView.setViewName("modules/per/${tableModel.tableNameLowFirstChar}/${tableModel.tableNameLowFirstChar}_addBrother");
        return modelAndView;
    }

    /**
     * 跳转修改权限菜单页面
     */
    @RequestMapping("/toEditPermission")
    public ModelAndView toEditPermission(@RequestParam("permissionId")Long permissionId, ModelAndView modelAndView){
        ${tableModel.tableName} permission = ${tableModel.tableNameLowFirstChar}Service.queryOne(permissionId);
        Integer sequence = ${tableModel.tableNameLowFirstChar}Service.queryMaxSequence(Long.valueOf(permission.getParentId()));
        modelAndView.addObject("permission",permission);
        modelAndView.addObject("sequence",sequence==null ? "无":sequence);
        modelAndView.setViewName("modules/per/${tableModel.tableNameLowFirstChar}/${tableModel.tableNameLowFirstChar}_edit");
        return modelAndView;
    }

    /**
     * 获取所有权限菜单
     */
    @RequestMapping("/listPermissions")
    public List<ZTree> listPermissions(@RequestParam(value = "id",required = false) String id){
        Long parentId = null;
        if(MyUtil.isEmpty(id)){
            parentId = 0L;
        }else{
            parentId = Long.valueOf(id);
        }
        List<ZTree> permissionList = ${tableModel.tableNameLowFirstChar}Service.queryZTreePermissions(parentId);
        return permissionList;
    }

    /**
     * 删除菜单
     */
    @RequestMapping("/removePermission")
    public BaseResult removePermission(@RequestParam("permissionId") Long permissionId){
        //TODO 越级删除校验
        ${tableModel.tableNameLowFirstChar}Service.removePermission(permissionId);
        return ResultUtil.result(ResultConstants.SUCCESS);
    }
    <#elseif config.sysUserRole == tableModel.tableNameDB><#-- 用户角色表 -->
    /**
     * 获取用户角色配置数据表格
     * @param pageBean 分页bean
     * @param userId 用户id
     * @return
     */
    @RequestMapping(value="/listUserRoles", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.GET)
    public LayuiData listUserRoles(PageBean pageBean, Long userId){
        LayuiData layuiData = new LayuiData();
        Object roleList = ${tableModel.tableNameLowFirstChar}Service.listUserRolesByPage(pageBean, userId);
        layuiData.setCode(ResultConstants.SUCCESS.getCode());
        layuiData.setMsg(ResultConstants.SUCCESS.getMsg());
        layuiData.setCount(pageBean.getTotal());
        layuiData.setData(roleList);
        return layuiData;
    }

    /**
     * 修改用户的角色
     * @param checkedIds 选中的角色ids
     * @param uncheckedIds 未选中的角色ids
     * @param userId 用户的id
     * @return
     */
    @RequestMapping(value="/editUserRole", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
    public BaseResult editUserRole(@RequestParam("checkedIds") String checkedIds,
                                   @RequestParam("uncheckedIds") String uncheckedIds,
                                   @RequestParam(value = "userId",required = true)Long userId){
        ${tableModel.tableNameLowFirstChar}Service.editUserRole(checkedIds, uncheckedIds, userId);
        return ResultUtil.result(ResultConstants.SUCCESS);
    }
    <#elseif config.sysRolePermission == tableModel.tableNameDB><#-- 角色权限表 -->
    /**
     * 获取角色所有权限菜单
     *
     * @return
     */
    @RequestMapping("/listRolePermissions/{roleId}")
    public List<ZTree> listRolePermissions(@PathVariable("roleId") Long roleId){
        List<ZTree> permissionList = ${tableModel.tableNameLowFirstChar}Service.queryZTreeAllPermissions(roleId);
        return permissionList;
    }

    /**
     * @description 根据角色配置菜单权限
     *
     * @param uncheckedPermissionIds 未选中的权限菜单
     * @param checkedPermissionIds 选中的权限菜单
     * @param roleId 配置权限菜单的角色id
     * @return
     */
    @RequestMapping("/editRolePermission")
    public BaseResult deletePermission(@RequestParam("checkedPermissionIds") String checkedPermissionIds,
                                       @RequestParam("uncheckedPermissionIds")String uncheckedPermissionIds,
                                       @RequestParam("roleId") Long roleId){
        ${tableModel.tableNameLowFirstChar}Service.editRolePermission(checkedPermissionIds,uncheckedPermissionIds,roleId);
        return ResultUtil.result(ResultConstants.SUCCESS);
    }
    </#if>

}