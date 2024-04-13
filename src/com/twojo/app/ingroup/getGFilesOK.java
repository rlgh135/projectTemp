package com.twojo.app.ingroup;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.GFileDAO;
import com.twojo.model.dto.GFileDTO;

public class getGFilesOK implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		long gpostnum = Long.parseLong(req.getParameter("gpostnum"));
		
		GFileDAO gfdao = new GFileDAO();
		List<GFileDTO> files = gfdao.getGFiles(gpostnum);
		
		Gson gson = new Gson();
		JsonObject json = new JsonObject();
		
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("application/json");
		
		json.add("datas", gson.toJsonTree(files));
		System.out.println(json); 
		PrintWriter out = resp.getWriter();
		out.print(json.toString());
		out.flush();
		
		return null;
	}
}
