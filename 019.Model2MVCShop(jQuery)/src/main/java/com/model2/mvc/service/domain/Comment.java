package com.model2.mvc.service.domain;

import java.util.Date;

public class Comment {
	
	private int commentNo;
	private int prodNo;
	private String commenterId;
	private String commentDate;
	private String contents;
	private String receiverId;
	
	
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
	public String getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(String commentDate) {
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
	
	@Override
	public String toString() {
		return "Comment [commentNo=" + commentNo + ", prodNo=" + prodNo + ", commenterId=" + commenterId
				+ ", commentDate=" + commentDate + ", contents=" + contents + ", receiverId=" + receiverId
				+ "]";
	}
	
	

}
