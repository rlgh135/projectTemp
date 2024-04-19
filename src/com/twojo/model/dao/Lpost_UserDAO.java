package com.twojo.model.dao;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import com.twojo.model.dto.Lpost_UserDTO;
import com.twojo.mybatis.SQLMapConfig;

public class Lpost_UserDAO {
	private SqlSession ss;
	
	public Lpost_UserDAO() {
		ss = SQLMapConfig.getFactory().openSession(true);
	}
	
	
	public boolean addUser(Lpost_UserDTO ludto) {
	    try {
	    	System.out.println(ludto.getUserid());
	    	System.out.println(ludto.getBoardnum());
	    	return ss.insert("Lpost_User.adduser", ludto) == 1;}
	    catch (PersistenceException e) {return false;}
	}

	public long getUserCount(long boardnum) {
		return ss.selectOne("Lpost_User.getUserCount", boardnum);
	}


	public List<String> getUserList(long boardnum) {
		return ss.selectList("Lpost_User.getUserList", boardnum);
	}


	public int checkUser(Lpost_UserDTO ludto) {
		//System.out.println(ss.selectOne("Lpost_User.checkUser", ludto));
		System.out.println("Result: " + ss.selectOne("Lpost_User.checkUser", ludto));
		return ss.selectOne("Lpost_User.checkUser", ludto);
	}


	public boolean delUser(Lpost_UserDTO ludto) {
		try {return ss.insert("Lpost_User.deluser", ludto) == 1;}
	    catch (PersistenceException e) {return false;}
	}

	public boolean setimageCount(Lpost_UserDTO ludto) {
		return ss.update("Lpost_User.setimageCount", ludto) == 1;
		
	}

}
