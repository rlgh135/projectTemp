package com.twojo.app.ingroup;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Transfer;

public class GPostFrontController extends HttpServlet{
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
	private void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		String requestURI = req.getRequestURI();
		String contextPath = req.getContextPath();
		String command = requestURI.substring(contextPath.length());
		
		System.out.println(command);
		
		Transfer transfer = null;
		switch(command) {
		case "/groupinner.gp":
			try {
				transfer = new GPostInnerOkAction().execute(req, resp);
			} catch (Exception e) {
				System.out.println("/groupinner.gp : "+e);
			}
			break;
		case "/groupinnerMore.gp":
			try {
				transfer = new GPostInnerMokreOkAction().execute(req, resp);
				transfer = null;
			} catch (Exception e) {
				System.out.println("/groupinnerMore.gp : "+e);
			}
			break;
		case "/groupreply.gp":
			try {
				transfer = new GroupPostReplyOK().execute(req, resp);
				transfer = null;
			} catch (Exception e) {
				System.out.println("/groupreply.gp : "+e);
			}
			break;
		case "/getgfile.gp":
			try {
				transfer = new getGFilesOK().execute(req, resp);
				transfer = null;
			} catch (Exception e) {
				System.out.println("/getgfile.gp : "+e);
			}
			break;
		case "/filedownload.gp":
			try {
				new GPFileDownloadAction().execute(req,resp);
			} catch (Exception e) {
//				req.getParameter("systemname");
				System.out.println("/filedownload.gp : "+e);
			}
			break;
		}
		
		if (transfer != null) {
			if(transfer.isRedirect()) {
				resp.sendRedirect(transfer.getPath());
			} else {
				req.getRequestDispatcher(transfer.getPath()).forward(req, resp);
			}
		}
	}
}
