package com.twojo.app.user;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.LPostDAO;
import com.twojo.model.dto.LPostDTO;

public class MyBoardLoadAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String userid = (String)req.getSession().getAttribute("loginUser");
		int page = Integer.parseInt(req.getParameter("page"));
		int pageSize = 3;
		int startRow = (page-1)*pageSize;
		LPostDAO lpdao = new LPostDAO();
		List<LPostDTO> lplist = lpdao.getListByUser(userid, startRow, pageSize);
		
		Gson gson = new Gson();
		JsonObject json = new JsonObject();
		
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("application/json");
		
		json.add("lplist", gson.toJsonTree(lplist));
		PrintWriter out = resp.getWriter();
		out.print(json.toString());
		out.flush();
		
		return null;
	}
}
