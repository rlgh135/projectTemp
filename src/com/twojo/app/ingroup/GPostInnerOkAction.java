package com.twojo.app.ingroup;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Transfer;
import com.twojo.model.dao.GPostDAO;
import com.twojo.model.dao.GroupDAO;
import com.twojo.model.dao.GroupUserDAO;
import com.twojo.model.dao.GroupimgDAO;
import com.twojo.model.dao.UserimgDAO;
import com.twojo.model.dto.GPostDTO;
import com.twojo.model.dto.GroupDTO;
import com.twojo.model.dto.GroupimgDTO;

public class GPostInnerOkAction {
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
//		String temp = req.getParameter("page");
//		int page = temp == null || temp.equals("") ? 1 : Integer.parseInt(temp);
//		String keyword = req.getParameter("keyword");
		long groupnum = Long.parseLong(req.getParameter("groupnum"));
		String loginuser = (String)req.getSession().getAttribute("loginUser");
		
		//그룹 데이터 세팅
		GroupDAO gdao = new GroupDAO();
		GroupDTO group = gdao.findGroupByNum(groupnum);
		
		req.setAttribute("group", group);
		req.setAttribute("usercnt", gdao.getUserCntInGroup(groupnum));
	
		GroupUserDAO gudao = new GroupUserDAO();
		
		if(gudao.userInGroup(group.getGroupnum(), loginuser)==null) {
			req.setAttribute("usertype", 0);
		} else {
			if (loginuser.equals(group.getGroupmaster())) {
				req.setAttribute("usertype", 1);
			} else {
				req.setAttribute("usertype", 1);
			}
		}
		
		
		GPostDAO gpdao = new GPostDAO();
		GPostDTO gongji = gpdao.getGongji(groupnum);
		UserimgDAO uidao = new UserimgDAO();
		String gongjithumbnail = "defaultuserbadge.png";
		
		if(gongji!=null) {
			gongjithumbnail = uidao.getImgName(gongji.getUserid()).getUserimgsysname();
		}
		
		List<GPostDTO> ingiList = gpdao.getIngi(groupnum);
		GPostDTO ingi;
		String ingithumbnail = "defaultuserbadge.png";
		
		try {
			ingi = ingiList.get(0);
			ingithumbnail = uidao.getImgName(ingi.getUserid()).getUserimgsysname();
		} catch (IndexOutOfBoundsException e) {
			ingi = null;
		}
		
		req.setAttribute("gongji", gongji);
		req.setAttribute("gongjithumbnail", gongjithumbnail);
		req.setAttribute("ingi", ingi);
		req.setAttribute("ingithumbnail", ingithumbnail);
		
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
