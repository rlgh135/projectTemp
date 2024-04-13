package com.twojo.model.dto;

public class GPostDTO {
	private long gpostnum;
	private long groupnum;
	private String gposttitle;
	private String userid;
	private String gpostcontents;
	private String gpostregdate;
	
	public long getGpostnum() {
		return gpostnum;
	}
	public void setGpostnum(long gpostnum) {
		this.gpostnum = gpostnum;
	}
	public long getGroupnum() {
		return groupnum;
	}
	public void setGroupnum(long groupnum) {
		this.groupnum = groupnum;
	}
	public String getGposttitle() {
		return gposttitle;
	}
	public void setGposttitle(String gposttitle) {
		this.gposttitle = gposttitle;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getGpostcontents() {
		return gpostcontents;
	}
	public void setGpostcontents(String gpostcontents) {
		this.gpostcontents = gpostcontents;
	}
	public String getGpostregdate() {
		return gpostregdate;
	}
	public void setGpostregdate(String gpostregdate) {
		this.gpostregdate = gpostregdate;
	}
}
