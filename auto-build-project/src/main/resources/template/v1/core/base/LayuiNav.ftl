package ${basePackage};

import java.util.List;

/**
 * layui导航栏model
 */
public class LayuiNav {
    /**id*/
    private java.lang.Long id;
    /**菜单名称*/
    private java.lang.String title;
    /**菜单图标*/
    private java.lang.String icon;
    /**菜单url*/
    private java.lang.String href;
    /**菜单选中*/
    private java.lang.Boolean spread;
    /**子导航菜单*/
    private List<LayuiNav> children;

    public Long getId() {
    	return id;
    }

    public void setId(Long id) {
    	this.id = id;
    }

    public String getTitle() {
    	return title;
    }

    public void setTitle(String title) {
    	this.title = title;
    }

    public String getIcon() {
    	return icon;
    }

    public void setIcon(String icon) {
    	this.icon = icon;
    }

    public String getHref() {
    	return href;
    }

    public void setHref(String href) {
    	this.href = href;
    }

    public Boolean getSpread() {
    	return spread;
    }

    public void setSpread(Boolean spread) {
    	this.spread = spread;
    }

    public List<LayuiNav> getChildren() {
        return children;
    }

	public void setChildren(List<LayuiNav> children) {
        this.children = children;
    }
}