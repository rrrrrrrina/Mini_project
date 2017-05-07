package com.model2.mvc.service.user.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Message;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserDao;


//==> 회원관리 DAO CRUD 구현
@Repository("userDaoImpl")
public class UserDaoImpl implements UserDao{
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public UserDaoImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addUser(User user) throws Exception {
		sqlSession.insert("UserMapper.addUser", user);
	}

	public User getUser(String userId) throws Exception {
		return sqlSession.selectOne("UserMapper.getUser", userId);
	}
	
	public List<String> getUserIds() throws Exception{
		return sqlSession.selectList("UserMapper.getUserIds");
	}
	
	public void updateUser(User user) throws Exception {
		sqlSession.update("UserMapper.updateUser", user);
	}

	public List<User> getUserList(Search search) throws Exception {
		return sqlSession.selectList("UserMapper.getUserList", search);
	}

	// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("UserMapper.getTotalCount", search);
	}
	
	public void sendMessage(Message message) throws Exception {
		sqlSession.insert("UserMapper.sendMessage",message);
	}
	
	public Message getMessage(int messageNo) throws Exception {
		return sqlSession.selectOne("UserMapper.getMessage",messageNo);
	}
	
	public void deleteMessage(int messageNo) throws Exception {
		sqlSession.delete("UserMapper.deleteMessage",messageNo);
	}
	
	public List<Message> getMessageList(Search search) throws Exception {
		return sqlSession.selectList("UserMapper.getMessageList", search);
	}
	
	public int getTotalMessageCount(Search search) throws Exception {
		return sqlSession.selectOne("UserMapper.getTotalMessageCount", search);
	}

	public void updateMessage(Message message) throws Exception {
		sqlSession.update("UserMapper.updateMessage", message);
	}
}