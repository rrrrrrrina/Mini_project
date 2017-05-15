package com.model2.mvc.web.user;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Message;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.domain.WishList;
import com.model2.mvc.service.user.UserService;


//==> ȸ������ Controller
@Controller
@RequestMapping("/user/*")
public class UserController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method ���� ����
		
	public UserController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	@RequestMapping( value="addUser")
	public String addUser() throws Exception{
		
		System.out.println("/user/addUser : GET");
		
		return "redirect:/user/addUserView.jsp";
	}
	
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser( @ModelAttribute("user") User user ) throws Exception {

		System.out.println("/user/addUser : POST");
		//Business Logic
		userService.addUser(user);
		
		return "redirect:/user/loginView.jsp";
	}
	

	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser( @RequestParam("userId") String userId , Model model ) throws Exception {
		
		System.out.println("/user/getUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model �� View ����
		model.addAttribute("user", user);
		
		return "forward:/user/getUser.jsp";
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////  �߰��� �κ� ///////////////////////////////////////////////////////////////
	@RequestMapping( value="getJsonUser/{userId}", method=RequestMethod.GET )
	public void getJsonUser( @PathVariable String userId, Model model) throws Exception{
		
		System.out.println("/getJsonUser/getUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model �� View ����
		model.addAttribute("user", user);
	}
	
	@RequestMapping( value="getJsonUserIds/{gotResult}", method=RequestMethod.GET )
	public void getJsonUserIds( @PathVariable int gotResult, Model model) throws Exception{
		
		System.out.println("/getJsonUserIds");
		System.out.println(gotResult);
		if(gotResult==0){
			List<String> list = userService.getUserIds();
			model.addAttribute("list", list);
			gotResult++;
		}else{
			model.addAttribute("gotResult",gotResult);
		}
	}
	

	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser( @RequestParam("userId") String userId , Model model ) throws Exception{

		System.out.println("/user/updateUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model �� View ����
		model.addAttribute("user", user);
		
		return "forward:/user/updateUser.jsp";
	}

	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser( @ModelAttribute("user") User user , Model model , HttpSession session) throws Exception{

		System.out.println("/user/updateUser : POST");
		//Business Logic
		userService.updateUser(user);
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}
		
		return "redirect:/user/getUser?userId="+user.getUserId();
	}
	
	
	@RequestMapping( value="login", method=RequestMethod.GET )
	public String login() throws Exception{
		
		System.out.println("/user/logon : GET");

		return "redirect:/user/loginView.jsp";
	}
	
	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login(@ModelAttribute("user") User user , HttpSession session ) throws Exception{
		
		System.out.println("/user/login : POST");
		//Business Logic
		User dbUser=userService.getUser(user.getUserId());
		System.out.println(dbUser);
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
			List<Integer> history = new ArrayList<Integer>();
			session.setAttribute("history",history);
		}
		
		return "redirect:/index.jsp";
	}
	
	@RequestMapping( value="jsonLogin", method=RequestMethod.POST )
	public void jsonLogin(	@RequestBody User user, HttpSession session, Model model) throws Exception{
	
		System.out.println("/user/jsonLogin : POST");
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		model.addAttribute("user", dbUser);
	}
	
	@RequestMapping( value="logout", method=RequestMethod.GET )
	public String logout(HttpSession session ) throws Exception{
		
		System.out.println("/user/logout : POST");
		
		session.invalidate();
		
		return "redirect:/index.jsp";
	}
	
	@RequestMapping(value={"/checkJsonDuplication/{userId}"}, method=RequestMethod.GET)
	public void checkJsonDuplication( @PathVariable String userId, HttpSession session, Model model ) throws Exception {
		
		System.out.println("/user/checkJsonDuplication");
		
		boolean result=userService.checkDuplication(userId);
		
		model.addAttribute("result", new Boolean(result));
	}

	
	@RequestMapping( value="listUser" )
	public String listUser( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/user/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/user/listUser.jsp";
	}
	
	@RequestMapping( value="sendMessage", method=RequestMethod.GET )
	public String sendMessage(@RequestParam(value="messageNo", required=false) String messageNo, Model model) throws Exception{
	
		System.out.println("/user/sendMessage(view) : GET");
		
		String destination="forward:/user/sendMessageView.jsp";
		Message message=new Message();
		if(messageNo!=null){
			message = userService.getMessage(Integer.parseInt(messageNo));
			(message.getContents()).replaceAll("\r\n", "<BR>") ;
			model.addAttribute("message", message);
		}
		return destination;
	}
	
	@RequestMapping( value="sendMessage", method=RequestMethod.POST )
	public String sendMessage( @ModelAttribute("message") Message message, @RequestParam(value="receiverIdExtra", required=false) List<String> values, HttpSession session, Model model) throws Exception {

		System.out.println("/user/sendMessage : POST");
		message.setSenderId(((User)session.getAttribute("user")).getUserId());
		
		if(message.getReceiverId()!=null){
			userService.sendMessage(message);
			if(values!=null){
				for(int i=0; i<values.size(); i++){
					message.setReceiverId(values.get(i));
					userService.sendMessage(message);
				}
			}
		}

		return "forward:/user/listMessage?searchMenu=send";
	}
	
	@RequestMapping( value="getMessage", method=RequestMethod.GET )
	public String getMessage( @RequestParam("messageNo") String messageNo, HttpSession session, Model model ) throws Exception {
		
		System.out.println("/user/getMessage : GET");
		
		Message message = userService.getMessage(Integer.parseInt(messageNo));
		
		if(message.getReceiverId().equals(((User)session.getAttribute("user")).getUserId()) && message.isRead().equals("0")){
			userService.updateMessage(message);
		}
		model.addAttribute("message", message);
		
		return "forward:/user/readMessage.jsp";
	}
	
	@RequestMapping(value="deleteMessage", method=RequestMethod.POST)
	public String deleteMessage( @RequestParam(value="chbox", required=false) List<String> values, HttpSession session, Search search) throws Exception {
		System.out.println("/deleteMessage");
		
		if(values != null && values.size()>0){
			for(int i=0; i<values.size(); i++){
				userService.deleteMessage(Integer.parseInt(values.get(i)));
			}
		}
		
		return "forward:/user/listMessage";
	}
	
	@RequestMapping( value="listMessage" )
	public String listMessage( @ModelAttribute("search") Search search, Model model, HttpSession session) throws Exception{
		
		System.out.println("/user/listMessage : GET / POST");
		
		String destination="listGetMessage.jsp";
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setSearchKeyword(((User)session.getAttribute("user")).getUserId());
		System.out.println(search);
		if(search.getSearchMenu().equals("send")){
			destination="listSendMessage.jsp";
		}
		
		Map<String , Object> map=userService.getMessageList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/user/"+destination;
	}
	
	
	
}