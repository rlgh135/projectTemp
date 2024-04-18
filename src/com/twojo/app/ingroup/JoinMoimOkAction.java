package com.twojo.app.ingroup;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.GroupUserDAO;
import com.twojo.model.dao.MessageDAO;
import com.twojo.model.dao.ReqListDAO;
import com.twojo.model.dto.GroupUserDTO;
import com.twojo.model.dto.MessageDTO;
import com.twojo.model.dto.ReqListDTO;

public class JoinMoimOkAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		long groupnum = Long.parseLong(req.getParameter("groupnum"));
		String userid = (String)req.getSession().getAttribute("loginUser");
		String groupmaster = req.getParameter("groupmaster");
		String groupname = req.getParameter("groupname");
		int index = 0;
		String auto = req.getParameter("auto");
		String answer="";

		MessageDTO message = new MessageDTO();
		message.setMsgcheck(0);
		message.setSendid("system");
		message.setReceiveid(groupmaster);
		message.setLinkstring(req.getContextPath()+"/groupinner.gp?groupnum="+groupnum);
		
		if (auto.equals("auto")) {
			
			System.out.println("들어옴"+1);
			GroupUserDTO groupuser = new GroupUserDTO();
			groupuser.setUserid(userid);
			groupuser.setGroupnum(groupnum);
			
			GroupUserDAO gudao = new GroupUserDAO();
			
			if (gudao.insert(groupuser)) {
				System.out.println("들어옴"+2);				
			}
			message.setMsgcontent(userid+"님이 "+groupname+"에 새로 가입했어요");
		
		} else {
			index = Integer.parseInt(req.getParameter("index"));
			System.out.println(2);
			for (int i = 0; i < (index+1); i++) {
				answer += req.getParameter("answer"+i);
				answer += "§";
			}
			
			ReqListDTO reqlist = new ReqListDTO();
			reqlist.setAnswer(answer);
			reqlist.setUserid(userid);
			reqlist.setGroupnum(groupnum);
			
			ReqListDAO reqdao = new ReqListDAO();
			reqdao.makeAnswer(reqlist);
			
			message.setMsgcontent(groupname+"에 새 가입 신청이 왔어요");
		}
		
		MessageDAO mdao = new MessageDAO();
		mdao.systemMessage(message);
		
		Transfer transfer = new Transfer();
		transfer.setPath(req.getContextPath()+"/groupinner.gp?groupnum="+groupnum);
		return transfer;
	}
}
