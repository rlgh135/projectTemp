package com.twojo.app.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.app.user.CheckIdOkAction;
import com.twojo.app.user.UserJoinOkAction;
import com.twojo.app.user.UserLoginOkAction;
import com.twojo.action.Transfer;

public class UserFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		doProcess(req, resp);
	}
	
	private void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//길 나누는 코드
		String requestURI = req.getRequestURI();// ???/userjoin.us
		String contextPath = req.getContextPath(); // ???
		String command = requestURI.substring(contextPath.length());
		
		System.out.println(command);

		Transfer transfer = null;
		switch(command) {
		case "/userloginok.us":
			try {
				System.out.println("/userloginok.us");
				transfer = new UserLoginOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/userloginok : "+e);
			}
			break;
		case "/userjoin.us":
			transfer = new Transfer();
			transfer.setRedirect(false);
			transfer.setPath("/app/user/join.jsp");
			break;
		case "/userjoinok.us":
			try {
				transfer = new UserJoinOkAction().execute(req, resp);
			} catch (Exception e) {
				System.out.println("/userjoinok : "+e);
			}
			break;
		case "/userlogin.us":
			transfer = new Transfer();
			transfer.setPath("/");
			transfer.setRedirect(false);
			break;
		case "/checkidok.us":
			try {
				transfer = new CheckIdOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/checkidok : "+e);
			}
			break;
		case "/userlogout.us":
			req.getSession().invalidate();
			transfer = new Transfer();
			transfer.setRedirect(false);
			transfer.setPath("/");
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













