package com.twojo.app.ingroup;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.ReqListDAO;

public class ChangeOkAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		long groupnum = Long.parseLong(req.getParameter("groupnum"));
		int autoreg = Integer.parseInt(req.getParameter("auto"));
		System.out.println("groupnum:"+groupnum);
		System.out.println("autoreg:"+autoreg);
		
		ReqListDAO reqdao = new ReqListDAO();
		
		reqdao.changeAuto(autoreg, groupnum);
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath(req.getContextPath()+"/groupinner.gp?groupnum"+groupnum);
		return transfer;
	}
}
