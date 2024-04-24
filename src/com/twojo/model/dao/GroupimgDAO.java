package com.twojo.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.twojo.model.dto.GroupimgDTO;
import com.twojo.mybatis.SQLMapConfig;

public class GroupimgDAO {
	private SqlSession ss;
	
	public GroupimgDAO() {
		ss = SQLMapConfig.getFactory().openSession(true);
	}

	public GroupimgDTO getGroupimgList(long groupnum) {
		return ss.selectOne("Groupimg.getImgName", groupnum);
	}

	public boolean insertFile(GroupimgDTO gimg) {
		return ss.insert("Groupimg.insert", gimg)==1;
	}

	public boolean deleteFile(String systemname) {
		return ss.delete("Groupimg.deleteFile", systemname)==1;
	}

	public String getGroupimg(Long groupnum) {
		return ss.selectOne("Groupimg.getGroupimg", groupnum);
	}
}
