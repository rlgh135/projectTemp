package com.twojo.model.dao;

import java.util.List;

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
	
	
}
