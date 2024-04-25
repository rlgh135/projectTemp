package com.twojo.app.user;

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
import com.twojo.model.dao.UserDAO;
import com.twojo.model.dao.UserimgDAO;
import com.twojo.model.dto.UserimgDTO;

public class ModifyOkAction implements Action {
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String userid = (String)req.getSession().getAttribute("loginUser");
		String saveFolder = req.getServletContext().getRealPath("file/userimg");
		System.out.println(saveFolder);
		
		int size = (int)(1024*1024*1024*1.5);
		
		MultipartRequest multi = new MultipartRequest(req, saveFolder, size, "UTF-8", new DefaultFileRenamePolicy());
		Enumeration<?> temp = multi.getFileNames();
		ArrayList<String> fileNames = new ArrayList<String>();
		while(temp.hasMoreElements()) {
			fileNames.add((String)temp.nextElement());
		}
		int len = fileNames.size();
		fileNames.remove("file"+(len-1));
		
		Collections.reverse(fileNames);
		
		String useraddr = multi.getParameter("myaddr");
		String useraddrgu = useraddr;
		
		UserDAO udao = new UserDAO();
		
		
		boolean updateok = udao.updateuseraddr(userid, useraddr, useraddrgu);
		if(updateok) {
			System.out.println("성공");
		}
		
		Transfer transfer = new Transfer();
		transfer.setRedirect(true);
		//파일 데이터 삽입 성공 여부
		boolean fcheck = false;
		// 게시글을 쓸 때 파일을 업로드 했었는지 여부
		boolean flag = false;
		if (updateok) {
			UserimgDAO uidao = new UserimgDAO();

			for (String name : fileNames) {
				flag = true;
				String orgname = multi.getOriginalFileName(name);
				String systemname = multi.getFilesystemName(name);

				UserimgDTO uidto = new UserimgDTO();
				uidto.setUserid(userid);
				uidto.setUserimgorgname(orgname);
				uidto.setUserimgsysname(systemname);
				
				if(uidao.getimgcheck(userid)) {
					if(uidao.deleteUserFile(userid)) {
						fcheck = uidao.insertFile(uidto);
						if (!fcheck) {
							break;
						}
					}
				}
				else {
					fcheck = uidao.insertFile(uidto);
					if (!fcheck) {
						break;
					}
				}
			}
			// 파일 업로드 했니?
			if (flag) {
				System.out.println("업로드성공");
				// DB삽입은 실패했니?
				if (!fcheck) {
					for (String name : fileNames) {
						String systemname = multi.getFilesystemName(name);
						// DB상에 있는 t_file 테이블에 올라갔던 내용들 삭제
						uidao.deleteFile(systemname);

						// 실제 경로에 존재하는 파일을 자바의 객체로 가져옴
						File file = new File(saveFolder, systemname);
						// 파일이 존재한다면
						if (file.exists()) {
							// 삭제
							file.delete();
						}
					}
					//실패 페이지로 이동
				}
			}

			// get
			transfer.setPath(req.getContextPath() + "/myinfo.bo");

		} else {
			// list
			Cookie cookie = new Cookie("w", "f");
			cookie.setPath("/");
			cookie.setMaxAge(1);
			resp.addCookie(cookie);
			transfer.setPath(req.getContextPath() + "/myinfo.bo");
		}
		return transfer;
	}
}
