package com.model2.mvc.service.user;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Message;
import com.model2.mvc.service.domain.User;


//==> 회원관리에서 CRUD 추상화/캡슐화한 DAO Interface Definition
public interface UserDao {
	
	// INSERT
	public void addUser(User user) throws Exception ;

	// SELECT ONE
	public User getUser(String userId) throws Exception ;

	public List<User> getUserList(Search search) throws Exception ;

	public void updateUser(User user) throws Exception ;
	
	public int getTotalCount(Search search) throws Exception ;
	
	public void sendMessage(Message message) throws Exception;
	
	public Message getMessage(int messageNo) throws Exception;
	
	public void deleteMessage(int messageNo) throws Exception;
	
	public List<Message> getMessageList(Search search) throws Exception;
	
	public int getTotalMessageCount(Search search) throws Exception;
	
	public void updateMessage(Message message) throws Exception;

}