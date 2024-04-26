package com.twojo.app.message;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.MessageDAO;
import com.twojo.model.dto.MessageDTO;

public class MesaageCheckOkAction implements Action {
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		int messagenum = Integer.parseInt(req.getParameter("messagenum"));
		String userid = (String)req.getSession().getAttribute("loginUser");
		
		MessageDAO mdao = new MessageDAO();
		
		
		JsonObject json = new JsonObject();
		
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("application/json");
		
		PrintWriter out = resp.getWriter();
		if(mdao.checkMSG(messagenum)) {
			json.addProperty("result", "O");
			int confirmcnt = mdao.getMsgConfirmCnt(userid);
			json.addProperty("msgcnt", confirmcnt);
			out.print(json.toString());
		}
		else {
			out.print("X");
		}
		out.flush();
		return null;
	}
}
