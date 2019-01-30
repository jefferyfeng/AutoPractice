package ${constantsPackage};

/**
 * 排序方向
 *
 * @author fdh
 */
public enum Direction {
    /**递增*/
    ASC("asc"),
    /**递减*/
    DESC("desc");
    private String sql;

    Direction(String sql) {
        this.sql = sql;
    }

    @Override
    public String toString() {
        return sql;
    }
}