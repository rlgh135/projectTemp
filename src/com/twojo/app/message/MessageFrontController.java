package com.twojo.app.message;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.twojo.action.Transfer;

public class MessageFrontController extends HttpServlet {
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
		case "/sendmessage.ms":
			try {
				System.out.println("/sendmessage.ms");
				transfer = new MesaageSendOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/SendOkAction : "+e);
			}
			break;
		case "/getmessage.ms":
			try {
				System.out.println("/getmessage.ms");
				transfer = new MesaageGetListOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/GetMesaageOkAction : "+e);
			}
			break;
		case "/deletemessage.ms":
			try {
				System.out.println("/deletemessage.ms");
				transfer = new MesaageDeleteOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/MesaageDeleteOkAction : "+e);
			}
			break;
		case "/checkmessage.ms":
			try {
				System.out.println("checkmessage.ms");
				transfer = new MesaageCheckOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/MesaageCheckOkAction : "+e);
			}
			break;
		case "/confirmmessage.ms":
			try {
				System.out.println("confirmmessage.ms");
				transfer = new MesaageConfirmOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/MesaageConfirmOkAction : "+e);
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