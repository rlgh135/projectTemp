package com.twojo.model.dto;

public class GPostDTO {
	private long gpostnum;
	private long groupnum;
	private String gposttitle;
	private String userid;
	private String gpostcontents;
	private int gpostlike;
	private int gprcnt;
	private int gpostgongji;
	private String gpostregdate;
	
	public int getGpostlike() {
		return gpostlike;
	}
	public void setGpostlike(int gpostlike) {
		this.gpostlike = gpostlike;
	}
	public int getGprcnt() {
		return gprcnt;
	}
	public void setGprcnt(int gprcnt) {
		this.gprcnt = gprcnt;
	}
	public int getGpostgongji() {
		return gpostgongji;
	}
	public void setGpostgongji(int gpostgongji) {
		this.gpostgongji = gpostgongji;
	}
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
