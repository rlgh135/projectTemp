package com.twojo.app.ingroup;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.GPReplyDAO;
import com.twojo.model.dao.GPostDAO;
import com.twojo.model.dto.GPReplyDTO;

public class WriteGPReplyOKAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		long gpostnum = Long.parseLong(req.getParameter("gpostnum"));
		String userid = req.getParameter("userid");
		String gprcontents = req.getParameter("gprcontents");
		long groupnum = Long.parseLong(req.getParameter("groupnum"));
		
		GPReplyDTO gpreply = new GPReplyDTO();
		gpreply.setGpostnum(gpostnum);
		gpreply.setUserid(userid);
		gpreply.setGprcontents(gprcontents);
		
		GPReplyDAO gprdao = new GPReplyDAO();
		GPostDAO gpdao = new GPostDAO();
		Transfer transfer = new Transfer();
		if(gprdao.insert(gpreply)) {
			gpdao.addReplyCnt(gpostnum);
			transfer.setPath(req.getContextPath()+"/groupinner.gp?groupnum="+groupnum);			
		}
		
		return transfer;
	}
}
