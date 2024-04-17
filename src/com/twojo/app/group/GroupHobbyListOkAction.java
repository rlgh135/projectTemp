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

public class GroupHobbyListOkAction implements Action {
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {

//		String userid = req.getParameter("userid");
		String userid = (String)req.getSession().getAttribute("loginUser");
		String hobbykeyword = req.getParameter("hobbykeyword");
		String temp = req.getParameter("page");
		int page = temp == null || temp.equals("") ? 1 : Integer.parseInt(temp);
//		나중에 검색 버튼 생성시 활성화
		String keyword = req.getParameter("keyword");
		
		GroupDAO gdao = new GroupDAO();
		GroupimgDAO gidao = new GroupimgDAO();
		UserDAO udao = new UserDAO();
		
		UserDTO user = udao.getUserInfo(userid);
		req.setAttribute("user", user);
		
		List<GroupDTO> addrlist = gdao.getGroupList(user.getUseraddrgu(), hobbykeyword);
		req.setAttribute("addrlist", addrlist);
		
		List<GroupimgDTO> groupHobbyBestImg = new ArrayList<>();
		
		for(int i = 0; i < addrlist.size(); i++) {
			GroupimgDTO BestListImg = gidao.getGroupimgList(addrlist.get(i).getGroupnum());
			
			groupHobbyBestImg.add(BestListImg);
		}
		req.setAttribute("groupHobbyBestImg", groupHobbyBestImg);
		
		
		int totalCnt = 0;
		if(keyword == null || keyword.equals("")) {
			totalCnt = gdao.getGroupCnt(user.getUseraddrgu(), hobbykeyword);
		}
		else {
			totalCnt = gdao.getGroupCnt(user.getUseraddrgu(), hobbykeyword, keyword);
		}
		
		//한 페이지에서 보여줄 게시글의 개수
		int pageSize = 10;
		
		//페이징 처리 시 아래에 나올 페이지 번호의 개수
		int pageCnt = 10;
		
		//아래쪽 페이징 처리 부분에 보여질 첫 번째 페이지 번호
		int startPage = (page-1)/pageCnt*pageCnt+1;
		
		//아래쪽 페이징 처리 부분에 보여질 마지막 페이지 번호
		int endPage = startPage + (pageCnt-1);
		
		//전체 개시글의 개수를 기반으로 한 띄워질 수 있는 가장 마지막 페이지(실제로 존재할 수 있는 가장 마지막 페이지) 번호
		int totalPage = (int)(totalCnt-1)/pageSize + 1;

		//가장 마지막 페이지 번호(totalPage)보다 단순한 연산으로 구해진 endPage가 더 큰 경우가 있다.(허구의 페이지 번호가 존재할 수 있다)
		//그 때는 endPage를 가장 마지막 페이지 번호(totalPage)로 바꿔주어야 한다.
		endPage = endPage > totalPage ? totalPage : endPage;
		
		int startRow = (page-1)*pageSize;
		List<GroupDTO> list = null;
		List<GroupimgDTO> groupHobbyListImg = new ArrayList<>();
		if(keyword == null || keyword.equals("")) {
			list = gdao.getHobbyList(user.getUseraddrgu(),hobbykeyword,startRow,pageSize);
			
			for (int i = 0; i < list.size(); i++) {
				GroupimgDTO ListImg = gidao.getGroupimgList(list.get(i).getGroupnum());
			    
				groupHobbyListImg.add(ListImg);
			}
			
		}
		else {
			list = gdao.getHobbyList(user.getUseraddrgu(), hobbykeyword, keyword,startRow,pageSize);
		}
		
		req.setAttribute("list", list);
		req.setAttribute("groupHobbyListImg", groupHobbyListImg);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("totalCnt", totalCnt);
		req.setAttribute("startPage", startPage);
		req.setAttribute("endPage", endPage);
		req.setAttribute("page", page);
		req.setAttribute("keyword", keyword);
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath("/app/group/groupChoiceList.jsp");
		return transfer;
	}
}
