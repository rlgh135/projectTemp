package com.twojo.app.board;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.LPostDAO;
import com.twojo.model.dao.LReplyDAO;
import com.twojo.model.dao.Lpost_UserDAO;
import com.twojo.model.dao.UserDAO;
import com.twojo.model.dto.LPostDTO;
import com.twojo.model.dto.LReplyDTO;
import com.twojo.model.dto.Lpost_UserDTO;
import com.twojo.model.dto.UserDTO;

public class BoardListOkAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String loginUser = (String)req.getSession().getAttribute("loginUser");
		String temp = req.getParameter("page");
		int page = temp == null || temp.equals("") ? 1 : Integer.parseInt(temp);
		String keyword = req.getParameter("keyword");
		String searchMenu = req.getParameter("searchMenu");
		
		UserDAO udao = new UserDAO();
		UserDTO user = udao.getUserById(loginUser);
		req.setAttribute("useraddr", user.getUseraddrgu());
		
		LPostDAO lpdao = new LPostDAO();
		LPostDAO bdao = new LPostDAO();
		
		List<LPostDTO> quickpost = lpdao.getQuickPost(user.getUseraddrgu());
		req.setAttribute("quickpost", quickpost);
		
		//전체 게시글의 개수
		long totalCnt = 0;
		if(keyword == null || keyword.equals("")) {
			totalCnt = bdao.getBoardCnt();
		}
		else {
			totalCnt = bdao.getBoardCnt(keyword);
		}
		
		int pageSize = 12;
		int pageCnt = 10;
		int startPage = (page-1)/pageCnt*pageCnt+1;
		int endPage = startPage + (pageCnt-1);
		int totalPage = (int)(totalCnt-1)/pageSize + 1;
		
		endPage = endPage > totalPage ? totalPage : endPage;
		
		int startRow = (page-1)*pageSize;
		
		List<LPostDTO> list = null;
		
		if(keyword == null || keyword.equals(""))
			list = bdao.getList(startRow,pageSize);
		else
			list = bdao.getList(startRow,pageSize,keyword);
		
		req.setAttribute("list", list);
		System.out.println(list.size());
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("totalCnt", totalCnt);
		req.setAttribute("startPage", startPage);
		req.setAttribute("endPage", endPage);
		req.setAttribute("page", page);
		req.setAttribute("keyword", keyword);
		req.setAttribute("placeName", req.getAttribute("placeName"));
		req.setAttribute("roadAddress", req.getAttribute("roadAddress"));
		
		LReplyDAO rdao = new LReplyDAO();
		ArrayList<Integer> reply_cnt_list = new ArrayList<Integer>();
		ArrayList<String> hot_board = new ArrayList<String>();
		for(LPostDTO board : list) {					
			reply_cnt_list.add(rdao.getReplyCnt(board.getLpostnum()));
			int cnt = rdao.getRecentReplyCnt(board.getLpostnum());
			if(cnt < 5) {
				hot_board.add("X");
			}
			else {
				hot_board.add("O");
			}
		}
		
		req.setAttribute("reply_cnt_list", reply_cnt_list);

		System.out.println("세션: boardlistokaction: "+req.getSession().getAttribute("loginUser"));
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath("/app/board/list1.jsp");
		return transfer;
	}
}








