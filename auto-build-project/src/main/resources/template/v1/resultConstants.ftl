package ${constantsPackage};

/**
 * 通用返回code码 和 msg信息
 *
 */
public enum ResultConstants {
    FAILED(0,"失败"),
    SUCCESS(1,"成功");

    private int code;
    private String msg;

    ResultConstants(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
