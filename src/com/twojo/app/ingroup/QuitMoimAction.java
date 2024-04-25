package com.twojo.app.ingroup;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.GPostDAO;
import com.twojo.model.dao.GroupUserDAO;
import com.twojo.model.dto.GPostDTO;
import com.twojo.model.dto.GroupUserDTO;

public class QuitMoimAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		long groupnum = Long.parseLong(req.getParameter("groupnum"));
		String userid = (String)req.getSession().getAttribute("loginUser");
		
		GroupUserDAO gudao = new GroupUserDAO();
		GroupUserDTO groupuser = new GroupUserDTO();
		groupuser.setGroupnum(groupnum);
		groupuser.setUserid(userid);
		gudao.delete(groupuser);
		
		GPostDAO gpdao = new GPostDAO();
		gpdao.deleteUserGPost(userid, groupnum);
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath(req.getContextPath()+"/groupinner.gp?groupnum="+groupnum);
		return transfer;
	}
}
