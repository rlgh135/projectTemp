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
				transfer = new GetGFilesOK().execute(req, resp);
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
		case "/gpwrite.gp":
			try {
				transfer = new GPWriteOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/gpwrite.gp : "+e);
			}
			break;
		case "/gpostdelete.gp":
			try {
				transfer = new GPDeleteOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/gpostdelete.gp : "+e);
			}
			break;
		case "/modifygp.gp":
			try {
				transfer = new ModifyGPAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/modifygp.gp : "+e);
			}
			break;
		case "/writegpreply.gp":
			try {
				transfer = new WriteGPReplyOKAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/writegpreply.gp : "+e);
			}
			break;
		case "/joinmoim.gp":
			try {
				transfer = new JoinMoimAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/joinmoim.gp : "+e);
			}
			break;
		case "/joinmoimok.gp":
			try {
				transfer = new JoinMoimOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/joinmoimok.gp : "+e);
			}
			break;
		case "/checkmoim.gp":
			try {
				transfer = new CheckMoimAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/checkmoim.gp : "+e);
			}
			break;
		case "/checkmoimok.gp":
			try {
				transfer = new CheckMoimOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/checkmoimok.gp : "+e);
			}
			break;
		case "/setq.gp":
			try {
				transfer = new SetQAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/setq.gp : "+e);
			}
			break;
		case "/setqok.gp":
			try {
				transfer = new SetQOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/setqok.gp : "+e);
			}
			break;
		case "/changeok.gp":
			try {
				transfer = new ChangeOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/changeok.gp : "+e);
			}
			break;
		case "/presslike.gp":
			try {
				transfer = new PressLike().execute(req, resp);
				transfer = null;
			} catch (Exception e) {
				System.out.println("/getgfile.gp : "+e);
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
