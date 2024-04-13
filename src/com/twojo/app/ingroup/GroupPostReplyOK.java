package com.twojo.app.ingroup;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.GPReplyDAO;
import com.twojo.model.dto.GPReplyDTO;

public class GroupPostReplyOK implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String temp = req.getParameter("page");
		int page = temp == null || temp.equals("") ? 1 : Integer.parseInt(temp);
		long gpostnum = Long.parseLong(req.getParameter("gpostnum"));
		
		GPReplyDAO gprdao = new GPReplyDAO();
		int pageSize = 4;
		int startRow = (page-1)*pageSize;
		List<GPReplyDTO> findreplylist = null;
		
		findreplylist = gprdao.getListByPage(gpostnum, startRow, pageSize);
		
		Gson gson = new Gson();
		JsonObject json = new JsonObject();
		
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("application/json");
		
		json.add("datas", gson.toJsonTree(findreplylist));
		System.out.println(json);
		PrintWriter out = resp.getWriter();
		out.print(json.toString());
		out.flush();
		
		return null;
	}
}
