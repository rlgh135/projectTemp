package com.twojo.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.twojo.model.dto.GroupUserDTO;
import com.twojo.mybatis.SQLMapConfig;

public class GroupUserDAO {
	private SqlSession ss;
	
	public GroupUserDAO() {
		ss = SQLMapConfig.getFactory().openSession(true);
	}
	
	public boolean insert(GroupUserDTO groupuser) {
		System.out.println("다오"+groupuser.getUserid());
		System.out.println("다오"+groupuser.getGroupnum());
		return ss.insert("GroupUser.insert", groupuser)==1;
	}
	
	public boolean delete(GroupUserDTO groupuser) {
		return ss.delete("GroupUser.delete", groupuser)==1;
	}

	public List<GroupUserDTO> selectList(long groupnum) {
		return ss.selectList("GroupUser.selectList", groupnum);
	}

	public List<GroupUserDTO> selectRecentList(long groupnum) {
		return ss.selectList("GroupUser.selectRecentList", groupnum);
	}
}
