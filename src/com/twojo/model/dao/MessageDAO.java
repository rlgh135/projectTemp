package com.twojo.model.dao;


import java.util.List;

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
	public List<MessageDTO> getMSGList(String userid) {
		return ss.selectList("Message.getmsg", userid);
	}
	public List<MessageDTO> getSysMSGList(String userid) {
		return ss.selectList("Message.getsysmsg", userid);
	}
	public boolean deleteMSG(int messagenum) {
		return ss.delete("Message.delete", messagenum) == 1;
	}
	public void systemMessage(MessageDTO message) {
		ss.insert("Message.systemMessage", message);
	}
	public boolean checkMSG(int messagenum) {
		return ss.delete("Message.checkUpdate", messagenum) == 1;
	}
	public int getMsgConfirmCnt(String userid) {
		return ss.selectOne("Message.confirmcnt", userid);
	}
}
