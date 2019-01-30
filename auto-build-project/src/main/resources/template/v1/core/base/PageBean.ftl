package ${basePackage};

import java.io.Serializable;

/**
 * PageBean分页bean
 *
 * @author fdh
 */
public class PageBean implements Serializable{
    /*
     * 定义数据库 分页操作的起始索引
     * MySQL index = 0
     * Oracle index = 1
     */
    private static final Integer DB_INDEX_START = 0;
    private static final Integer DEFAULT_PAGE = 1;
    private static final Integer DEFAULT_PAGESIZE = 10;
    //当前页
    private Integer currentPage;
    //总条数
    private Integer total;
    //页面容量
    private Integer pageSize;

    //起始条
    private Integer begin;
    //结束条
    private Integer end;
    //最大页码
    private Integer maxPage;
    //当前页取得条数
    private Integer pageCount;

    /**
     * 默认构造方法
     */
    public PageBean() {
        this.currentPage = DEFAULT_PAGE;
        this.pageSize = DEFAULT_PAGESIZE;
    }

    public PageBean(Integer currentPage, Integer pageSize) {
        this.currentPage = currentPage;
        this.pageSize = pageSize;
    }

    public Integer getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(Integer currentPage) {
        this.currentPage = currentPage;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public Integer getBegin() {
        return begin;
    }

    public Integer getEnd() {
        return end;
    }

    public Integer getPageCount() {
        return pageCount;
    }

    //通过传入总条数计算各个参数值
    public void setAll(Integer total){
        this.total = total;
        //处理无效页码 和 无效页面容量
        currentPage = ( (currentPage == null || currentPage <= 0) ? DEFAULT_PAGE : currentPage ) ;
        pageSize = ( (pageSize == null || pageSize <= 0) ? DEFAULT_PAGESIZE : pageSize ) ;

        //计算每个结果
        maxPage = total % pageSize == 0 ? total / pageSize : total / pageSize +1;
        begin = (currentPage - 1) * pageSize + DB_INDEX_START;
        end = currentPage == maxPage ? total - 1 + DB_INDEX_START : currentPage * pageSize -1 + DB_INDEX_START;
        pageCount = end - begin + 1;
    }
}

