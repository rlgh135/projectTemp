package com.twojo.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.twojo.model.dto.GFileDTO;
import com.twojo.mybatis.SQLMapConfig;

public class GFileDAO {
	private SqlSession ss;
	
	public GFileDAO() {
		ss = SQLMapConfig.getFactory().openSession(true);
	}
	
	public boolean insert(long gpostnum, GFileDTO file) {
		HashMap<String, Object> datas = new HashMap<String, Object>();
		datas.put("gpostnum", gpostnum);
		datas.put("gfileorgname", file.getGfileorgname());
		datas.put("gfilesysname", file.getGfilesysname());
		return ss.insert("GPfile", datas)==1;
	}
	
	public List<GFileDTO> getGFiles(long gpostnum){
		return ss.selectList("GFile.getGFiles", gpostnum);
	}
}
