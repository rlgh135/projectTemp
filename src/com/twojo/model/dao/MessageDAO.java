package com.twojo.model.dao;


import org.apache.ibatis.session.SqlSession;

import com.twojo.model.dto.MessageDTO;
import com.twojo.mybatis.SQLMapConfig;

public class MessageDAO {
	private SqlSession ss;
	public MessageDAO() {
		ss = SQLMapConfig.getFactory().openSession(true);
	}
	public boolean insertMSG(MessageDTO msg) {
		return ss.insert("Message.insert", msg) == 1;
	}
	public boolean systemMessage(MessageDTO msg) {
		return ss.insert("Message.systemMessage", msg) == 1;
	}
}
