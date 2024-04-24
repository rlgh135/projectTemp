package com.twojo.model.dao;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;


import com.twojo.model.dto.Lpost_AddrDTO;
import com.twojo.mybatis.SQLMapConfig;

public class Lpost_AddrDAO {

	private SqlSession ss;
	
	public Lpost_AddrDAO() {
		ss = SQLMapConfig.getFactory().openSession(true);
	}

	public boolean insertAddr(Lpost_AddrDTO ladto) {
		return ss.insert("Lpost_Addr.insert",ladto) == 1;
	}
	
	public Lpost_AddrDTO getAddr(long lpostnum) {
		return ss.selectOne("Lpost_Addr.getAddr", lpostnum);
	}

	public boolean deleteBoard(long boardnum) {
		return ss.delete("Lpost_Addr.delete",boardnum) == 1;
	}

	public Lpost_AddrDTO getAllByNum(long boardnum) {
		return ss.selectOne("Lpost_Addr.getAllByNum", boardnum);
	}
	
	public boolean updateAddr(Lpost_AddrDTO ladto) {
		return ss.update("Lpost_Addr.update",ladto) == 1;
	}
}
