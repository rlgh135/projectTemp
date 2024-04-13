package com.twojo.app.group;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.GroupDAO;
import com.twojo.model.dao.GroupimgDAO;
import com.twojo.model.dao.UserDAO;
import com.twojo.model.dto.GroupDTO;
import com.twojo.model.dto.GroupimgDTO;
import com.twojo.model.dto.UserDTO;

public class GroupListOkAction implements Action {
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
//		나중에 로그인 세션에 유저 아이디가 담겨있을때 활성화
//		String userid = (String)req.getSession().getAttribute("loginUser");
		
		String userid = req.getParameter("userid");
		
		
		GroupDAO gdao = new GroupDAO();
		UserDAO udao = new UserDAO();
		
		UserDTO user = udao.getUserInfo(userid);
		req.setAttribute("user", user);
		
		
		List<GroupDTO> addrlist = gdao.getGroupList(user.getUseraddrgu());
		req.setAttribute("addrlist", addrlist);
		
		GroupimgDAO gidao = new GroupimgDAO();
		for(int i = 0; i < addrlist.size(); i++) {
			GroupimgDTO groupBestImg = gidao.getGroupimgList(addrlist.get(i).getGroupnum());
			
			req.setAttribute("groupBestImg"+i, groupBestImg);
		}
		
		
		
		String[] hobby = user.getUserhobby().split("☆");
		List<GroupDTO>[] hobbyLists = new List[4];
		for(int i=0; i<4; i++) {
			List<GroupDTO> hobbylist = gdao.getHobbyGroupList(user.getUseraddrgu(), hobby[i]);
			
			hobbyLists[i] = hobbylist;
			
			req.setAttribute("hobbylist"+i, hobbylist);
		}
		
		

		for (int i = 0; i < hobby.length; i++) {
		    List<GroupimgDTO> groupHobbyImg = new ArrayList<>();
		    
		    for (int j = 0; j < hobbyLists[i].size(); j++) {
		        long groupnum = hobbyLists[i].get(j).getGroupnum();
		        GroupimgDTO ghimg = gidao.getGroupimgList(groupnum);
		        groupHobbyImg.add(ghimg);
		    }
		    req.setAttribute("groupHobbyImg"+i, groupHobbyImg);
		}
		
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath("/app/group/groupAllList.jsp");
		return transfer;
	}
}
