package com.twojo.app.ingroup;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Transfer;
import com.twojo.model.dao.GPostDAO;
import com.twojo.model.dao.GroupDAO;
import com.twojo.model.dao.GroupUserDAO;
import com.twojo.model.dao.GroupimgDAO;
import com.twojo.model.dto.GPostDTO;
import com.twojo.model.dto.GroupDTO;
import com.twojo.model.dto.GroupimgDTO;

public class GPostInnerOkAction {
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String temp = req.getParameter("page");
		int page = temp == null || temp.equals("") ? 1 : Integer.parseInt(temp);
		String keyword = req.getParameter("keyword");
		long groupnum = Long.parseLong(req.getParameter("groupnum"));
		String loginuser = (String)req.getSession().getAttribute("loginUser");
		
		//그룹 데이터 세팅
		GroupDAO gdao = new GroupDAO();
		GroupDTO group = gdao.findGroupByNum(groupnum);
		
		req.setAttribute("group", group);
		req.setAttribute("usercnt", gdao.getUserCntInGroup(groupnum));
	
		GroupUserDAO gudao = new GroupUserDAO();
		
		if(gudao.userInGroup(group.getGroupnum(), loginuser)==null) {
			req.setAttribute("usertype", "foreigner");
		} else {
			if (loginuser.equals(group.getGroupmaster())) {
				req.setAttribute("usertype", "common");
			} else {
				req.setAttribute("usertype", "groupmaster");
			}
		}
		
		
		//그룹 포스트 데이터 세팅
		GPostDAO gpdao = new GPostDAO();
		int pageSize = 4;
		
		//4개씩 불러오기
		int startRow = (page-1)*pageSize;
		List<GPostDTO> list = null;
		if(keyword == null || keyword.equals("")) {
			list = gpdao.getList(groupnum, startRow, pageSize);
		}
		else {
			list = gpdao.getListWithKeyword(groupnum,startRow,pageSize,keyword);
		}
		
		req.setAttribute("list", list);
		req.setAttribute("page", page);
		req.setAttribute("keyword", keyword);
		
		GPostDTO gongji = gpdao.getGongji(groupnum);
		List<GPostDTO> ingiList = gpdao.getIngi(groupnum);
		GPostDTO ingi;
		
		try {
			ingi = ingiList.get(0);
		} catch (IndexOutOfBoundsException e) {
			ingi = null;
		}
		
		req.setAttribute("gongji", gongji);
		req.setAttribute("ingi", ingi);
		
		GroupimgDAO gido = new GroupimgDAO();
		String thumbnail = gido.getGroupimg(groupnum);
		if(thumbnail!=null) {
			req.setAttribute("thumbnail", thumbnail);
		} else {
			req.setAttribute("thumbnail", "abcd25.jpg");
		}
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath("/app/group/groupinner.jsp?groupnum="+groupnum);
		return transfer;
	}
}
