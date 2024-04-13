package com.twojo.model.dto;

public class GPReplyDTO {
	private long gprnum;
	private String userid;
	private long gpostnum;
	private String gprcontents;
	private String gprregdate;
	public long getGprnum() {
		return gprnum;
	}
	public void setGprnum(long gprnum) {
		this.gprnum = gprnum;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public long getGpostnum() {
		return gpostnum;
	}
	public void setGpostnum(long gpostnum) {
		this.gpostnum = gpostnum;
	}
	public String getGprcontents() {
		return gprcontents;
	}
	public void setGprcontents(String gprcontents) {
		this.gprcontents = gprcontents;
	}
	public String getGprregdate() {
		return gprregdate;
	}
	public void setGprregdate(String gprregdate) {
		this.gprregdate = gprregdate;
	}
}
