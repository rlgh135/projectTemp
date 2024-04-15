package com.twojo.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.twojo.model.dto.LReplyDTO;
import com.twojo.mybatis.SQLMapConfig;

public class LReplyDAO {
private SqlSession ss;
	
	public LReplyDAO() {
		ss = SQLMapConfig.getFactory().openSession(true);
	}
	
	public boolean insertReply(LReplyDTO reply) {
		return ss.insert("LReply.insert",reply) == 1;
	}

	public List<LReplyDTO> getReplies(long boardnum) {
		return ss.selectList("LReply.getReplies",boardnum);
	}

	public boolean deleteReply(long replynum) {
		return ss.delete("LReply.delete",replynum) == 1;
	}

	public boolean updateReply(LReplyDTO reply) {
		return ss.update("LReply.update",reply) == 1;
	}

	public Integer getReplyCnt(long boardnum) {
		return ss.selectOne("LReply.getReplyCnt",boardnum);
	}

	public int getRecentReplyCnt(long boardnum) {
		return ss.selectOne("LReply.getRecentReplyCnt",boardnum);
	}
}










