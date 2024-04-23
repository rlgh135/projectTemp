package com.twojo.app.board;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.LPostDAO;
import com.twojo.model.dao.Lpost_AddrDAO;
//import com.twojo.model.dao.FileDAO;
import com.twojo.model.dto.LPostDTO;
import com.twojo.model.dto.Lpost_AddrDTO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
//import com.twojo.model.dto.FileDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import org.json.simple.JSONObject;

public class BoardWriteOkAction implements Action {
	Lpost_AddrDTO ladto = new Lpost_AddrDTO(); 
	@Override	
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		LPostDTO board = new LPostDTO();
		String boardtitle = req.getParameter("boardtitle");
		String boardcontents = req.getParameter("boardcontents");
		String userid = req.getParameter("userid");
		String boardaddr = req.getParameter("boardaddr");
		String[] mycheckBox = req.getParameterValues("selectedCategories");
		String boardcategory = "";
		String jsonDataInput = req.getParameter("jsonData"); 
		
		
		System.out.println("선택된 카테고리: ");
        if (mycheckBox != null) {
            for (String category : mycheckBox) {
            	boardcategory += (category + " ");
            }
        }
        
        System.out.println(boardcategory);
        
        String notime = req.getParameter("notime");
        if(notime==null) {
        	String month = req.getParameter("month");
        	String day = req.getParameter("day");
        	String hour = req.getParameter("hour");
        	String minute = req.getParameter("minute");
        	
        	if(month!=null) {
        		if(Integer.parseInt(month)<10) {
        			month = "0"+month;
        		}
        	} else {
        		month="00";
        	}
        	if(day!=null) {
        		if(Integer.parseInt(day)<10) {
        			day = "0"+day;
        		}
        	} else {
        		day ="00";
        	}
        	if(hour!=null) {
        		if(Integer.parseInt(hour)<10) {
        			hour = "0"+hour;
        		}
        	} else {
        		hour = "00";
        	}
        	if(minute!=null) {
        		if(Integer.parseInt(minute)<10) {
        			minute = "0"+minute;
        		}
        	} else {
        		minute = "00";
        	}
        	String deadline = "2024-"+month+"-"+day+" "+hour+":"+minute+":00";
        	System.out.println("deadline: "+deadline);
        	board.setDeadline(deadline);
        } else {
        	String deadline = "0000-00-00 00:00:00";
        	board.setDeadline(deadline);
        }
        
		board.setLposttitle(boardtitle);
		board.setLpostcontents(boardcontents);
		board.setUserid(userid);
		board.setLpostcategory(boardcategory);
		board.setLpostaddr("주소가 없습니다.");
		
		System.out.println(boardtitle);
		System.out.println(boardcontents);
		System.out.println(userid);
		System.out.println(boardaddr);
		System.out.println("jsonData " + jsonDataInput);
		
		LPostDAO bdao = new LPostDAO();
		Transfer transfer = new Transfer();
		transfer.setRedirect(true);
		
		if(bdao.insertBoard(board)) {
			long boardnum = bdao.getLastNum(userid);
			try {
				if(jsonDataInput != null) {
					setAddr(jsonDataInput, boardnum);
					String roadAddress = ladto.getRoadAddress();
					System.out.println("roadAddress: " + roadAddress);
					System.out.println(userid);
					if(roadAddress != null)
						bdao.setAddr(roadAddress, boardnum);	
				}
			} catch (Exception e) {
				System.out.println(e+"BoardWritOkAction에러입니다.");
			}
			transfer.setPath(req.getContextPath()+"/boardview.bo?lpostnum="+boardnum);
		} else {
			//list
			Cookie cookie = new Cookie("w","f");
			cookie.setPath("/");
			cookie.setMaxAge(1);
			resp.addCookie(cookie);
			transfer.setPath(req.getContextPath()+"/boardlist.bo");
		}
		return transfer;
	}
	
	
	private Lpost_AddrDTO setAddr(String jsonDataInput, long boardnum) {
		Lpost_AddrDAO ladao = new Lpost_AddrDAO();
		Gson gson = new Gson();
		JsonObject jsonobj = gson.fromJson(jsonDataInput, JsonObject.class);
		String placeName = jsonobj.get("placeName").getAsString();
		String roadAddress = jsonobj.get("roadAddress").getAsString();
		String address = jsonobj.get("address").getAsString();
		String phone = jsonobj.get("phone").getAsString();
		
		ladto.setPlaceName(placeName);
		ladto.setRoadAddress(roadAddress);
		ladto.setAddress(address);
		ladto.setPhone(phone);
		ladto.setLpostnum(boardnum);		
		
		ladao.insertAddr(ladto);

		return ladto;
	}
 
}









