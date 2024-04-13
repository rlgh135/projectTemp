package com.twojo.app.reply;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.LReplyDAO;
import com.twojo.model.dto.LReplyDTO;

public class ReplyWriteOkAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		System.out.println("ReplyWriteOkAction  들어옴");
		long lpostnum = Long.parseLong(req.getParameter("boardnum"));
		String lreplycontents = req.getParameter("lreplycontents");
		String userid = (String)req.getSession().getAttribute("loginUser");
		String page = req.getParameter("page");
		String keyword = req.getParameter("keyword");
		
		LReplyDTO lreply = new LReplyDTO();
		lreply.setBoardnum(lpostnum);
		lreply.setLreplycontents(lreplycontents);
		lreply.setUserid(userid);
		
		LReplyDAO rdao = new LReplyDAO();
//		Transfer transfer = new Transfer();
//		transfer.setRedirect(true);
//		transfer.setPath(req.getContextPath()+"/boardview.bo?boardnum=");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();
		
		out.print("<script>");
		if(rdao.insertReply(lreply)) {
			out.print("alert('댓글 등록 성공!');");
		}
		else {
			out.print("alert('댓글 등록 실패!');");
		}
		//location.replace('/boardview.bo?boardnum=1&keyword=지우개&page=1')
		String format = String.format("location.replace('%s/boardview.bo?lpostnum=%s&keyword=%s&page=%s')",
				req.getContextPath(),lpostnum+"",keyword,page);
		out.print(format);
		out.print("</script>");
		
		return null;
	}
}






