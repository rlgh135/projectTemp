package com.twojo.app.reply;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.LReplyDAO;
import com.twojo.model.dto.LReplyDTO;

public class ReplyUpdateOkAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String i = req.getParameter("i");
		System.out.println(i);
		System.out.println(req.getParameter("replynum"));
		long lreplynum = Long.parseLong(req.getParameter("replynum"));
//		long boardnum = Long.parseLong(req.getParameter("boardnum"));
		String keyword = req.getParameter("keyword");
		String page = req.getParameter("page");
		
		String lreplycontents = req.getParameter("lreply"+i);
		
		LReplyDTO lreply = new LReplyDTO();
		lreply.setLreplycontents(lreplycontents);
		lreply.setLreplynum(lreplynum);
		
		LReplyDAO rdao = new LReplyDAO();
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();
		
		out.print("<script>");
		if(rdao.updateReply(lreply)) {
			out.print("alert('댓글 수정 성공!');");
		}
		else {
			out.print("alert('댓글 수정 실패!');");
		}
		//location.replace('/boardview.bo?boardnum=1&keyword=지우개&page=1')
		String format = String.format("location.replace('%s/boardview.bo?lreplynum=%s&keyword=%s&page=%s')",
				req.getContextPath(),lreplynum+"",keyword,page);
		out.print(format);
		out.print("</script>");
		return null;
	}
}

/*
<script>
	alert();
	location.replace();
</script>
 */





