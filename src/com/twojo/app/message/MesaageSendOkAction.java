package com.twojo.app.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.MessageDAO;
import com.twojo.model.dto.MessageDTO;

import java.io.PrintWriter;

public class MesaageSendOkAction implements Action {

	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		int checknum = Integer.parseInt(req.getParameter("msgcheck"));
		
		MessageDTO msg = new MessageDTO();
		msg.setSendid(req.getParameter("sendid"));
		msg.setReceiveid(req.getParameter("receiveid"));
		msg.setMsgcontent(req.getParameter("msgcontent"));
		msg.setMsgcheck(checknum);
		
		MessageDAO mdao = new MessageDAO();
		
		PrintWriter out = resp.getWriter();
		if(mdao.insertMSG(msg)) {
			out.print("O");
		}
		else {
			out.print("X");
		}
		return null;
	}

}