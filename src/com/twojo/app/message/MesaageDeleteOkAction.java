package com.twojo.app.message;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.MessageDAO;
import com.twojo.model.dto.MessageDTO;

public class MesaageDeleteOkAction implements Action {
	
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		int messagenum = Integer.parseInt(req.getParameter("messagenum"));
		
		MessageDAO mdao = new MessageDAO();
		MessageDTO msg = new MessageDTO();
		
		PrintWriter out = resp.getWriter();
		if(mdao.deleteMSG(messagenum)) {
			out.print("O");
		}
		else {
			out.print("X");
		}
		return null;
	}

}