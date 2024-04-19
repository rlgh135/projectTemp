package tool;

import org.apache.ibatis.session.SqlSession;

import com.twojo.model.dto.GPReplyDTO;
import com.twojo.model.dto.GPostDTO;
import com.twojo.model.dto.GroupDTO;
import com.twojo.model.dto.GroupUserDTO;
import com.twojo.model.dto.GroupimgDTO;
import com.twojo.model.dto.LPostDTO;
import com.twojo.model.dto.UserDTO;
import com.twojo.mybatis.SQLMapConfig;

public class InsertDummy {
	public static void main(String[] args) {
		
		SqlSession ss = SQLMapConfig.getFactory().openSession(true);
		
		String[] hobbies = {"스포츠/레저", "취미", "친목/모임", "음악", "문화/예술", "여행/캠핑", "맛집/요리", "어학/외국어", "경제/재태크", "교육/공부"};
		int hobidx = 0;
		String[] regions = {"관악구", "동작구", "서초구", "강남구", "용산구"};
		int regidx = 0;
		int hobbycnt = 0;
		String hobby ="";
		
//		//user
//		for(int i=0; i<100; i++) {
//			UserDTO user = new UserDTO();
//			hobby="";
//			user.setUserid("abc"+(i+1));
//			user.setUserpw("1234");
//			user.setUsername("가명"+(i+1));
//			regidx = (int)(Math.random()*5);
//			user.setUseraddr(regions[regidx]);
//			hobbycnt = (int)(Math.random()*3)+1;
//			System.out.println(hobbycnt);
//			hobidx = (int)(Math.random()*4);
//			for(int j=0; j<hobbycnt; j++) {
//				hobby += hobbies[hobidx+2*j]+"☆";
//				System.out.println(hobby);
//			}
//			user.setUserhobby(hobby);
//			System.out.println(user.getUseraddr());
//			System.out.println(user.getUserhobby());
//			ss.insert("User.insert",user);
//		}
		
//		//lboard
//		for(int i=0; i<3000; i++) {
//			LPostDTO lpost = new LPostDTO();
//			hobidx = (int)(Math.random()*10);
//			hobby = hobbies[hobidx];
//			lpost.setLpostcategory(hobby);
//			lpost.setUserid("abc"+(int)(Math.random()*1000));
//			regidx = (int)(Math.random()*5);
//			lpost.setLpostaddr(regions[regidx]);
//			lpost.setLposttitle(regions[regidx]+"게시글"+(i+1));
//			lpost.setLpostcontents(regions[regidx]+"게시글"+(i+1));
//			
//			ss.insert("LPost.insert", lpost);
//		}
		//lboard
		for(int i=0; i<10; i++) {
			LPostDTO lpost = new LPostDTO();
			hobidx = (int)(Math.random()*10);
			hobby = hobbies[hobidx];
			lpost.setLpostcategory(hobby);
			lpost.setUserid("abc"+(i%2+1));
			regidx = (int)(Math.random()*5);
			lpost.setLpostaddr("강남구");
			lpost.setLposttitle("강남구게시글"+(i+1));
			lpost.setLpostcontents("강남구게시글"+(i+1));
			
			ss.insert("LPost.insert", lpost);
		}
		
//		group
//		for(int i=0; i<3000; i++) {
//			GroupDTO group = new GroupDTO();
//			hobidx = (int)(Math.random()*10);
//			hobby = hobbies[hobidx];
//			group.setGroupcategory(hobby);
//			group.setGroupname("groupname"+(i+1));
//			group.setGroupmaster("abc"+(int)(Math.random()*1000));
//			regidx = (int)(Math.random()*5);
//			group.setGroupaddr(regions[regidx]);
//			group.setGroupcontents(regions[regidx]+"그룹 내용"+(i+1));
//			
//			ss.insert("Group.insert", group);
//		}
		
//		//gpost
//		for(int i=0; i<45; i++) {
//			GPostDTO gpost = new GPostDTO();
//			gpost.setGroupnum(1);
//			gpost.setGposttitle("제목"+(i+1));
//			gpost.setUserid("a"+(i+1));
//			gpost.setGpostcontents("내용\n"+(i+1)+"번\n내용\n내용\n내용\n내용\n");
//			
//			ss.insert("GPost.insert", gpost);
//		}
		
//		//greply
//		for(int i=0; i<45; i++) {
//			int useridx = (int)(Math.random()*5);
//			for (int j = 0; j < useridx; j++) {
//				GPReplyDTO gpreply = new GPReplyDTO();
//				gpreply.setGpostnum(i+1);
//				gpreply.setUserid("abc"+j);
//				gpreply.setGprcontents("댓글내용 j:"+j+" i:"+i);
//				
//				ss.insert("GPReply.insert", gpreply);
//			}
//		}
		
//		//group_user
//		for(int i=0; i<1000; i++) {
//			GroupUserDTO gu = new GroupUserDTO();
//			int groupnum = (int)(Math.random() * 300 + 1);
//			gu.setGroupnum(groupnum);
//			gu.setUserid("abc"+(i+1));
//			
//			ss.insert("GroupUser.insert", gu);
//		}

//		//groupimg
//		for(int i=1; i<1000; i++) {
//			GroupimgDTO gi = new GroupimgDTO();
//			gi.setGroupnum(i);
//			gi.setImgorgname("abc"+(i)+".jpg");
//			gi.setImgsysname("abcd"+(i)+".jpg");
//			
//			ss.insert("Groupimg.insert", gi);
//		}
	}
}
