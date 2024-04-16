package com.twojo.app.lpost_user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.Lpost_UserDAO;
import com.twojo.model.dto.Lpost_UserDTO;

public class Lpost_UserdelAction implements Action{

	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HttpSession session = req.getSession();
        String userid = (String) session.getAttribute("loginUser");
        
        long boardnum = Long.parseLong(req.getParameter("boardnum"));

        Lpost_UserDTO ludto = new Lpost_UserDTO();
        ludto.setUserid(userid);
        ludto.setBoardnum(boardnum);
        
        Transfer transfer = new Transfer();
		transfer.setRedirect(true);
        
		Lpost_UserDAO lpdao = new Lpost_UserDAO();
	
		if(lpdao.delUser(ludto)) {
			System.out.println("취소성공");
		    req.setAttribute("message", "취소 성공");
		} 
		transfer.setPath(req.getContextPath()+"/boardview.bo?lpostnum="+boardnum);
		
		return transfer;
	}

}
