package com.twojo.app.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.LPostDAO;
//import com.twojo.model.dao.FileDAO;

public class BoardUpdateAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		long boardnum = Long.parseLong(req.getParameter("boardnum"));

		LPostDAO bdao = new LPostDAO();
//		FileDAO fdao= new FileDAO();

		req.setAttribute("board", bdao.getBoardByNum(boardnum));
//		req.setAttribute("files", fdao.getFiles(boardnum));

		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath("/app/board/modify.jsp");
		return transfer;
	}
}







