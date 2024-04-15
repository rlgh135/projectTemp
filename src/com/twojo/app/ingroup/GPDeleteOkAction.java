package com.twojo.app.ingroup;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.GFileDAO;
import com.twojo.model.dao.GPostDAO;
import com.twojo.model.dto.GFileDTO;

public class GPDeleteOkAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		long gpostnum = Long.parseLong(req.getParameter("gpostnum"));
		long groupnum = Long.parseLong(req.getParameter("groupnum"));
		System.out.println("groupnum: "+groupnum);
		
		GPostDAO gpdao = new GPostDAO();
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(true);
		System.out.println(1);
		String saveFolder = req.getServletContext().getRealPath("file");
		GFileDAO gfdao = new GFileDAO();
		List<GFileDTO> files = gfdao.getGFiles(gpostnum);
		
		if(gpdao.deleteGPost(gpostnum)) {
			for(GFileDTO gfdto : files) {
				File file = new File(saveFolder,gfdto.getGfilesysname());
				if(file.exists()) {
					gfdao.deleteFile(gfdto.getGfilesysname());
					file.delete();
				}
			}
			System.out.println(2);
			transfer.setPath(req.getContextPath() + "/groupinner.gp?groupnum=" + groupnum);
		}
		return transfer;
	}
}
