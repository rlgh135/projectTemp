package com.twojo.app.user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twojo.model.dao.GroupDAO;
import com.twojo.model.dao.GroupimgDAO;
import com.twojo.model.dao.LPostDAO;
import com.twojo.model.dto.GroupDTO;
import com.twojo.model.dto.GroupimgDTO;
import com.twojo.model.dto.LPostDTO;
import com.twojo.action.Action;
import com.twojo.action.Transfer;

public class MyinfoOkAction implements Action {
	@Override
    public Transfer execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Transfer transfer = new Transfer();
       
            String userid = (String)req.getSession().getAttribute("loginUser");
            
            
            // 사용자 아이디가 null이면 로그인 페이지로 리다이렉트
            if (userid == null) {
                transfer.setRedirect(true);
                transfer.setPath("/");
                return transfer;
            }

            LPostDAO lpdao = new LPostDAO();
            
            GroupDAO gdao = new GroupDAO();
            GroupimgDAO gidao = new GroupimgDAO();
            // gdto가 null이면 로그인 페이지로 리다이렉트
            
            List<LPostDTO> temp = lpdao.getboardinfoList(userid);
            //session에 들어간 userid와 groupnum을 대조해 groupnum을 찾는다
         // 사용자의 그룹번호 배열 가져오기
            if(gdao.getfindgroupnum(userid) == null) {
            	System.out.println("하이");
            }
            else {
            	System.out.println("김일환");
            }
            List<Integer> groupnums = gdao.getfindgroupnum(userid);

            // 각 그룹에 대한 정보를 저장할 리스트
            List<GroupDTO> gboardList = new ArrayList<>();
            List<GroupimgDTO> giboardList = new ArrayList<>();

            // 각 그룹번호에 해당하는 정보 가져오기
           	
				for (long groupnum : groupnums) {
					// GroupDTO 가져오기
					GroupDTO gboard = gdao.getGroupByMyinfoList(groupnum);
					if (gboard != null) {
						gboardList.add(gboard);
						
					}

					// GroupimgDTO 가져오기
					GroupimgDTO giboard = gidao.getGroupimgList(groupnum);
					if (giboard != null) {
						giboardList.add(giboard);
						
					}
				}
				
			
            

            // 결과 리스트에 정보가 담겨있음
            req.setAttribute("group", gboardList);
            req.setAttribute("groupimg", giboardList);
            req.setAttribute("lpost", temp);
            
            transfer.setRedirect(false);
            transfer.setPath("/app/user/myinfo.jsp");
        
            
       
        return transfer;
    }
}
