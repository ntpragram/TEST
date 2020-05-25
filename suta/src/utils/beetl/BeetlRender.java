package utils.beetl;

import org.beetl.core.GroupTemplate;
import org.beetl.ext.jfinal3.JFinal3BeetlRender;

import com.jfinal.render.Render;

public class BeetlRender {

	private BeetlRender() {
	}

	public static final BeetlRender bee = new BeetlRender();

	private GroupTemplate groupTemplate;

	public Render getRender(String view) {
		return new JFinal3BeetlRender(groupTemplate, view);
	}

	public void setGroupTemplate(GroupTemplate groupTemplate) {
		this.groupTemplate = groupTemplate;
	}

}
