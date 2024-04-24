package com.twojo.app.user;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.GroupDAO;
import com.twojo.model.dao.GroupUserDAO;
import com.twojo.model.dao.GroupimgDAO;
import com.twojo.model.dto.GroupDTO;

public class MyGroupLoadAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String userid = (String)req.getSession().getAttribute("loginUser");
		int page = Integer.parseInt(req.getParameter("page"));
		int pageSize = 3;
		int startRow = (page-1)*pageSize;
		System.out.println("그룹: "+userid);
		GroupUserDAO gudao = new GroupUserDAO();
		List<Long> groupnums = gudao.getGroupnumList(userid, startRow, pageSize);
		GroupDAO gdao = new GroupDAO();
		GroupimgDAO gidao = new GroupimgDAO();
		
		ArrayList<GroupDTO> grouplist = new ArrayList<GroupDTO>();
		ArrayList<String> sysnamelist = new ArrayList<String>();
		for (Long groupnum : groupnums) {
			if(groupnum!=null) {
				grouplist.add(gdao.findGroupByNum(groupnum));
				sysnamelist.add(gidao.getGroupimg(groupnum));
			} else {
				grouplist.add(null);
				sysnamelist.add("main_img.jpg");
			}
		}
		
		Gson gson = new Gson();
		JsonObject json = new JsonObject();
		
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("application/json");
		
		json.add("grouplist", gson.toJsonTree(grouplist));
		json.add("sysnamelist", gson.toJsonTree(sysnamelist));
		PrintWriter out = resp.getWriter();
		out.print(json.toString());
		out.flush();
		
		return null;
	}
}
