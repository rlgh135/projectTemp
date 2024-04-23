package com.twojo.app.board;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.LPostDAO;
import com.twojo.model.dao.LReplyDAO;
import com.twojo.model.dao.Lpost_UserDAO;
import com.twojo.model.dao.UserDAO;
import com.twojo.model.dto.LPostDTO;
import com.twojo.model.dto.LReplyDTO;
import com.twojo.model.dto.Lpost_UserDTO;
import com.twojo.model.dto.UserDTO;

public class BoardListOkAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String loginUser = (String)req.getSession().getAttribute("loginUser");
		String temp = req.getParameter("page");
		int page = temp == null || temp.equals("") ? 1 : Integer.parseInt(temp);
		String keyword = req.getParameter("keyword");
		String searchMenu = req.getParameter("searchMenu");
		
		UserDAO udao = new UserDAO();
		UserDTO user = udao.getUserById(loginUser);
		req.setAttribute("useraddr", user.getUseraddrgu());
		
		LPostDAO lpdao = new LPostDAO();
//		List<LPostDTO> LPlist = lpdao.getUserAddrList(userAddr)
//		UserDAO udao = new UserDAO();
//		LPostDAO lpdao = new LPostDAO(); 
//		String LoginUser = (String)req.getSession().getAttribute("loginUser");
//		
//		String userAddr = udao.getUserById(LoginUser).getUseraddr();
//		List<LPostDTO> LPlist = new ArrayList<>();
//		for(LPostDTO lpost : lpdao.getUserAddrList(userAddr)) {
//			LPlist.add(lpost);
//		}
//		
//		String loginUserAddr = udao.getUserAddr(LoginUser);
//		req.setAttribute("loginUser", userAddr);
//		req.setAttribute("LPlist", LPlist);
		
		
//		 public String yourHandlerMethod(Model model) {
//		        // 여기서 roadAddress 변수를 어딘가에서 가져와서 설정합니다
//		        String roadAddress = LoginUser; // 예시로 설정한 값입니다
//		        // 모델에 roadAddress 변수를 추가합니다
//		        model.addAttribute("roadAddress", roadAddress);
//		        // 뷰 이름을 반환합니다
//		        return "yourViewName";
//		    }
		
		
		

		
		LPostDAO bdao = new LPostDAO();
		
		
		//전체 게시글의 개수
		long totalCnt = 0;
		if(keyword == null || keyword.equals("")) {
			totalCnt = bdao.getBoardCnt();
		}
		else {
			totalCnt = bdao.getBoardCnt(keyword);
		}
		
		//한 페이지에서 보여줄 게시글의 개수
		int pageSize = 12;
		
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
		List<LPostDTO> list = null;
		
//		if((keyword == null || keyword.equals("")) && searchMenu.equals("") || searchMenu == null)
//			list = bdao.getList(startRow,pageSize);
//		else if(keyword != null && searchMenu.equals("") || searchMenu == null) 
//			list = bdao.getList(startRow,pageSize,keyword);
//		else
//			list = bdao.getList(startRow,pageSize,keyword, searchMenu);
		
		if(keyword == null || keyword.equals(""))
			list = bdao.getList(startRow,pageSize);
		else
			list = bdao.getList(startRow,pageSize,keyword);
		
		
		
		
		req.setAttribute("list", list);
		System.out.println(list.size());
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("totalCnt", totalCnt);
		req.setAttribute("startPage", startPage);
		req.setAttribute("endPage", endPage);
		req.setAttribute("page", page);
		req.setAttribute("keyword", keyword);
		req.setAttribute("placeName", req.getAttribute("placeName"));
		req.setAttribute("roadAddress", req.getAttribute("roadAddress"));
		

		
		
		LReplyDAO rdao = new LReplyDAO();
		ArrayList<Integer> reply_cnt_list = new ArrayList<Integer>();
		ArrayList<String> hot_board = new ArrayList<String>();
		for(LPostDTO board : list) {					
			reply_cnt_list.add(rdao.getReplyCnt(board.getLpostnum()));
			int cnt = rdao.getRecentReplyCnt(board.getLpostnum());
			if(cnt < 5) {
				hot_board.add("X");
			}
			else {
				hot_board.add("O");
			}
		}
		
		req.setAttribute("reply_cnt_list", reply_cnt_list);

		System.out.println("세션: boardlistokaction: "+req.getSession().getAttribute("loginUser"));
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath("/app/board/list1.jsp");
		return transfer;
	}
}








