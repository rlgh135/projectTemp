package com.twojo.model.dto;

public class ReqListDTO {
	private long groupnum;
	private String userid;
	private String leaderid;
	private String question;
	private String answer;
	private int autoreg;
	public int getAutoreg() {
		return autoreg;
	}
	public void setAutoreg(int autoreg) {
		this.autoreg = autoreg;
	}
	public long getGroupnum() {
		return groupnum;
	}
	public void setGroupnum(long groupnum) {
		this.groupnum = groupnum;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getLeaderid() {
		return leaderid;
	}
	public void setLeaderid(String leaderid) {
		this.leaderid = leaderid;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
}
