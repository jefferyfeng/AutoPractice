package ${utilPackage};

import java.util.Random;

/**
 * 随机字符
 *
 * @author fdh
 */
public class CodeUtil {
    private static final char[] CODES = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's',
            't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
            'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6',
            '7', '8', '9'};

    private static final Random RANDOM = new Random();
    /**默认生成长度*/
    private static final Integer DEFAULT_LENGTH = 4;

    public static  String buildCode(){
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < DEFAULT_LENGTH; i++) {
            builder.append(CODES[RANDOM.nextInt(CODES.length)]);
        }
        return builder.toString();
    }

    public static  String buildCode(int length){
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < length; i++) {
            builder.append(CODES[RANDOM.nextInt(CODES.length)]);
        }
        return builder.toString();
    }
}
