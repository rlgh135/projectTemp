package com.twojo.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.twojo.mybatis.SQLMapConfig;

public class MyinfoDAO {
	private SqlSession ss;

	public MyinfoDAO() {
		ss = SQLMapConfig.getFactory().openSession(true);
	}
		
	public List<Map<String, Object>> getTitleAndLikeCountList() {
	    return ss.selectList("Myinfo.getTitleAndLikeCountList");
	}


}

