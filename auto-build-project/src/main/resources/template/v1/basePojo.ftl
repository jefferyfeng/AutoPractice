package ${basePackage};

/**
 * 基础类，所有pojo都要继承
 *
 * @author fdh
 */
public class BasePojo implements java.io.Serializable{

	/**
	 * 序列化ID
	 */
	private static final long serialVersionUID = 6795255294545467100L;

	/**
	 * 分页类
	 */
	private PageBean pageBean;

	public PageBean getPageBean() {
		return (pageBean==null ? new PageBean() : pageBean);
	}

	public void setPageBean(PageBean pageBean) {
		this.pageBean = pageBean;
	}

}
