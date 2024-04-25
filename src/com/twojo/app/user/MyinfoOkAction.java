package com.twojo.app.user;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.model.dao.GroupUserDAO;
import com.twojo.model.dao.LPostDAO;
import com.twojo.model.dao.Lpost_UserDAO;
import com.twojo.model.dao.UserDAO;
import com.twojo.model.dao.UserimgDAO;
import com.twojo.model.dto.UserDTO;
import com.twojo.model.dto.UserimgDTO;
import com.twojo.action.Action;
import com.twojo.action.Transfer;

public class MyinfoOkAction implements Action {
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		Transfer transfer = new Transfer();

		String userid = (String) req.getSession().getAttribute("loginUser");

		if (userid == null) {
			transfer.setRedirect(true);
			transfer.setPath(req.getContextPath() + "/");
			return transfer;
		}

		UserDAO udao = new UserDAO();
		UserDTO user = udao.getUserById(userid);
		
		req.setAttribute("user", user);

		String joinday = user.getJoinregdate();
		
		int year = Integer.parseInt(joinday.split("-")[0]);
		int month = Integer.parseInt(joinday.split("-")[1]);
		int day = Integer.parseInt(joinday.split("-")[2].split(" ")[0]);
		
		// 비교할 두 날짜를 생성
        LocalDate startDate = LocalDate.of(year, month, day); // 시작 날짜
        LocalDate endDate = LocalDate.now(); // 현재 날짜를 가져옵니다.

        // 두 날짜 사이의 일 수를 계산
        long daysBetween = ChronoUnit.DAYS.between(startDate, endDate)+1;
		
        req.setAttribute("daysBetween", daysBetween);
        
        GroupUserDAO gudao = new GroupUserDAO();
        LPostDAO lpdao = new LPostDAO();
        
        int lpostcnt = lpdao.getMyLpostCnt(userid);
        int groupjoincnt = gudao.getMyGroupJoinCnt(userid);
        
        req.setAttribute("lpostcnt", lpostcnt);
		req.setAttribute("groupjoincnt", groupjoincnt);
		
        UserimgDAO uidao = new UserimgDAO();
		UserimgDTO userimg = uidao.getImgName(userid);
        
		req.setAttribute("userimg", userimg);
		
		transfer.setRedirect(false);
		transfer.setPath(req.getContextPath()+"/app/user/myinfo.jsp");

		return transfer;
	}
}
