package com.twojo.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.twojo.model.dto.LPostDTO;
import com.twojo.mybatis.SQLMapConfig;

public class LPostDAO {
private SqlSession ss;
	
	public LPostDAO() {
		ss = SQLMapConfig.getFactory().openSession(true);
	}
	
	
	public long getBoardCnt() {
		return ss.selectOne("LPost.getBoardCnt");
	}
	
	public long getBoardCnt(String keyword) {
		return ss.selectOne("LPost.getBoardCntWithKey",keyword);
	}

	public List<LPostDTO> getTitleAndLikeCountList(String userid) {
		return ss.selectList("LPost.getTitleAndLikeCountList", userid);
	}
	
	public List<LPostDTO> getList(int startRow, int pageSize) {
		HashMap<String, Integer> datas = new HashMap<String, Integer>();
		datas.put("startRow", startRow);
		datas.put("pageSize", pageSize);
		return ss.selectList("LPost.getList",datas);
	}

	public List<LPostDTO> getList(int startRow, int pageSize, String keyword) {
		HashMap<String, Object> datas = new HashMap<String, Object>();
		datas.put("startRow", startRow);
		datas.put("pageSize", pageSize);
		datas.put("keyword",keyword);
		return ss.selectList("LPost.getListWithKey",datas);
	}

	public boolean insertBoard(LPostDTO board) {
		return ss.insert("LPost.insert",board) == 1;
	}

	public LPostDTO getBoardByNum(long boardnum) {
		return ss.selectOne("LPost.get",boardnum);
	}

	public void updateReadCount(long boardnum) {
		ss.update("LPost.updateReadCount",boardnum);
	}

	public boolean deleteBoard(long boardnum) {
		return ss.delete("LPost.delete",boardnum) == 1;
	}

	public long getLastNum(String userid) {
		return ss.selectOne("LPost.getLastNum",userid);
	}

	public boolean updateBoard(LPostDTO board) {
		return ss.update("LPost.update",board) == 1;
	}
	
	public List<LPostDTO> getListWithAddr(String loginUserAddr) {
		return ss.selectList("LPost.getListWithAddr",loginUserAddr);
	}
	public List<LPostDTO> getUserAddrList(String userAddrgu) {
		return ss.selectList("LPost.getUserAddrList", userAddrgu);
	}

	public List<LPostDTO> getboardinfoList(String userid) {
		return ss.selectList("LPost.getUserList", userid);
	}


	public boolean setAddr(String roadAddress, long boardnum) {
		HashMap<String, Object> datas = new HashMap<String, Object>();
		datas.put("roadAddress", roadAddress);
		datas.put("boardnum", boardnum);
		return ss.update("LPost.setAddr", datas) == 1;
	}


	public List<LPostDTO> getQuickPost(String userAddrgu) {
		return ss.selectList("LPost.getQuickPost", userAddrgu);
	}

}
