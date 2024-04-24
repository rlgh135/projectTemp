package com.twojo.app.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.LPostDAO;
import com.twojo.model.dao.Lpost_AddrDAO;
import com.twojo.model.dto.LPostDTO;
//import com.twojo.model.dao.FileDAO;

public class BoardUpdateAction implements Action {
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		long boardnum = Long.parseLong(req.getParameter("boardnum"));

		LPostDAO bdao = new LPostDAO();

		LPostDTO board = bdao.getBoardByNum(boardnum);
		req.setAttribute("board", board);

		String base = board.getDeadline();
		String[] deadline = new String[4];
		deadline[0] = base.split("-")[1];
		deadline[1] = base.split("-")[2].split(" ")[0];
		deadline[2] = base.split("-")[2].split(" ")[1].split(":")[0];
		deadline[3] = base.split("-")[2].split(" ")[1].split(":")[1];
		req.setAttribute("deadline", deadline);

		Lpost_AddrDAO ladao = new Lpost_AddrDAO(); 
		req.setAttribute("addr", ladao.getAddr(boardnum));
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath("/app/board/modify.jsp?boardnum");
		return transfer;
	}
}
