package com.twojo.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.twojo.model.dto.ReqListDTO;
import com.twojo.mybatis.SQLMapConfig;

public class ReqListDAO {
	private SqlSession ss;
	
	public ReqListDAO() {
		ss = SQLMapConfig.getFactory().openSession(true);
	}
	
	public boolean makeQuestion(ReqListDTO reqlist) {
		return ss.insert("ReqList.makeQuestion", reqlist)==1;
	}
	public boolean makeAutoQuestion(ReqListDTO reqlist) {
		return ss.insert("ReqList.makeAutoQuestion", reqlist)==1;
	}
	public boolean makeAnswer(ReqListDTO reqlist) {
		return ss.insert("ReqList.makeAnswer", reqlist)==1;
	}
	public boolean delete(ReqListDTO reqlist) {
		return ss.delete("ReqList.delete", reqlist)==1;
	}
	public boolean deleteQuestion(ReqListDTO reqlist) {
		return ss.delete("ReqList.deleteQuestion", reqlist)==1;
	}
	public List<ReqListDTO> getAnswerList(long groupnum){
		return ss.selectList("ReqList.getAnswerList", groupnum);
	}
	public ReqListDTO getQuestionList(long groupnum) {
		return ss.selectOne("ReqList.getQuestionList", groupnum);
	}

	public boolean deleteQuestion(long groupnum) {
		return ss.delete("ReqList.deleteQuestionByNum", groupnum)==1;
	}
	public boolean createQuestion(ReqListDTO reqlist) {
		return ss.insert("ReqList.createQuestion", reqlist)==1;
	}
	public boolean changeAuto(int autoreg, long groupnum) {
		HashMap<String, Object> datas = new HashMap<String, Object>();
		datas.put("groupnum", groupnum);
		datas.put("autoreg", autoreg);
		return ss.update("ReqList.changeAuto", datas)==1;
	}

}
