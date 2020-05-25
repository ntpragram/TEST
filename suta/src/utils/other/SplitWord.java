
package utils.other;

import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.tokenattributes.CharTermAttribute;
import org.wltea.analyzer.lucene.IKAnalyzer;

/**
 * 拆词包
 * 
 * @Description
 * 
 * @author C H
 * @version 1.0
 * @since 2017年1月5日
 */
public class SplitWord {

	/**
	 * 拆词
	 * 
	 * @author C H
	 * @since 2017年1月5日
	 * @param text
	 * @return
	 */
	public static List<String> splitWord(String text) {
		List<String> list = new ArrayList<String>();
		Analyzer anal = new IKAnalyzer(true);
		StringReader reader = new StringReader(text);
		TokenStream ts = anal.tokenStream("", reader);
		CharTermAttribute term = (CharTermAttribute) ts
				.getAttribute(CharTermAttribute.class);
		try {
			while (ts.incrementToken()) {
				list.add(term.toString());
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		reader.close();
		anal.close();
		return list;
	}

	public static String splitWordStr(String text) {
		Analyzer anal = new IKAnalyzer(true);
		StringReader reader = new StringReader(text);
		TokenStream ts = anal.tokenStream("", reader);
		CharTermAttribute term = (CharTermAttribute) ts
				.getAttribute(CharTermAttribute.class);
		StringBuilder builder = new StringBuilder();
		try {
			while (ts.incrementToken()) {
				builder.append(term.toString() + ",");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		reader.close();
		anal.close();
		return builder.toString();
	}
}
