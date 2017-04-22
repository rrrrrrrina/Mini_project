package com.model2.mvc.service.domain;

import java.sql.Date;



public class Message {
	
	private String senderId;
	private String receiverId;
	private Date receiveredDate;
	private String contents;
	private String readDate;
	private String isRead;
	private int messageNo;
	
	public String getSenderId() {
		return senderId;
	}
	public void setSenderId(String senderId) {
		this.senderId = senderId;
	}
	public String getReceiverId() {
		return receiverId;
	}
	public void setReceiverId(String receiverId) {
		this.receiverId = receiverId;
	}
	public Date getReceiveredDate() {
		return receiveredDate;
	}
	public void setReceiveredDate(Date receiveredDate) {
		this.receiveredDate = receiveredDate;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getReadDate() {
		return readDate;
	}
	public void setReadDate(String readDate) {
		this.readDate = readDate;
	}
	public String isRead() {
		return isRead;
	}
	public void setRead(String isRead) {
		this.isRead = isRead;
	}
	public int getMessageNo() {
		return messageNo;
	}
	public void setMessageNo(int messageNo) {
		this.messageNo = messageNo;
	}
	@Override
	public String toString() {
		return "Message [senderId=" + senderId + ", receiverId=" + receiverId + ", receiveredDate=" + receiveredDate
				+ ", contents=" + contents + ", readDate=" + readDate + ", isRead=" + isRead
				+ ", messageNo=" + messageNo + "]";
	}
	
	
}