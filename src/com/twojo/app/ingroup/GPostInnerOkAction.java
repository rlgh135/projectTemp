package com.twojo.app.ingroup;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Transfer;
import com.twojo.model.dao.GFileDAO;
import com.twojo.model.dao.GPReplyDAO;
import com.twojo.model.dao.GPostDAO;
import com.twojo.model.dao.GroupDAO;
import com.twojo.model.dto.GPostDTO;
import com.twojo.model.dto.GroupDTO;

public class GPostInnerOkAction {
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String temp = req.getParameter("page");
		int page = temp == null || temp.equals("") ? 1 : Integer.parseInt(temp);
		String keyword = req.getParameter("keyword");
		long groupnum = Long.parseLong(req.getParameter("groupnum"));
		
		//그룹 데이터 세팅
		GroupDAO gdao = new GroupDAO();
		GroupDTO group = gdao.findGroupByNum(groupnum);
		
		req.setAttribute("group", group);
		req.setAttribute("usercnt", gdao.getUserCntInGroup(groupnum));
		
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
		GPostDTO ingi = gpdao.getIngi(groupnum).get(0);
		
		req.setAttribute("gongji", gongji);
		req.setAttribute("ingi", ingi);
//		GPReplyDAO gprdao = new GPReplyDAO();
//		ArrayList<Integer> reply_cnt_list = new ArrayList<Integer>();
//		ArrayList<String> hot_board = new ArrayList<String>();
//		for(GPostDTO gpost : list) {
//			reply_cnt_list.add(gprdao.getReplyCnt(gpost.getGpostnum()));
//			int cnt = gprdao.getRecentReplyCnt(gpost.getGpostnum());
//			if(cnt < 5) {
//				hot_board.add("X");
//			}
//			else {
//				hot_board.add("O");
//			}
//		}
//		
//		req.setAttribute("reply_cnt_list", reply_cnt_list);
//		req.setAttribute("hot_board", hot_board);
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath("/app/group/groupinner.jsp?groupnum="+groupnum);
		return transfer;
	}
}
