package com.model2.mvc.service.user;

import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Message;
import com.model2.mvc.service.domain.User;


//==> 회원관리에서 서비스할 내용 추상화/캡슐화한 Service  Interface Definition  
public interface UserService {
	
	public void addUser(User user) throws Exception;
	
	public User getUser(String userId) throws Exception;
	
	public Map<String , Object> getUserList(Search search) throws Exception;
	
	public void updateUser(User user) throws Exception;
	
	public boolean checkDuplication(String userId) throws Exception;
	
	public void sendMessage(Message message) throws Exception;
	
	public Message getMessage(int messageNo) throws Exception;
	
	public void deleteMessage(int messageNo) throws Exception;
	
	public Map<String , Object> getMessageList(Search search) throws Exception;
	
	public void updateMessage(Message message) throws Exception;
 

}