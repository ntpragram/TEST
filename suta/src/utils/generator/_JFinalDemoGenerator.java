
package utils.generator;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.generator.Generator;

import javax.sql.DataSource;

import static utils.generator._JFinalTableMappingGenerator.generatorApiModelKit;


/**
 * 本 demo 仅表达最为粗浅的 jfinal 用法，更为有价值的实用的企业级用法
 * 详见 JFinal 俱乐部: http://jfinal.com/club
 * <p>
 * 在数据库表有任何变动时，运行一下 main 方法，极速响应变化进行代码重构
 */

public class _JFinalDemoGenerator {
    
    public static DataSource getDataSource() {
        String jdbcUrl = "jdbc:mysql://localhost:3306/yunshan?useUnicode=true&amp;characterEncoding=gbk";
        String user = "root";
        String password = "123456";
        com.jfinal.plugin.druid.DruidPlugin druidPlugin = new com.jfinal.plugin.druid.DruidPlugin(jdbcUrl, user, password);
        druidPlugin.start();
        return druidPlugin.getDataSource();
    }
    
    public static void main(String[] args) {
        // base model 所使用的包名
        String baseModelPackageName = "com.common.model.base";
        // base model 文件保存路径
        String baseModelOutputDir = PathKit.getWebRootPath() + "/src/test/com/common/model/base";
        
        // model 所使用的包名 (MappingKit 默认使用的包名)
        String modelPackageName = "com.common.model";
        // model 文件保存路径 (MappingKit 与 DataDictionary 文件默认保存路径)
        String modelOutputDir = baseModelOutputDir + "/..";
        
        // 创建生成器
        Generator generator = new Generator(getDataSource(), baseModelPackageName, baseModelOutputDir, modelPackageName, modelOutputDir);
        // 设置是否生成链式 setter 方法
        generator.setGenerateChainSetter(false);
        // 添加不需要生成的表名
        generator.addExcludedTable("adv");
        // 设置是否在 Model 中生成 dao 对象
        generator.setGenerateDaoInModel(true);
        // 设置是否生成链式 setter 方法
        generator.setGenerateChainSetter(true);
        // 设置是否生成字典文件
        generator.setGenerateDataDictionary(false);
        // 设置需要被移除的表名前缀用于生成modelName。例如表名 "osc_user"，移除前缀 "osc_"后生成的model名为 "User"而非 OscUser
        generator.setRemovedTableNamePrefixes("t_");
        // 生成
        generator.generate();
    
        
        // 生成ApiModelKit.java
        // ApiModelKit 所使用的包名
        String apiModelKitPackageName = "com.common.model";
        // 继承com.jfinal.plugin.activerecord.Table类 存放位置的包路径名
        String extendsTablePackageName = "common.generator.Table";
        // ApiModelKit 文件保存路径 (与MappingKit同目录)
        String apiModelKitOutputDir = PathKit.getWebRootPath() + "/src/test/java/com/common/model/";
        // 生成
        generatorApiModelKit(getDataSource(), apiModelKitPackageName, extendsTablePackageName, apiModelKitOutputDir);
        
    }
}




