package com.twojo.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.twojo.model.dto.GPReplyDTO;
import com.twojo.mybatis.SQLMapConfig;

public class GPReplyDAO {
	private SqlSession ss;
	
	public GPReplyDAO() {
		ss = SQLMapConfig.getFactory().openSession(true);
	}

	public Integer getReplyCnt(long gpostnum) {
		// TODO Auto-generated method stub
		return ss.selectOne("GPReply.getReplyCnt", gpostnum);
	}

	public int getRecentReplyCnt(long gpostnum) {
		// TODO Auto-generated method stub
		return ss.selectOne("GPReply.getRecentReplyCnt", gpostnum);
	}

	public List<GPReplyDTO> getListByPage(long gpostnum, int startRow ,int pageSize) {
		HashMap<String, Object> datas = new HashMap<String, Object>();
		datas.put("gpostnum", gpostnum);
		datas.put("startRow", startRow);
		datas.put("pageSize", pageSize);
		return ss.selectList("GPReply.getListByPage", datas);
	}

	public boolean insert(GPReplyDTO gpreply) {
		return ss.insert("GPReply.insert", gpreply)==1;
	}
	
	
}
