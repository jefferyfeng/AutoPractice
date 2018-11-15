package util;

import java.io.*;
import java.net.URL;

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

    /**
     * 拷贝文件
     * @param sourceFile 拷贝源文件
     * @param targetFile 拷贝至文件
     */
    public static void copyFile(File sourceFile,File targetFile){
        if (!sourceFile.exists()) return;

        FileInputStream fis = null;
        FileOutputStream fos = null;
        try {
            fis = new FileInputStream(sourceFile);//读入原文件
            fos = new FileOutputStream(targetFile);
            byte[] buffer = new byte[1024];//设置缓冲区
            while (true) {//当文件没有读到结尾
                int hasRead = fis.read(buffer);
                if(hasRead == -1)break;
                fos.write(buffer, 0, hasRead);break;//写文件
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(fis != null){ try { fis.close(); } catch (IOException e) { e.printStackTrace(); } }
            if(fos != null){ try { fos.close(); } catch (IOException e) { e.printStackTrace(); } }
        }
    }

    /**
     * 删除文件
     * (如果是目录递归删除该目录下所有文件)
     */
    public static void deleteFile(File delFile){
        if(!delFile.exists()) return;
        File[] files = delFile.listFiles();
        for (File file : files) {
            if(file.isDirectory()){
                deleteFile(file);
            }else{
                file.delete();
            }
        }
        delFile.delete();
    }

    /**
     * 拷贝目录
     * @param sourceDir 拷贝源目录
     * @param targetDir 拷贝至目录
     */
    public static void copyDirectory(File sourceDir,File targetDir){
        if(!sourceDir.exists()) return;
        //如果拷贝至的目录存在 删除该目录
        if(targetDir.exists()){
            deleteFile(targetDir);
        }
        targetDir.mkdirs();

        File[] files = sourceDir.listFiles();
        for (File file : files) {
            String name = targetDir.getAbsolutePath() + File.separator + file.getName();
            File targetFile = new File(name);
            if(file.isDirectory()){
                copyDirectory(file,targetFile);
            }else{
                copyFile(file,targetFile);
            }
        }
    }

    /**
     * 获取resources目录下的文件路径
     * @return
     */
    public static String getResourcesFilePath(String relativePath){
        URL resource = FileUtil.class.getClassLoader().getResource(relativePath);
        return (resource == null ? null : resource.getPath());
    }

    public static void main(String[] args) {
        File sourceDir = new File("C:\\Users\\dongao\\Desktop\\新建文件夹\\a");
        File targetDir = new File("C:\\Users\\dongao\\Desktop\\新建文件夹\\b");
        copyDirectory(sourceDir,targetDir);

        /*String absolutePath = new File(FileUtil.class.getClassLoader().getResource("template/v1/static/layui").getPath()).getAbsolutePath();

        System.out.println(absolutePath);*/
    }

}
