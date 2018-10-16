package util;

import freemarker.cache.ClassTemplateLoader;
import freemarker.cache.MultiTemplateLoader;
import freemarker.cache.TemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;

import java.io.*;
import java.util.Locale;
import java.util.Map;

/**
 *  freemarker工具类
 *
 *  @author fdh
 */
public class FreemarkerUtil {
    /**
     * 创建模板文件
     */
    public static void createFile(String templateLoadPath, String templateName, String outPath, Map<String,Object> dataModel,String templateEncode){
        //默认编码
        if(templateEncode==null){
            templateEncode = "utf-8";
        }

        //创建模板文件
        Configuration conf = new Configuration(Configuration.VERSION_2_3_28);
        conf.setLocale(new Locale("CN"));
        conf.setDefaultEncoding(templateEncode);
        ClassTemplateLoader ctl = new ClassTemplateLoader(FreemarkerUtil.class, templateLoadPath);
        MultiTemplateLoader mtl = new MultiTemplateLoader(new TemplateLoader[]{ctl});
        conf.setTemplateLoader(mtl);


        Writer out = null;
        try {
            Template template = conf.getTemplate(templateName);
            out = new OutputStreamWriter(new FileOutputStream(outPath));
            template.process(dataModel,out);
            //template.process(dataModel,new PrintWriter(System.out));
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(out!=null){out.close();} } catch (IOException e) { e.printStackTrace(); }
        }
    }
}
