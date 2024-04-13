package com.twojo.app.board;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.action.Action;
import com.twojo.action.Transfer;
import com.twojo.model.dao.LPostDAO;
//import com.twojo.model.dao.FileDAO;
import com.twojo.model.dto.LPostDTO;
//import com.twojo.model.dto.FileDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardUpdateOkAction implements Action{
	@Override
	public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		System.out.println("boardUpdateOKAction들어옴");
//		String saveFolder = req.getServletContext().getRealPath("file");
//		int size = (int)(1024*1024*1024*1.5);
//		
//		MultipartRequest multi = new MultipartRequest(req,saveFolder,size,"UTF-8",
//				new DefaultFileRenamePolicy());
		//삭제해야 할 파일명들
//		String updateCnt = req.getParameter("updateCnt");
//		System.out.println("updateCnt:"+updateCnt);
		String page = req.getParameter("page");
		String keyword = req.getParameter("keyword");		
		long lpostnum = Long.parseLong(req.getParameter("boardnum"));
		String boardtitle = req.getParameter("boardtitle");
		String boardcontents = req.getParameter("boardcontents");
		String userid = req.getParameter("userid");
		
		LPostDTO board = new LPostDTO();
		board.setLpostnum(lpostnum);
		board.setLposttitle(boardtitle);
		board.setLpostcontents(boardcontents);
		board.setUserid(userid);
		//input[type=file] 의 name들
//		Enumeration<?> temp = multi.getFileNames();
//		ArrayList<String> fileNames = new ArrayList<String>();
//		while(temp.hasMoreElements()) {
//			fileNames.add((String)temp.nextElement());
//		}
//		//fileNames 리스트에는 모든 input[type=file]의 name들이 거꾸로 추가되어 있다.
//		int len = fileNames.size();
//		Collections.reverse(fileNames);
//		fileNames.remove(len-1);
//		System.out.println("filenames : "+fileNames);
//		
//		FileDAO fdao = new FileDAO();
//		//파일이 없음 O
//		//파일이 있었고 수정을 안함 
//		//파일이 있었고 수정을 함
//		
//		boolean flag = false;
//		boolean fcheck = false;
//		int cnt = 0;
//		for(String name : fileNames) {
//			flag = true;
//			String orgname = multi.getOriginalFileName(name);
//			String systemname = multi.getFilesystemName(name);
//			//orgname이 null이라는 뜻은 실제 파일데이터는 날라오지 않았다는 뜻
//			//기존 파일에서 변화 없이 그대로 뒀다는 뜻(새롭게 insert 하지 않아야 한다.)
//			if(orgname == null){
//				continue;
//			}
//			
//			FileDTO fdto = new FileDTO();
//			fdto.setBoardnum(boardnum);
//			fdto.setOrgname(orgname);
//			fdto.setSystemname(systemname);
//			
//			fcheck=fdao.insertFile(fdto);
//			cnt++;
//			if(!fcheck) {
//				break;
//			}
//		}
//
//		//파일 업로드 했니?
//		if(flag) {
//			if(cnt == 0) {
//				
//			}
//			else {
//				//DB삽입은 실패했니?
//				if(!fcheck) {
//					for(String name : fileNames) {
//						String systemname = multi.getFilesystemName(name);
//						//DB상에 있는 t_file 테이블에 올라갔던 내용들 삭제
//						fdao.deleteFile(systemname);
//						
//						//실제 경로에 존재하는 파일을 자바의 객체로 가져옴
//						File file = new File(saveFolder,systemname);
//						//파일이 존재한다면
//						if(file.exists()) {
//							//삭제
//							file.delete();
//						}
//					}
//					//실패 페이지로 이동
//				}
//			}
//		}
//	
//		//수정 혹은 삭제된 기존 파일들을 지우기 위한 로직
//		String[] deleteFiles = updateCnt.split("\\\\");
//		for(String name : deleteFiles) {
//			File file = new File(saveFolder,name);
//			if(file.exists()) {
//				file.delete();
//				fdao.deleteFile(name);
//			}
//		}
		
		LPostDAO bdao = new LPostDAO();
		Transfer transfer = new Transfer();
		transfer.setRedirect(true);
		if(bdao.updateBoard(board)) {
			System.out.println("bdao.updateBoard 성공");
		}
		else {
			System.out.println("bdao.updateBoard 실패");
		}
		String queryString = String.format("?lpostnum=%s&keyword=%s&page=%s",lpostnum+"",keyword,page);
		transfer.setPath(req.getContextPath()+"/boardview.bo"+queryString);
		return transfer;
	}
}












