package com.twojo.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.twojo.model.dto.GroupUserDTO;
import com.twojo.mybatis.SQLMapConfig;

public class GroupUserDAO {
	private SqlSession ss;
	
	public GroupUserDAO() {
		ss = SQLMapConfig.getFactory().openSession();
	}
	
	public boolean insert(GroupUserDTO groupuser) {
		System.out.println(groupuser.getUserid());
		System.out.println(groupuser.getGroupnum());
		return ss.insert("GroupUser.delete", groupuser) ==1;
	}
	
	public boolean delete(GroupUserDTO groupuser) {
		return ss.delete("GroupUser.delete", groupuser)==1;
	}
}
