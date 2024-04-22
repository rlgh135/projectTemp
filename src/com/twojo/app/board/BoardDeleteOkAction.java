package com.twojo.app.board;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.LPostDAO;
//import com.twojo.model.dao.FileDAO;
//import com.twojo.model.dto.FileDTO;
import com.twojo.model.dao.Lpost_AddrDAO;

public class BoardDeleteOkAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		long boardnum = Long.parseLong(req.getParameter("boardnum"));
		String keyword = req.getParameter("keyword");
		String temp = req.getParameter("page");
		int page = temp==null||temp.equals("") ? 1 : Integer.parseInt(temp);
		
		keyword = URLEncoder.encode(keyword,"UTF-8");
		
		LPostDAO bdao = new LPostDAO();
		Lpost_AddrDAO ladao= new Lpost_AddrDAO();
		
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(true);

		
		if(ladao.deleteBoard(boardnum)){
			if(bdao.deleteBoard(boardnum)) {
				transfer.setPath(req.getContextPath()+"/boardlist.bo?page="+page+"&keyword="+keyword);
			}
		}
		else {
			System.out.println("else진입");
			transfer.setPath(req.getContextPath()+"/boardview.bo?page="+page+"&keyword="+keyword+"&boardnum="+boardnum);
		}
		return transfer;
	}
}

















