package utils.auto.generator;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.text.MessageFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Record;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class Generator {

	private static File javaFile = null;

	public static final Generator build = new Generator();

	private void build(String modelName, List<Record> list, String key,
			String type) {
		Writer out;
		try {
			Configuration cfg = new Configuration();
			cfg.setDirectoryForTemplateLoading(new File(Generator.class
					.getResource("/").getPath() + "utils/auto/template"));
			cfg.setObjectWrapper(new DefaultObjectWrapper());

			Template template = cfg.getTemplate(MessageFormat.format(
					"jsp_{0}.ftl", type));
			Map<String, Object> root = buildDataModel(modelName, list, key,
					type);
			if (javaFile != null) {
				Writer javaWriter = new FileWriter(javaFile);
				template.process(root, javaWriter);
				javaWriter.flush();
				System.out.println("文件生成路径：" + javaFile.getCanonicalPath());
				javaWriter.close();
			}
			out = new OutputStreamWriter(System.out);
			template.process(root, out);
			out.flush();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TemplateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 生成index.jsp
	 * 
	 * @author C H
	 * @throws IOException
	 * @throws TemplateException
	 * @since 2016年12月21日
	 */
	public void buildJspOfindex(String modelName, List<Record> list, String key) {
		build(modelName, list, key, "index");
	}

	public void buildJspOfModify(String modelName, List<Record> list, String key) {
		build(modelName, list, key, "modify");
	}

	/**
	 * 创建数据模型
	 * 
	 * @return
	 */
	private static Map<String, Object> buildDataModel(String modelName,
			Object entity, String key, String type) {
		Map<String, Object> root = new HashMap<String, Object>();
		// /HHL/WebRoot/WEB-INF/page/admin
		File outDirFile = new File(
				"D:/workspace/HHL/WebRoot/WEB-INF/page/admin/" + modelName);
		if (!outDirFile.exists()) {
			outDirFile.mkdir();
		}

		javaFile = toJspFilename(modelName, outDirFile, type);
		root.put("modelName", modelName);
		root.put("key", key);
		root.put("list", entity);
		return root;
	}

	private static File toJspFilename(String modelName, File outDirFile,
			String type) {
		File file = new File(outDirFile, type + ".jsp");
		if (!outDirFile.exists()) {
			outDirFile.mkdirs();
		}
		return file;
	}

}
