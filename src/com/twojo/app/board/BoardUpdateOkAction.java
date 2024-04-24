package com.twojo.app.board;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.LPostDAO;
import com.twojo.model.dao.Lpost_AddrDAO;
//import com.twojo.model.dao.FileDAO;
import com.twojo.model.dto.LPostDTO;
import com.twojo.model.dto.Lpost_AddrDTO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
//import com.twojo.model.dto.FileDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardUpdateOkAction implements Action {
	Lpost_AddrDTO ladto = new Lpost_AddrDTO();
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		System.out.println("boardUpdateOKAction들어옴");
		
		String page = req.getParameter("page");
		String keyword = req.getParameter("keyword");
		long lpostnum = Long.parseLong(req.getParameter("boardnum"));
		String boardtitle = req.getParameter("boardtitle");
		String boardcontents = req.getParameter("boardcontents");
		String userid = req.getParameter("userid");

		LPostDTO board = new LPostDTO();
		board.setLpostnum(lpostnum);
		board.setLposttitle(boardtitle);
		board.setLpostcontents(boardcontents);
		board.setUserid(userid);

		//시간 설정
		String notime = req.getParameter("notime");
		if (notime == null) {
			String month = req.getParameter("month");
			String day = req.getParameter("day");
			String hour = req.getParameter("hour");
			String minute = req.getParameter("minute");

			if (month != null) {
				if (Integer.parseInt(month) < 10) {
					month = "0" + month;
				}
			} else {
				month = "00";
			}
			if (day != null) {
				if (Integer.parseInt(day) < 10) {
					day = "0" + day;
				}
			} else {
				day = "00";
			}
			if (hour != null) {
				if (Integer.parseInt(hour) < 10) {
					hour = "0" + hour;
				}
			} else {
				hour = "00";
			}
			if (minute != null) {
				if (Integer.parseInt(minute) < 10) {
					minute = "0" + minute;
				}
			} else {
				minute = "00";
			}
			String deadline = "2024-" + month + "-" + day + " " + hour + ":" + minute + ":00";
			System.out.println("deadline: " + deadline);
			board.setDeadline(deadline);
		} else {
			String deadline = "0000-00-00 00:00:00";
			board.setDeadline(deadline);
		}

		//주소 설정
		String[] mycheckBox = req.getParameterValues("selectedCategories");
		String boardcategory = "";
		String jsonDataInput = req.getParameter("jsonData"); 
		if (mycheckBox != null) {
            for (String category : mycheckBox) {
            	boardcategory += (category + " ");
            }
        }
		
		setAddr(jsonDataInput, lpostnum);
		
		board.setLpostcategory(boardcategory);
		board.setLpostaddr(ladto.getRoadAddress());
		
		LPostDAO bdao = new LPostDAO();
		Lpost_AddrDAO ladao = new Lpost_AddrDAO();
		Transfer transfer = new Transfer();
		transfer.setRedirect(true);
		
		if (bdao.updateBoard(board)) {
			System.out.println("bdao.updateBoard 성공");
			if(ladao.updateAddr(ladto)) {
				System.out.println("ladto.updateBoard 성공");
			}
		} else {
			System.out.println("bdao.updateBoard 실패");
		}
		String queryString = String.format("?lpostnum=%s&keyword=%s&page=%s", lpostnum + "", keyword, page);
		transfer.setPath(req.getContextPath() + "/boardview.bo" + queryString);
		return transfer;
	}
	private Lpost_AddrDTO setAddr(String jsonDataInput, long boardnum) {
		Gson gson = new Gson();
		JsonObject jsonobj = gson.fromJson(jsonDataInput, JsonObject.class);
		if(jsonobj != null) {
			String placeName = jsonobj.get("placeName").getAsString();
			String roadAddress = jsonobj.get("roadAddress").getAsString();
			String address = jsonobj.get("address").getAsString();
			String phone = jsonobj.get("phone").getAsString();
			
			ladto.setPlaceName(placeName);
			ladto.setRoadAddress(roadAddress);
			ladto.setAddress(address);
			ladto.setPhone(phone);
			ladto.setLpostnum(boardnum);
			
			return ladto;
		}
		return null;
		
	}
}
