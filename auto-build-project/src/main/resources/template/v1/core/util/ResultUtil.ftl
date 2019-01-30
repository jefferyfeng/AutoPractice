package ${utilPackage};

import ${basePackage}.BaseResult;
import ${constantsPackage}.ResultConstants;

/**
 * ResultUtil 返回通用的BaseResult
 *
 */
public class ResultUtil{
    public static BaseResult result(int code,String msg){
        return new BaseResult(code,msg);
    }
    public static <T> BaseResult<T> result(int code,String msg,T body){
    return new BaseResult(code,msg,body);
    }
    public static BaseResult result(ResultConstants resultConstants){
    return new BaseResult(resultConstants.getCode(),resultConstants.getMsg());
    }
    public static <T> BaseResult result(ResultConstants resultConstants,T body){
        return new BaseResult(resultConstants.getCode(),resultConstants.getMsg(),body);
    }
}
