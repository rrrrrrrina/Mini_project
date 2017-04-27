package com.model2.mvc.service.domain;

import java.util.Date;

public class Comment {
	
	private int commentNo;
	private int prodNo;
	private String commenterId;
	private Date commentDate;
	private String contents;
	private String receiverId;
	private boolean isPrivate;
	
	
	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public int getProdNo() {
		return prodNo;
	}
	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}
	public String getCommenterId() {
		return commenterId;
	}
	public void setCommenterId(String commenterId) {
		this.commenterId = commenterId;
	}
	public Date getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getReceiverId() {
		return receiverId;
	}
	public void setReceiverId(String receiverId) {
		this.receiverId = receiverId;
	}
	public boolean isPrivate() {
		return isPrivate;
	}
	public void setPrivate(boolean isPrivate) {
		this.isPrivate = isPrivate;
	}
	
	@Override
	public String toString() {
		return "Comment [commentNo=" + commentNo + ", prodNo=" + prodNo + ", commenterId=" + commenterId
				+ ", commentDate=" + commentDate + ", contents=" + contents + ", receiverId=" + receiverId
				+ ", isPrivate=" + isPrivate + "]";
	}
	
	

}
