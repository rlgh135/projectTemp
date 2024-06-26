package com.twojo.app.reply;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Transfer;
import com.twojo.app.board.BoardDeleteOkAction;
import com.twojo.app.board.BoardListOkAction;
import com.twojo.app.board.BoardUpdateAction;
import com.twojo.app.board.BoardUpdateOkAction;
import com.twojo.app.board.BoardViewOkAction;
import com.twojo.app.board.BoardWriteOkAction;
//import com.twojo.app.board.FileDownloadAction;

public class ReplyFrontController extends HttpServlet {
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
		String requestURI = req.getRequestURI();// ???/userjoin.us
		String contextPath = req.getContextPath(); // ???
		String command = requestURI.substring(contextPath.length());
		System.out.println("컨트롤러 들어옴");
		
		System.out.println(command);

		Transfer transfer = null;
		switch(command) {
		case "/lreplywrite.rp":
			try {
				System.out.println("/replywrite.rp 들어옴");
				new ReplyWriteOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/replywrite.rp : "+e);
			}
			break;
		case "/replydelete.rp":
			try {
				System.out.println("/replydelete.rp: " + command);
				new ReplyDeleteOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/replydelete.rp : "+e);
			}
			break;
		case "/lreplyupdate.rp":
			try {
				new ReplyUpdateOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/replyupdate.rp : "+e);
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