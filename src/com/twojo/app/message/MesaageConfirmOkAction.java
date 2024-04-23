package com.twojo.app.message;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.MessageDAO;

public class MesaageConfirmOkAction implements Action {
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String userid = (String)req.getSession().getAttribute("loginUser");
		
		
		MessageDAO mdao = new MessageDAO();
		
		int confirmcnt = mdao.getMsgConfirmCnt(userid);
		
		JsonObject json = new JsonObject();
		
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("application/json");
		
		json.addProperty("msgcnt", confirmcnt);
		
		PrintWriter out = resp.getWriter();
		out.print(json.toString());
		out.flush();
		
		return null;
	}
}
