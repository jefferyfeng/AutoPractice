package util;

/**
 * 项目使用工具类
 */
public class StringUtil {
    /**
     * 替换下划线 并且将第一个字母大写
     * 例：t_user  -> TUser
     */
    public static String noUnderLineAndUpFirstChar(String s){
        String[] split = s.split("_");
        StringBuilder sb = new StringBuilder();
        for (String str : split) {
            sb.append(uperFirstChar(str));
        }
        return sb.toString();
    }

    /**
     * 将第一个字母大写
     * 例：user  -> User
     */
    public static String uperFirstChar(String s){
        String firstChar = s.substring(0, 1);
        String exceptFirstChars = s.substring(1);
        return firstChar.toUpperCase()+exceptFirstChars;
    }
}
