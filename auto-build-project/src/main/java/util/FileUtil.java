package util;

import java.io.File;

public class FileUtil {

    /**
     * 创建文件夹（目录存在的时候先删除）
     * @param dirPath 绝对路径
     */
    public static void mkdirs(File dirPath){
        if(dirPath.exists()){
            FileUtil.deleteDirs(dirPath);
        }
        dirPath.mkdirs();
    }


    /**
     * 递归删除当前目录下的所有文件(包含自身目录)
     * @param dir
     */
    public static void deleteDirs(File dir){
        if (dir.isDirectory()) {
            String[] children = dir.list();
            //递归删除目录中的子目录下
            for (int i=0; i<children.length; i++) {
                deleteDirs(new File(dir, children[i]));
            }
        }
        // 目录此时为空，可以删除
        dir.delete();
    }

    /**
     * 递归删除当前目录下的所有文件(不包含自身目录)
     * @param dir
     */
    public static void deleteDirsWithoutSelf(File dir){
        if (dir.isDirectory()) {
            String[] children = dir.list();
            //递归删除目录中的子目录下
            for (int i=0; i<children.length; i++) {
                deleteDirsWithoutSelf(new File(dir, children[i]));
            }
        }
    }
}
