package com.twojo.app.ingroup;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.GFileDAO;
import com.twojo.model.dao.GPostDAO;
import com.twojo.model.dto.GFileDTO;
import com.twojo.model.dto.GPostDTO;

public class GPWriteOkAction implements Action {
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		// cos : http://www.servlets.com

		// 파일이 실제로 저장될 경로
		String saveFolder = req.getServletContext().getRealPath("file/gfile");
		System.out.println(saveFolder);

		// 저장될 파일의 최대 크기(1.5GB)
		int size = (int) (1024 * 1024 * 1024 * 1.5);

		// cos 이용
		MultipartRequest multi = new MultipartRequest(req, saveFolder, size, "UTF-8", new DefaultFileRenamePolicy());

		// input[type=file]의 name 속성값들
		Enumeration<?> temp = multi.getFileNames();
		ArrayList<String> fileNames = new ArrayList<String>();
		while (temp.hasMoreElements()) {
			fileNames.add((String) temp.nextElement());
		}
		// fileNames 리스트에는 모든 input[type=file]의 name들이 추가되어 있다.
		// 비어있는 input[type=file] name도 추가되어 있으므로
		int len = fileNames.size();
		// 비어있는 그 name 하나 삭제
		fileNames.remove("writefile" + (len - 1));

		Collections.reverse(fileNames);

		String gposttitle = multi.getParameter("gptitle");
		String gpostcontents = multi.getParameter("gpcontents");
		String userid = multi.getParameter("userid");
		long groupnum = Long.parseLong(multi.getParameter("groupnum"));

		GPostDTO gpost = new GPostDTO();
		gpost.setGposttitle(gposttitle);
		gpost.setGpostcontents(gpostcontents);
		System.out.println(gpostcontents);
		gpost.setUserid(userid);
		gpost.setGroupnum(groupnum);

		GPostDAO gpdao = new GPostDAO();
		Transfer transfer = new Transfer();
		transfer.setRedirect(true);

		// 파일 데이터 삽입 성공 여부
		boolean fcheck = false;
		// 게시글을 쓸 때 파일을 업로드 했었는지 여부
		boolean flag = false;
		if (gpdao.insertGPost(gpost)) {
			long gpostnum = gpdao.getLastNum(userid);
			GFileDAO gfdao = new GFileDAO();

			for (String name : fileNames) {
				flag = true;
				String orgname = multi.getOriginalFileName(name);
				String systemname = multi.getFilesystemName(name);

				GFileDTO gfdto = new GFileDTO();
				gfdto.setGfileorgname(orgname);
				gfdto.setGfilesysname(systemname);
				gfdto.setGpostnum(gpostnum);

				fcheck = gfdao.insertFile(gfdto);

				if (!fcheck) {
					break;
				}
			}
			// 파일 업로드 했니?
			if (flag) {
				// DB삽입은 실패했니?
				if (!fcheck) {
					for (String name : fileNames) {
						String systemname = multi.getFilesystemName(name);
						// DB상에 있는 t_file 테이블에 올라갔던 내용들 삭제
						gfdao.deleteFile(systemname);

						// 실제 경로에 존재하는 파일을 자바의 객체로 가져옴
						File file = new File(saveFolder, systemname);
						// 파일이 존재한다면
						if (file.exists()) {
							// 삭제
							file.delete();
						}
					}
					gpdao.deleteGPost(gpostnum);
				}
			}

			// get
			transfer.setPath(req.getContextPath() + "/groupinner.gp?groupnum=" + groupnum);

		} else {
			System.out.println("ㅇ?");
			// list
			Cookie cookie = new Cookie("w", "f");
			cookie.setPath("/");
			cookie.setMaxAge(1);
			resp.addCookie(cookie);
			transfer.setPath(req.getContextPath() + "/groupinner.gp");
		}
		return transfer;
	}
}
