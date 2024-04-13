package com.twojo.app.user;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.UserDAO;
import com.twojo.model.dto.UserDTO;

public class CheckIdOkAction implements Action {
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String userid = req.getParameter("userid");
		
		UserDAO udao = new UserDAO();
		UserDTO temp = udao.getUserById(userid);
		
		PrintWriter out = resp.getWriter();
		
		if(temp == null) {
			out.print("O");
		}
		else {
			out.print("X");
		}
		return null;
	}
}










