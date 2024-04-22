package com.twojo.app.ingroup;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.GPostDAO;
import com.twojo.model.dao.GPostLikeDAO;
import com.twojo.model.dto.GPostLikeDTO;

public class PressLike implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String userid = req.getParameter("userid");
		long gpostnum = Long.parseLong(req.getParameter("gpostnum"));
		PrintWriter out = resp.getWriter();
		
		GPostLikeDTO gpostlike = new GPostLikeDTO();
		gpostlike.setGpostnum(gpostnum);
		gpostlike.setUserid(userid);
		
		GPostLikeDAO gpldao = new GPostLikeDAO();
		GPostDAO gpdao = new GPostDAO();
		System.out.println(gpldao.getLike(gpostlike).getUserid());
		if(gpldao.getLike(gpostlike)!=null) {
			System.out.println(1);
			if(gpdao.removeLikeCnt(gpostnum)) {
				System.out.println(2);
				out.print("X");
			}
		} else {
			if(gpldao.addLike(gpostlike)) {
				if(gpdao.addLikeCnt(gpostnum)) {
					System.out.println(3);
					out.print("O");
				}
			}
		}
		out.flush();
		
		return null;
	}
}
