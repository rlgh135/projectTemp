package com.twojo.app.ingroup;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.GPostDAO;
import com.twojo.model.dao.GroupDAO;
import com.twojo.model.dao.GroupimgDAO;
import com.twojo.model.dto.GPostDTO;
import com.twojo.model.dto.GroupDTO;

public class ShowPostAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String showuser = req.getParameter("showuser");
		long groupnum = Long.parseLong(req.getParameter("groupnum"));
		GroupDAO gdao = new GroupDAO();
		GroupDTO group = gdao.findGroupByNum(groupnum);
		
		req.setAttribute("showuser", showuser);
		req.setAttribute("group", group);
		
		GPostDAO gpdao = new GPostDAO();
		GPostDTO gongji = gpdao.getGongji(groupnum);
	
		req.setAttribute("gongji", gongji);
		
		GroupimgDAO gido = new GroupimgDAO();
		String thumbnail = gido.getGroupimg(groupnum);
		if(thumbnail!=null) {
			req.setAttribute("thumbnail", thumbnail);
		} else {
			req.setAttribute("thumbnail", "abcd25.jpg");
		}
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath(req.getContextPath()+"/app/group/showpost.jsp");
		return transfer;
	}
}
