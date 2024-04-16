package com.twojo.app.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.app.board.BoardDeleteOkAction;
import com.twojo.app.user.MyinfoOkAction;
//import com.kh.app.board.ParticipationAction;
import com.mysql.cj.Session;
import com.twojo.action.Transfer;

public class BoardFrontController extends HttpServlet {
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
		case "/myinfo.bo":
			try {
				System.out.println("try진입");
				transfer = new MyinfoOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/myinfo.bo : "+e);
			}
			break;
		case "/boardlist.bo":
			try {
				System.out.println("try진입");
				transfer = new BoardListOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/boardlist.bo : "+e);
			}
			break;
		case "/participation.bo":
			try {
				new ParticipationAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/participation.bo : "+e);
			}
		case "/boardwrite.bo":
			transfer = new Transfer();
			transfer.setRedirect(false);
			transfer.setPath("/app/board/write.jsp");
			break;
		case "/boardwriteok.bo":
			try {
				System.out.println("/boardwriteok.bo 진입");
				transfer = new BoardWriteOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/boardwriteok.bo : "+e);
			}
			break;
		case "/boardview.bo":
			try {
				transfer = new BoardViewOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/boardview.bo : "+e);
			}
			break;
		case "/boarddelete.bo":
			try {
				transfer = new BoardDeleteOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/boarddelete.bo : "+e);
			}
			break;
		case "/boardupdate.bo":
			try {
				transfer = new BoardUpdateAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/boardupdate.bo : "+e);
			}
			break;
		case "/boardupdateok.bo":
			try {
				transfer = new BoardUpdateOkAction().execute(req,resp);
			} catch (Exception e) {
				System.out.println("/boardupdateok.bo : "+e);
			}
			break;
//		case "/filedownload.bo":
//			try {
//				new FileDownloadAction().execute(req,resp);
//			} catch (Exception e) {
//				System.out.println("/filedownload.bo : "+e);
//			}
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













