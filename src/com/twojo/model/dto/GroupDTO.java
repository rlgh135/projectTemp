package com.twojo.model.dto;

public class GroupDTO {
	private long groupnum;
	private String groupname;
	private String groupaddr;
	private String groupcategory;
	private String groupmaster;
	private String groupregdate;
	private String groupcontents;
	private int grouplikecnt;
	private int groupusercnt;
	public String getGroupname() {
		return groupname;
	}
	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}
	public long getGroupnum() {
		return groupnum;
	}
	public void setGroupnum(long groupnum) {
		this.groupnum = groupnum;
	}
	public String getGroupaddr() {
		return groupaddr;
	}
	public void setGroupaddr(String groupaddr) {
		this.groupaddr = groupaddr;
	}
	public String getGroupcategory() {
		return groupcategory;
	}
	public void setGroupcategory(String groupcategory) {
		this.groupcategory = groupcategory;
	}
	public String getGroupmaster() {
		return groupmaster;
	}
	public void setGroupmaster(String groupmaster) {
		this.groupmaster = groupmaster;
	}
	public String getGroupregdate() {
		return groupregdate;
	}
	public void setGroupregdate(String groupregdate) {
		this.groupregdate = groupregdate;
	}
	public String getGroupcontents() {
		return groupcontents;
	}
	public void setGroupcontents(String groupcontents) {
		this.groupcontents = groupcontents;
	}
	public int getGrouplikecnt() {
		return grouplikecnt;
	}
	public void setGrouplikecnt(int grouplikecnt) {
		this.grouplikecnt = grouplikecnt;
	}
	public int getGroupusercnt() {
		return groupusercnt;
	}
	public void setGroupusercnt(int groupusercnt) {
		this.groupusercnt = groupusercnt;
	}
}
