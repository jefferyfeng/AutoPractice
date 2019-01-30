package ${constantsPackage};

/**
 * 操作符
 *
 * @author fdh
 */
public enum Operator {
    /**等于*/
    EQ,
    /**不等于*/
    NOTEQ,
    /**包含字符*/
    CONTAIN,
    /**不包含字符*/
    NOTCONTAIN,
    /**以某些字符打头*/
    STARTWITH,
    /**不以某些字符打头*/
    NOTSTARTWITH,
    /**以某些字符结尾*/
    ENDWITH,
    /**不以某些字符结尾*/
    NOTENDWITH,
    /**大于*/
    GT,
    /**小于*/
    LT,
    /**大于等于*/
    GE,
    /**小于等于*/
    LE,
    /**所属集合*/
    IN,
    /**不所属集合*/
    NOTIN,
    /**为空*/
    ISNULL,
    /**不为空*/
    ISNOTNULL;
}
