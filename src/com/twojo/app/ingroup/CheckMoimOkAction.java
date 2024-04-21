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

public class CheckMoimOkAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String userid = req.getParameter("userid");
		long groupnum = Long.parseLong(req.getParameter("groupnum"));
		String accept = req.getParameter("ok");
		
		ReqListDAO reqdao = new ReqListDAO();
		ReqListDTO anslist = new ReqListDTO();
		GroupUserDAO gudao = new GroupUserDAO();
		GroupUserDTO groupuser = new GroupUserDTO();
		MessageDAO mdao = new MessageDAO();
		MessageDTO message = new MessageDTO();
		
		message.setMsgcheck(0);
		message.setSendid("system");
		message.setReceiveid(userid);
		message.setLinkstring(req.getContextPath()+"/groupinner.gp?groupnum="+groupnum);
		
		if (accept.equals("y")) {
			anslist.setGroupnum(groupnum);
			anslist.setUserid(userid);
			
			if(reqdao.delete(anslist)) {
				groupuser.setUserid(userid);
				groupuser.setGroupnum(groupnum);
				
				gudao.insert(groupuser);
				
				message.setMsgcontent("가입이 승인되었어요");
			}
		} else if(accept.equals("f")){
			anslist.setGroupnum(groupnum);
			anslist.setUserid(userid);
			reqdao.delete(anslist);
			
			message.setMsgcontent("가입이 거절되었어요");
		}
		
		mdao.systemMessage(message);
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath(req.getContextPath()+"/checkmoim.gp?groupnum="+groupnum);
		return transfer;
	}
}
