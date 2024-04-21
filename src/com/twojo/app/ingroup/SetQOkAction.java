package com.twojo.app.ingroup;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.ReqListDAO;
import com.twojo.model.dto.ReqListDTO;

public class SetQOkAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		long groupnum = Long.parseLong(req.getParameter("groupnum"));
		int index = Integer.parseInt(req.getParameter("index"));
		String userid = (String)req.getSession().getAttribute("loginUser");
		
		ReqListDAO reqdao = new ReqListDAO();
		ReqListDTO question = new ReqListDTO();
		
		String ques = "";
		
		System.out.println("인덱스: "+index);
		for (int i = 0; i < (index+1); i++) {
			ques += req.getParameter("question"+i);
			System.out.println("루프몇번?"+i);
			ques += "§";
		}
		question.setGroupnum(groupnum);
		question.setAutoreg(0);
		question.setLeaderid(userid);
		question.setQuestion(ques);
		
		if(reqdao.deleteQuestion(groupnum)) {
			System.out.println("들어옴");
			System.out.println(question.getQuestion());
			System.out.println(question.getLeaderid());
			reqdao.makeQuestion(question);
		} else {
			System.out.println("못들어옴");
			System.out.println(question.getQuestion());
			System.out.println(question.getLeaderid());
			reqdao.makeQuestion(question);
		}
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath(req.getContextPath()+"/groupinner.gp?groupnum="+groupnum);
		return transfer;
	}
}
