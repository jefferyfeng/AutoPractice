package ${basePackage};

import ${constantsPackage}.Direction;

public class Order {
    /** 属性名 */
    private String property;
    /** 方向 */
    private Direction direction;

    private Order() {
    }

    public Order(String property, Direction direction) {
        this.property = property;
        this.direction = direction;
    }

    public String getProperty() {
        return property;
    }

    public Direction getDirection() {
        return direction;
    }

    public static Order asc(String fieldName){
        return new Order(fieldName,Direction.ASC);
    }

    public static Order desc(String fieldName){
        return new Order(fieldName,Direction.DESC);
    }
}
