package com.twojo.model.dao;

import java.util.HashMap;

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
	public String getUserAddr(String userid) {
		return ss.selectOne("User.select", userid);
	}
	public boolean updateuseraddr(String userid, String useraddr, String useraddrgu) {
		HashMap<String, String> datas = new HashMap<String, String>();
		datas.put("userid", userid);
		datas.put("useraddr", useraddr);
		datas.put("useraddrgu", useraddrgu);
		return ss.update("User.updateaddr", datas) == 1;
	}
}
