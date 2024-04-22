package com.twojo.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.twojo.model.dto.GPostLikeDTO;
import com.twojo.mybatis.SQLMapConfig;

public class GPostLikeDAO {
	private SqlSession ss;
	
	public GPostLikeDAO() {
		ss = SQLMapConfig.getFactory().openSession(true);
	}
	
	public boolean addLike(GPostLikeDTO gpostlike) {
		return ss.insert("GPostLike.addLike", gpostlike)==1;
	}
	public boolean removeLike(GPostLikeDTO gpostlike) {
		return ss.delete("GPostLike.removeLike", gpostlike)==1;
	}
	public GPostLikeDTO getLike(GPostLikeDTO gpostlike) {
		return ss.selectOne("GPostLike.getLike", gpostlike);
	}
}
