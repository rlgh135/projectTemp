package com.twojo.app.user;

import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.model.dao.UserDAO;
import com.twojo.model.dto.MyinfoDTO;
import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.MyinfoDAO;

public class MyinfoOkAction implements Action {
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String userid = req.getParameter("userid");
		
		MyinfoDAO mdao = new MyinfoDAO();
		UserDAO udao = new UserDAO();
		
		List<Map<String, Object>> myinfo = mdao.getTitleAndLikeCountList();
		req.setAttribute("addboard", myinfo);
//		
//		List<MyObject> myObjects = MyinfoDAO.getAllObjects(); // 데이터베이스에서 객체 목록을 가져옴
//
//		request.setAttribute("myObjects", myObjects); // JSP로 객체 목록 전달
//		RequestDispatcher dispatcher = request.getRequestDispatcher("myPage.jsp");
//		dispatcher.forward(request, response);

		
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath("/app/user/myinfo.jsp");
		return transfer;
	}
}
