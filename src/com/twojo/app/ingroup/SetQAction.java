package com.twojo.app.ingroup;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.GroupDAO;
import com.twojo.model.dao.GroupimgDAO;
import com.twojo.model.dao.ReqListDAO;
import com.twojo.model.dto.GroupDTO;
import com.twojo.model.dto.ReqListDTO;

public class SetQAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		long groupnum = Long.parseLong(req.getParameter("groupnum"));
		
		GroupDAO gdao = new GroupDAO();
		GroupDTO group = gdao.findGroupByNum(groupnum);
		
		req.setAttribute("group", group);
		
		ReqListDAO reqdao = new ReqListDAO();
		ReqListDTO question = reqdao.getQuestionList(groupnum);
		
		if(question!=null) {
			String qusbase = question.getQuestion();
			String[] questions = qusbase.split("§");
			
			ArrayList<String> questionlist = new ArrayList<String>();
			for (int i = 0; i < questions.length; i++) {
				questionlist.add(questions[i]);
			}
			
			req.setAttribute("questionlist", questionlist);
		}
		
		GroupimgDAO gido = new GroupimgDAO();
		String thumbnail = gido.getGroupimg(groupnum);
		if(thumbnail!=null) {
			req.setAttribute("thumbnail", thumbnail);
		} else {
			req.setAttribute("thumbnail", "abcd25.jpg");
		}
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath(req.getContextPath()+"/app/group/setq.jsp?groupnum="+groupnum);
		return transfer;
	}
}
