package com.twojo.model.dto;

public class LPostDTO {
	private long lpostnum;
	private String lpostcategory;
	private String userid;
	private String lposttitle;
	private String lpostcontents;
	private String lpostregdate;
	private int lpostlikecnt;
	private int readcount;
	private int imageCount;
	private String lpostaddr;
	
	
	public String getLpostaddr() {
		return lpostaddr;
	}
	public void setLpostaddr(String lpostaddr) {
		this.lpostaddr = lpostaddr;
	}
	public long getLpostnum() {
		return lpostnum;
	}
	public void setLpostnum(long lpostnum) {
		this.lpostnum = lpostnum;
	}
	public String getLpostcategory() {
		return lpostcategory;
	}
	public void setLpostcategory(String lpostcategory) {
		this.lpostcategory = lpostcategory;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getLposttitle() {
		return lposttitle;
	}
	public void setLposttitle(String lposttitle) {
		this.lposttitle = lposttitle;
	}
	public String getLpostcontents() {
		return lpostcontents;
	}
	public void setLpostcontents(String lpostcontents) {
		this.lpostcontents = lpostcontents;
	}
	public String getLpostregdate() {
		return lpostregdate;
	}
	public void setLpostregdate(String lpostregdate) {
		this.lpostregdate = lpostregdate;
	}
	
	public void setlpostlikecnt(int lpostlikecnt){
		this.lpostlikecnt = lpostlikecnt;
	}
	
	public int getlpostlikecnt(){
		return lpostlikecnt;
	}
	public int getLpostlikecnt() {
		return lpostlikecnt;
	}
	public void setLpostlikecnt(int lpostlikecnt) {
		this.lpostlikecnt = lpostlikecnt;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public int getImageCount() {
		return imageCount;
	}
	public void setImageCount(int imageCount) {
		this.imageCount = imageCount;
	}
	
	
}
