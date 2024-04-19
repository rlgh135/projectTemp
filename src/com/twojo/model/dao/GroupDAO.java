package com.twojo.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.twojo.model.dto.GroupDTO;
import com.twojo.mybatis.SQLMapConfig;

public class GroupDAO {
	private SqlSession ss;
	public GroupDAO() {
		ss = SQLMapConfig.getFactory().openSession(true);
	}
	
	public GroupDTO findGroupByNum(long groupnum) {
		return ss.selectOne("Group.findGroupByNum", groupnum);
	}
	public long getUserCntInGroup(long groupnum) {
		return ss.selectOne("Group.getUserCntInGroup", groupnum);
	}

	public List<GroupDTO> getGroupList(String useraddrgu) {
		return ss.selectList("Group.getMainList", useraddrgu);
	}
	
	public List<GroupDTO> getGroupList(String useraddrgu, String hobbykeyword) {
		HashMap<String, String> datas = new HashMap<String, String>();
		datas.put("useraddrgu", useraddrgu);
		datas.put("hobbykeyword", hobbykeyword);
		return ss.selectList("Group.getAddrHobbyGroupList", datas);
	}
	
	public List<GroupDTO> getHobbyGroupList(String useraddrgu, String hobby) {
		HashMap<String, String> datas = new HashMap<String, String>();
		datas.put("useraddrgu", useraddrgu);
		datas.put("hobby", hobby);
		return ss.selectList("Group.getHobbyGroupList", datas);
	}

	public int getGroupCnt(String useraddrgu, String hobbykeyword) {
		HashMap<String, String> datas = new HashMap<String, String>();
		datas.put("useraddrgu", useraddrgu);
		datas.put("hobbykeyword", hobbykeyword);
		return ss.selectOne("Group.getGroupcnt", datas);
	}
	
	public int getGroupCnt(String useraddrgu, String hobbykeyword, String keyword) {
		HashMap<String, String> datas = new HashMap<String, String>();
		datas.put("useraddrgu", useraddrgu);
		datas.put("hobbykeyword", hobbykeyword);
		datas.put("keyword", keyword);
		return ss.selectOne("Group.getGroupcntWithKey", datas);
	}

	public List<GroupDTO> getHobbyList(String useraddrgu, String hobbykeyword, int startRow, int pageSize) {
		HashMap<String, Object> datas = new HashMap<String, Object>();
		datas.put("useraddrgu", useraddrgu);
		datas.put("hobbykeyword", hobbykeyword);
		datas.put("startRow", startRow);
		datas.put("pageSize", pageSize);
		return ss.selectList("Group.getHobbyList", datas);
	}

	public List<GroupDTO> getHobbyList(String useraddrgu, String hobbykeyword, String keyword, int startRow,int pageSize) {
		HashMap<String, Object> datas = new HashMap<String, Object>();
		datas.put("useraddrgu", useraddrgu);
		datas.put("hobbykeyword", hobbykeyword);
		datas.put("keyword", keyword);
		datas.put("startRow", startRow);
		datas.put("pageSize", pageSize);
		return ss.selectList("Group.getHobbyListWithKey", datas);
	}
	public List<Integer> getfindgroupnum(String userid) {
		return ss.selectList("Group.findGroupnum", userid);
	}
	
	public GroupDTO getGroupByMyinfoList(long groupnum){
		return ss.selectOne("Group.getMyinfoList", groupnum);	
	} 
}
