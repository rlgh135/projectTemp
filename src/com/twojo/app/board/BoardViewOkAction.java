package com.twojo.app.board;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.LPostDAO;
//import com.twojo.model.dao.FileDAO;
import com.twojo.model.dao.LReplyDAO;
import com.twojo.model.dao.Lpost_UserDAO;
import com.twojo.model.dto.LPostDTO;
import com.twojo.model.dto.Lpost_UserDTO;

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
		System.out.println("bordviewok"+loginUser);
		
		LPostDAO bdao = new LPostDAO();
		
		LPostDTO board = bdao.getBoardByNum(boardnum);
		if(!board.getUserid().equals(loginUser)) {
			bdao.updateReadCount(boardnum);
			board.setReadcount(board.getReadcount()+1);
		}

		LReplyDAO rdao = new LReplyDAO();
		Lpost_UserDTO ludto = new Lpost_UserDTO();
		Lpost_UserDAO ludao = new Lpost_UserDAO();
		
		ludto.setUserid(loginUser);
		ludto.setBoardnum(boardnum);
		

		req.setAttribute("board", board);
		req.setAttribute("replies", rdao.getReplies(boardnum));
		req.setAttribute("checkUser", ludao.checkUser(ludto));

		String userId = "";
		for (String userID : ludao.getUserList(boardnum)) {
            userId += (userID + "<br>");
            
            req.setAttribute("message", req.getAttribute("message"));
        }
		req.setAttribute("lpost_user_list", userId);
		
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath(req.getContextPath()+"/app/board/get.jsp");
		return transfer;
	}
}
