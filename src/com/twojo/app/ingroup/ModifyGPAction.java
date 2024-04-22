package com.twojo.app.ingroup;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.GPostDAO;

public class ModifyGPAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		long groupnum = Long.parseLong(req.getParameter("groupnum"));
		long gpostnum = Long.parseLong(req.getParameter("gpostnum"));
		String gpostcontents = req.getParameter("gpostcontents");
		String gpostregdate = req.getParameter("gpostregdate");
		
		GPostDAO gpdao = new GPostDAO();
		if(gpdao.updateGpost(gpostnum, gpostcontents, gpostregdate));
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath(req.getContextPath()+"/groupinner.gp?groupnum="+groupnum);
		return transfer;
	}
}
