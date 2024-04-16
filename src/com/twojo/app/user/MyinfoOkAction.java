package com.twojo.app.user;

import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.model.dao.UserDAO;
import com.twojo.model.dto.LPostDTO;
import com.twojo.model.dto.MyinfoDTO;
import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.LPostDAO;
import com.twojo.model.dao.MyinfoDAO;

public class MyinfoOkAction implements Action {
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {

    	String userid = (String)req.getSession().getAttribute("loginUser");
//        String lposttitle = req.getParameter("lposttitle");
//        String lpostlikecntStr = req.getParameter("lpostlikecnt");
        
//        int lpostlikecnt = Integer.parseInt(lpostlikecntStr); // 수정된 부분
        
        LPostDAO lpdao = new LPostDAO();
        List<LPostDTO> temp = lpdao.getboardinfoList(userid);
        
        req.setAttribute("lpost", temp);
        
        Transfer transfer = new Transfer();
        transfer.setRedirect(false);
        transfer.setPath("/app/user/myinfo.jsp");
        return transfer;
	}
}
