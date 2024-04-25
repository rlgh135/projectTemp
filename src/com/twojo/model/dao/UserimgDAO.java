package com.twojo.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.twojo.model.dto.UserDTO;
import com.twojo.model.dto.UserimgDTO;
import com.twojo.mybatis.SQLMapConfig;

public class UserimgDAO {
	private SqlSession ss;
	
	public UserimgDAO() {
		ss = SQLMapConfig.getFactory().openSession(true);
	}

	public boolean insertFile(UserimgDTO uidto) {
		return ss.insert("Userimg.insert", uidto)==1;
	}

	public boolean deleteFile(String systemname) {
		return ss.delete("Userimg.delete", systemname)==1;
	}

	public UserimgDTO getImgName(String userid) {
		return ss.selectOne("Userimg.imgselect", userid);
	}

	public boolean deleteUserFile(String userid) {
		return ss.delete("Userimg.deleteuserimg", userid)==1;
	}

	public boolean getimgcheck(String userid) {
		return ss.selectOne("Userimg.imgcheck", userid) != null;
	}


}
