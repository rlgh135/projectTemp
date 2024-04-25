package com.twojo.app.group;

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
import com.twojo.model.dao.GroupDAO;
import com.twojo.model.dao.GroupUserDAO;
import com.twojo.model.dao.GroupimgDAO;
import com.twojo.model.dao.ReqListDAO;
import com.twojo.model.dto.GFileDTO;
import com.twojo.model.dto.GImgDTO;
import com.twojo.model.dto.GroupDTO;
import com.twojo.model.dto.GroupUserDTO;
import com.twojo.model.dto.GroupimgDTO;
import com.twojo.model.dto.ReqListDTO;

public class CreateGroupOkAction implements Action {
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String saveFolder = req.getServletContext().getRealPath("file/groupimg");
		int size = (int)(1024*1024*1024*1.5);
		
		MultipartRequest multi = new MultipartRequest(req,saveFolder,size,"UTF-8", new DefaultFileRenamePolicy());
		
		Enumeration<?> temp = multi.getFileNames();
		ArrayList<String> fileNames = new ArrayList<String>();
		while(temp.hasMoreElements()) {
			fileNames.add((String)temp.nextElement());
		}
		int len = fileNames.size();
		fileNames.remove("file"+(len-1));
		
		Collections.reverse(fileNames);
		System.out.println(fileNames);
		/*
		 * it_name : 그룹이름
		 * it_region : 그룹어드레스
		 * ca_id_s : 그룹 카테고리
		 * it_info : 그룹 컨텐츠
		 * loginUser : 그룹 마스터
		 * 
		 * file0 : 썸네일
		 * 
		 * autoreg : 1 자동가입 0 승인 후 가입
		 * */
		
		String groupmaster = multi.getParameter("groupmaster");
		String groupname = multi.getParameter("it_name");
		String groupaddr = multi.getParameter("it_region");
		String groupcategory = multi.getParameter("ca_id_s");
		String groupcontents = multi.getParameter("it_info");
		int autoreg = Integer.parseInt(multi.getParameter("autoreg"));
		
		GroupDTO group = new GroupDTO();
		group.setGroupmaster(groupmaster);
		group.setGroupname(groupname);
		group.setGroupcategory(groupcategory);
		group.setGroupaddr(groupaddr);
		group.setGroupcontents(groupcontents);

		GroupDAO gdao = new GroupDAO();
		boolean insertok = gdao.createGroup(group);
		if(insertok) {
			System.out.println("성공");
			
		}
		
	
		Transfer transfer = new Transfer();
		//파일 데이터 삽입 성공 여부
		boolean fcheck = false;
		//게시글을 쓸 때 파일을 업로드 했었는지 여부
		boolean flag = false;
		System.out.println(gdao.getLastGroupnum(groupmaster));
		if(insertok) {
			long groupnum = gdao.getLastGroupnum(groupmaster);
			
			ReqListDAO reqdao = new ReqListDAO();
			ReqListDTO question = new ReqListDTO();
			question.setAutoreg(autoreg);
			question.setGroupnum(groupnum);
			question.setLeaderid(groupmaster);
			if(autoreg==0) {
				question.setQuestion("모임에 가입하시겠어요?§");
			} else {
				question.setQuestion("§");
			}
			reqdao.createQuestion(question);
			
			GroupimgDAO gidao = new GroupimgDAO();
			
			GroupUserDTO groupuser = new GroupUserDTO();
			GroupUserDAO gudao = new GroupUserDAO();
			
			groupuser.setUserid(groupmaster);
			groupuser.setGroupnum(groupnum);
			gudao.insert(groupuser);
			
			for(String name : fileNames) {
				System.out.println("2. 루프");
				flag = true;
				String orgname = multi.getOriginalFileName(name);
				String systemname = multi.getFilesystemName(name);
				
				GroupimgDTO groupimg = new GroupimgDTO();
				groupimg.setGroupnum((int)groupnum);
				groupimg.setImgorgname(orgname);
				groupimg.setImgsysname(systemname);
				
				fcheck=gidao.insertFile(groupimg);
				
				if(!fcheck) {
					break;
				}
			}
			//파일 업로드 했니?
			if(flag) {
				System.out.println(3);
				//DB삽입은 실패했니?
				if(!fcheck) {
					for(String name : fileNames) {
						String systemname = multi.getFilesystemName(name);
						//DB상에 있는 t_file 테이블에 올라갔던 내용들 삭제
						gidao.deleteFile(systemname);
						
						//실제 경로에 존재하는 파일을 자바의 객체로 가져옴
						File file = new File(saveFolder,systemname);
						//파일이 존재한다면
						if(file.exists()) {
							//삭제
							file.delete();
						}
					}
//					gdao.deleteGroup(boardnum);
					//실패 페이지로 이동
				}
				transfer.setPath(req.getContextPath()+"/groupAllList.gr?="+groupmaster);
			}
			
			//get
			
		}
		else {
			//list
			Cookie cookie = new Cookie("w","f");
			cookie.setPath("/");
			cookie.setMaxAge(1);
			resp.addCookie(cookie);
			transfer.setPath(req.getContextPath()+"/groupAllList.gr");
		}
	
				
		transfer.setRedirect(true);
		transfer.setPath(req.getContextPath()+"/");
		return transfer;
	}
}

