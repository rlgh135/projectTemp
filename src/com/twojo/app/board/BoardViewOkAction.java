package com.twojo.app.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.LPostDAO;
//import com.twojo.model.dao.FileDAO;
import com.twojo.model.dao.LReplyDAO;
import com.twojo.model.dto.LPostDTO;

public class BoardViewOkAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String boardNumParam = req.getParameter("lpostnum");
		long boardnum = 0; // 기본값 설정
		if (boardNumParam != null && !boardNumParam.isEmpty()) {
		    boardnum = Long.parseLong(boardNumParam);
		    System.out.println(boardnum + "viewokaction");
		}
		String loginUser = (String)req.getSession().getAttribute("loginUser");
		
		LPostDAO bdao = new LPostDAO();
		
		LPostDTO board = bdao.getBoardByNum(boardnum);
		if(!board.getUserid().equals(loginUser)) {
			bdao.updateReadCount(boardnum);
			board.setReadcount(board.getReadcount()+1);
		}
//		FileDAO fdao = new FileDAO();
		LReplyDAO rdao = new LReplyDAO();
		
		req.setAttribute("board", board);
//		req.setAttribute("files", fdao.getFiles(boardnum));
		req.setAttribute("replies", rdao.getReplies(boardnum));
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath("/app/board/get.jsp");
		return transfer;
	}
}
