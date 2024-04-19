package com.twojo.app.ingroup;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.GroupUserDAO;
import com.twojo.model.dao.ReqListDAO;
import com.twojo.model.dto.GroupUserDTO;
import com.twojo.model.dto.ReqListDTO;

public class CheckMoimAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		long groupnum = Long.parseLong(req.getParameter("groupnum"));		
		ReqListDAO reqdao = new ReqListDAO();
		List<ReqListDTO> anstemp = reqdao.getAnswerList(groupnum);
		ArrayList<ArrayList<String>> answer = new ArrayList<ArrayList<String>>();
		GroupUserDAO gudao = new GroupUserDAO();
		List<GroupUserDTO> guser = gudao.selectList(groupnum);
		try {
			for (int i = 0; i < anstemp.size(); i++) {
				String ansbase = anstemp.get(i).getAnswer();
				String[] anssplits = ansbase.split("§");
				
				ArrayList<String> anslist = new ArrayList<String>();
				for (int j = 0; j < anssplits.length; j++) {
					anslist.add(anssplits[j]);
				}
				
				answer.add(anslist);
			}
		} catch (NumberFormatException e) {
			answer = null;
		}
		
		req.setAttribute("answerlist", answer);
		req.setAttribute("ansbaselist", anstemp);
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(false);
		transfer.setPath(req.getContextPath()+"/app/group/checkMoim.jsp?groupnum="+groupnum);
		return transfer;
	}
}
