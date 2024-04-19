package com.twojo.app.message;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.MessageDAO;
import com.twojo.model.dto.MessageDTO;

public class MesaageGetListOkAction implements Action {
	
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String userid = (String)req.getSession().getAttribute("loginUser");
		
		MessageDAO mdao = new MessageDAO();
		MessageDTO msg = new MessageDTO();
		
		List<MessageDTO> sysmsglist = mdao.getSysMSGList(userid);
		List<MessageDTO> usermsglist = mdao.getMSGList(userid);
		
		
		
		Transfer transfer = new Transfer();
		if(usermsglist.size() > 0 || sysmsglist.size() > 0) {
			req.setAttribute("sysmsglist", sysmsglist);
			req.setAttribute("usermsglist", usermsglist);
			transfer.setRedirect(false);
		}
		else {
			transfer.setRedirect(true);
		}
		
		transfer.setPath("/app/message/messagelist.jsp");
		return transfer;
		
	}
}
