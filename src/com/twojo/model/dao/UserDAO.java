package com.twojo.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.twojo.model.dto.UserDTO;
import com.twojo.mybatis.SQLMapConfig;

public class UserDAO {
	private SqlSession ss;
	
	public UserDAO() {
		ss = SQLMapConfig.getFactory().openSession(true);
	}

	public UserDTO getUserInfo(String userid) {
		return ss.selectOne("User.select", userid);
	}
	public boolean insertUser(UserDTO user) {
		return ss.insert("User.insert",user) == 1;
	}

	public UserDTO getUserById(String userid) {
		return ss.selectOne("User.select",userid);
	}
}
