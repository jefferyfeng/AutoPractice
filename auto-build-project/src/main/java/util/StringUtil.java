package util;

/**
 * 项目使用工具类
 */
public class StringUtil {
    /**
     * 替换下划线 并且将每组的第一个字母大写
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
     * 替换下划线 并且将除了第一组以外，其他每组的首字母大写
     * 例：t_user  -> tUser
     */
    public static String noUnderLineAndLowFirstChar(String s){
        String[] split = s.split("_");
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < split.length; i++) {
            String temp = split[i];
            if(i==0){
                sb.append(temp);
            }else{
                sb.append(uperFirstChar(temp));
            }
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

    /**
     * 降低一个字母小写
     * 例：User  -> user
     */
    public static String lowerFirstChar(String s){
        String firstChar = s.substring(0, 1);
        String exceptFirstChars = s.substring(1);
        return firstChar.toLowerCase()+exceptFirstChars;
    }

    /**
     * 将包结构转为文件路径
     * 例：com.example -> com/example
     */
    public static String getPathStr(String packageStr){
        return packageStr.replace('.', '/');
    }

    /**
     * 将文件路径转为包结构
     * 例：com.example -> com/example
     */
    public static String getPackageStr(String pathStr){
        return pathStr.replace('/', '.');
    }
}
