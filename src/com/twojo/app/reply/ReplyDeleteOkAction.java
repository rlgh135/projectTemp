package com.twojo.app.reply;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.LReplyDAO;

public class ReplyDeleteOkAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		long replynum = Long.parseLong(req.getParameter("lreplynum"));
		long boardnum = Long.parseLong(req.getParameter("boardnum"));
		System.out.println("boardnum: " + boardnum);
		String keyword = req.getParameter("keyword");
		String page = req.getParameter("page");
		
		LReplyDAO rdao = new LReplyDAO();
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();
		
		out.print("<script>");
		if(rdao.deleteReply(replynum)) {
			out.print("alert('댓글 삭제 성공!');");
		}
		else {
			out.print("alert('댓글 삭제 실패!');");
		}
		String format = String.format("location.replace('%s/boardview.bo?lpostnum=%s&keyword=%s&page=%s')",
				req.getContextPath(),boardnum+"",keyword,page);
		out.print(format);
		out.print("</script>");
		return null;
	}
}
