package com.twojo.app.group;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Transfer;

public class GroupFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		doProcess(req, resp);
	}
	
	private void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String requestURI = req.getRequestURI();
		String contextPath = req.getContextPath();
		String command = requestURI.substring(contextPath.length());
		
		Transfer transfer = null;
		
		switch(command) {
		case "/groupList.gr":
			try {
				transfer = new GroupListOkAction().execute(req, resp);
			} catch (Exception e) {
				System.out.println("/groupList.gr : "+e);
			}
			break;
		case "/groupHobbyList.gr":
			try {
				transfer = new GroupHobbyListOkAction().execute(req, resp);
			} catch (Exception e) {
				System.out.println("/groupHobbyList.gr : "+e);
			}
			break;
		case "/creategroup.gr":
			transfer = new Transfer();
			transfer.setRedirect(false);
			transfer.setPath(req.getContextPath()+"/app/group/createGroup.jsp");
			break;
		case "/groupcreateok.gr":
			try {
				transfer = new CreateGroupOkAction().execute(req, resp);
			} catch (Exception e) {
				System.out.println("/groupcreateok.gr : "+e);
			}
			break;
		}
		if(transfer != null) {
			if(transfer.isRedirect()) {
				resp.sendRedirect(transfer.getPath());
			}
			else {
				req.getRequestDispatcher(transfer.getPath()).forward(req, resp);
			}
		}
		
	}
}
