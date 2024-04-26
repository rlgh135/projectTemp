package com.twojo.app.ingroup;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.UserimgDAO;

public class FindThumbnail implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		// TODO Auto-generated method stub
		String userid = req.getParameter("userid");
				
		UserimgDAO uidao = new UserimgDAO();
		String badge = uidao.getImgName(userid).getUserimgsysname(); 
		
		JsonObject json = new JsonObject();
		
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("application/json");
		PrintWriter out = resp.getWriter();
		json.addProperty("badge", badge);
		out.print(json.toString());
		out.flush();
		
		return null;
	}
}
