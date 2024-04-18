package com.twojo.model.dto;

public class MessageDTO {
	private long messagenum;
	private String sendid;
	private String receiveid;
	private String msgcontent;
	private String msregdate;
	private String linkstring;
	private int msgcheck;
	
	public String getLinkstring() {
		return linkstring;
	}
	public void setLinkstring(String linkstring) {
		this.linkstring = linkstring;
	}
	public int getMsgcheck() {
		return msgcheck;
	}
	public void setMsgcheck(int msgcheck) {
		this.msgcheck = msgcheck;
	}
	public long getMessagenum() {
		return messagenum;
	}
	public void setMessagenum(long messagenum) {
		this.messagenum = messagenum;
	}
	public String getSendid() {
		return sendid;
	}
	public void setSendid(String sendid) {
		this.sendid = sendid;
	}
	public String getReceiveid() {
		return receiveid;
	}
	public void setReceiveid(String receiveid) {
		this.receiveid = receiveid;
	}
	public String getMsgcontent() {
		return msgcontent;
	}
	public void setMsgcontent(String msgcontent) {
		this.msgcontent = msgcontent;
	}
	public String getMsregdate() {
		return msregdate;
	}
	public void setMsregdate(String msregdate) {
		this.msregdate = msregdate;
	}
}
