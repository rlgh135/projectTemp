package com.twojo.app.user;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.UserimgDAO;
import com.twojo.model.dto.UserimgDTO;

public class UserImgOkAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String userid = (String)req.getSession().getAttribute("loginUser");
		
		UserimgDAO uidao = new UserimgDAO();
		UserimgDTO userimg = uidao.getImgName(userid);
		
		JsonObject json = new JsonObject();
		
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("application/json");
		
		json.addProperty("userimg", userimg.getUserimgsysname());
		
		PrintWriter out = resp.getWriter();
		out.print(json.toString());
		out.flush();
		
		return null;
	}
}
