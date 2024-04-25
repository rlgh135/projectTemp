package com.twojo.app.user;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.UserDAO;
import com.twojo.model.dao.UserimgDAO;
import com.twojo.model.dto.UserDTO;
import com.twojo.model.dto.UserimgDTO;

public class UserJoinOkAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String userid = req.getParameter("userid");
		UserDTO user = new UserDTO();
		user.setUserid(userid);
		user.setUserpw(req.getParameter("userpw"));
		user.setUsername(req.getParameter("username"));
		user.setGender(req.getParameter("usergender")+"-"+req.getParameter("foreigner"));//W-K
		user.setUserzipcode(req.getParameter("zipcode"));
		user.setUseraddr(req.getParameter("useraddr"));
		user.setUseraddrgu(req.getParameter("useraddrgu"));
		user.setUseraddrdetail(req.getParameter("addrdetail"));
		user.setUseraddretc(req.getParameter("addretc"));
		user.setUserhobby(req.getParameter("userhobby"));
		
		UserimgDAO uidao = new UserimgDAO();
		UserimgDTO userimage = new UserimgDTO();
		userimage.setUserid(userid);
		userimage.setUserimgorgname("defaultuserbadge.png");
		userimage.setUserimgsysname("defaultuserbadge.png");
		uidao.insertFile(userimage);
		
		UserDAO udao = new UserDAO();
		if(udao.insertUser(user)) {
			Cookie cookie = new Cookie("joinid", userid);
			cookie.setPath("/");
			resp.addCookie(cookie);
		}
		else {
			
		}
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(true);
		transfer.setPath(req.getContextPath()+"/");
		return transfer;
	}
}







