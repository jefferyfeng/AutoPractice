package ${basePackage};

import java.util.List;

/**
 * ZTree Model
 */
public class ZTree {
    /**节点的唯一标识*/
    private String id;
    /**节点的父节点，用来标识层级:如果不写或为null，则该节点为根节点*/
    private String pId;
    /**节点名称*/
    private String name;
    /**记录 treeNode 节点的展开 / 折叠状态*/
    private String open;
    /**节点的 checkBox / radio 的勾选状态*/
    private String checked;
    /**是否禁用*/
    private String chkDisabled;
    /**是否有孩子*/
    private String isParent;
    /**孩子节点*/
    private List<ZTree> children;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getpId() {
        return pId;
    }

    public void setpId(String pId) {
        this.pId = pId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOpen() {
        return open;
    }

    public void setOpen(String open) {
        this.open = open;
    }

    public String getChecked() {
        return checked;
    }

    public void setChecked(String checked) {
        this.checked = checked;
    }

    public String getChkDisabled() {
        return chkDisabled;
    }

    public void setChkDisabled(String chkDisabled) {
        this.chkDisabled = chkDisabled;
    }

    public String getIsParent() {
        return isParent;
    }

    public void setIsParent(String isParent) {
        this.isParent = isParent;
    }

    public List<ZTree> getChildren() {
        return children;
    }

    public void setChildren(List<ZTree> children) {
        this.children = children;
    }
}
