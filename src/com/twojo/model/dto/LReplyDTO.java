package com.twojo.model.dto;

public class LReplyDTO {
	private long lreplynum;
	private String lreplycontents;
	private String lpostregdate;
	private String updatechk;
	private String userid;
	private long lpostnum;// boardnum
	private String lregdate;

	public String getLregdate() {
		return lregdate;
	}
	public void setLregdate(String lregdate) {
		this.lregdate = lregdate;
	}
	public long getLreplynum() {
		return lreplynum;
	}
	public void setLreplynum(long replynum) {
		this.lreplynum = replynum;
	}
	public String getLreplycontents() {
		return lreplycontents;
	}
	public void setLreplycontents(String lreplycontents) {
		this.lreplycontents = lreplycontents;
	}
	public String getLpostregdate() {
		return lpostregdate;
	}
	public void setLpostregdate(String lpostregdate) {
		this.lpostregdate = lpostregdate;
	}
	public String getUpdatechk() {
		return updatechk;
	}
	public void setUpdatechk(String updatechk) {
		this.updatechk = updatechk;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public long getBoardnum() {
		return lpostnum;
	}
	public void setBoardnum(long boardnum) {
		this.lpostnum = boardnum;
	}
	
	
}
