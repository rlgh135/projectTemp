package com.twojo.app.board;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.LPostDAO;
//import com.twojo.model.dao.FileDAO;
import com.twojo.model.dto.LPostDTO;
//import com.twojo.model.dto.FileDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardWriteOkAction implements Action {
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		LPostDTO board = new LPostDTO();
		String boardtitle = req.getParameter("boardtitle");
		String boardcontents = req.getParameter("boardcontents");
		String userid = req.getParameter("userid");
		String boardaddr = req.getParameter("boardaddr");
		String[] mycheckBox = req.getParameterValues("selectedCategories");
		String boardcategory = "";
		
		
		System.out.println("선택된 카테고리: ");
        if (mycheckBox != null) {
            for (String category : mycheckBox) {
            	boardcategory += (category + " ");
            }
        }
        
        System.out.println(boardcategory);
		
		board.setLposttitle(boardtitle);
		board.setLpostcontents(boardcontents);
		board.setUserid(userid);
		board.setLpostcategory(boardcategory);
		board.setLpostaddr(boardaddr);
		
		System.out.println(boardtitle);
		System.out.println(boardcontents);
		System.out.println(userid);
		System.out.println(boardaddr);
		
		LPostDAO bdao = new LPostDAO();
		Transfer transfer = new Transfer();
		transfer.setRedirect(true);
		
		
		if(bdao.insertBoard(board)) {
			long boardnum = bdao.getLastNum(userid);
			transfer.setPath(req.getContextPath()+"/boardview.bo?lpostnum="+boardnum);
		}else {
			//list
			Cookie cookie = new Cookie("w","f");
			cookie.setPath("/");
			cookie.setMaxAge(1);
			resp.addCookie(cookie);
			transfer.setPath(req.getContextPath()+"/boardlist.bo");
		}
		return transfer;
		

	}
}









