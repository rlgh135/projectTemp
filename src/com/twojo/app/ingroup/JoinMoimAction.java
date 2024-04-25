package com.twojo.app.ingroup;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.GroupDAO;
import com.twojo.model.dao.GroupimgDAO;
import com.twojo.model.dao.ReqListDAO;
import com.twojo.model.dto.GroupDTO;
import com.twojo.model.dto.ReqListDTO;

public class JoinMoimAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		long groupnum = Long.parseLong(req.getParameter("groupnum"));
		String userid = (String)req.getSession().getAttribute("loginUser");
		
		GroupDAO gdao = new GroupDAO();
		GroupDTO group = gdao.findGroupByNum(groupnum);
		req.setAttribute("group", group);
		req.setAttribute("usercnt", gdao.getUserCntInGroup(groupnum));
		
		ReqListDAO reqdao = new ReqListDAO();
		ReqListDTO temp = reqdao.getQuestionList(groupnum);
		Transfer transfer = new Transfer();
		
		if(userid.equals(temp.getLeaderid())) {
			List<ReqListDTO> reqlist = reqdao.getAnswerList(groupnum);
			req.setAttribute("answerlist", reqlist);
		}
		
		String base = temp.getQuestion();
		String[] splits = base.split("§");
		ArrayList<String> questionlist = new ArrayList<String>();
		
		for (int i = 0; i < splits.length; i++) {
			questionlist.add(splits[i]);
		}
		
		GroupimgDAO gido = new GroupimgDAO();
		String thumbnail = gido.getGroupimg(groupnum);
		if(thumbnail!=null) {
			req.setAttribute("thumbnail", thumbnail);
		} else {
			req.setAttribute("thumbnail", "abcd25.jpg");
		}
		
		
		req.setAttribute("questionlist", questionlist);
		req.setAttribute("autoreg", temp.getAutoreg());
		
		transfer.setRedirect(false);
		transfer.setPath("/app/group/joinMoim.jsp?groupnum="+groupnum);
		return transfer;
	}
}
