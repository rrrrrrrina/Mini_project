package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Comment;
import com.model2.mvc.service.domain.Message;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.domain.WishList;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;


//==> ȸ������ Controller
@Controller
@RequestMapping("/product/*")

public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml ���� �Ұ�
	//==> �Ʒ��� �ΰ��� �ּ��� Ǯ�� �ǹ̸� Ȯ�� �Ұ�
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product, MultipartHttpServletRequest multi, Model model ) throws Exception {

		System.out.println("/addProduct");
		
		String root=multi.getSession().getServletContext().getRealPath("/");
		String path=root+"images/uploadFiles/";
		System.out.println("root:++++++++++++++++:"+path);
		File dir=new File(path);
		if(!dir.isDirectory()){
			dir.mkdir();
		}
		
		Iterator<String> files=multi.getFileNames();
		System.out.println(files);
		
		while(files.hasNext()){
			String uploadFile=files.next();
			
			MultipartFile file=multi.getFile(uploadFile);
			String oriFileName=file.getOriginalFilename();
			String newFileName=UUID.randomUUID().toString()+"."+oriFileName.substring(oriFileName.lastIndexOf(".")+1);
			
			file.transferTo(new File(root+newFileName));
			
			product.setOriFileName(oriFileName);
			product.setNewFileName(newFileName);
			
			System.out.println(oriFileName+":dddddddd:"+newFileName);
		}
		
		//productService.addProduct(product);
		
		model.addAttribute("product", product);
		
		return "forward:/product/addProduct.jsp";
	}
	
	@RequestMapping(value="deleteWishList", method=RequestMethod.POST)
	public String deleteWishList( @RequestParam( value="productNo", defaultValue="0") int productNo, @RequestParam( value="chbox", required=false) List<String> values, HttpSession session, Model model ) throws Exception {

		System.out.println("/deleteWishList");
		WishList wishList=new WishList();
		wishList.setCustomerId(((User)session.getAttribute("user")).getUserId());
		
		if(values != null){
			for(int i=0; i<values.size(); i++){
				wishList.setProductNo(Integer.parseInt(values.get(i)));
				productService.deleteWishList(wishList);
			}
		}else if(productNo!=0){
			wishList.setProductNo(productNo);
			productService.deleteWishList(wishList);
		}
		
		return "redirect:/product/listWishList";
	}
	
	@RequestMapping(value={"deleteJsonWishList/{productNo}"}, method=RequestMethod.GET)
	public void deleteJsonWishList( @PathVariable int productNo, HttpSession session, Model model ) throws Exception {

		System.out.println("/deleteJsonWishList");
		WishList wishList=new WishList();

		wishList.setCustomerId(((User)session.getAttribute("user")).getUserId());
		wishList.setProductNo(productNo);
		
		int countLiked=productService.deleteWishList(wishList);
		model.addAttribute("countLiked", countLiked);
	}
	
	@RequestMapping(value={"deleteComment/{commentNo}"}, method=RequestMethod.GET)
	public void deleteComment( @PathVariable int commentNo,Model model ) throws Exception {

		System.out.println("/deleteComment");
		
		productService.deleteComment(commentNo);
		
	}
	
	@RequestMapping(value="addWishList", method=RequestMethod.POST)
	public String addWishList( @ModelAttribute("wishList") WishList wishList, HttpSession session, Model model ) throws Exception {
		
		System.out.println("/addWishList");

		wishList.setCustomerId(((User)session.getAttribute("user")).getUserId());
		
		if(!productService.checkWishList(wishList)){
			productService.addWishList(wishList);
		}
		
		return "redirect:/product/listWishList";
	}
	
	@RequestMapping(value={"addJsonWishList/{prodNo}"}, method=RequestMethod.GET)
	public void addJsonWishList( @PathVariable int prodNo, HttpSession session, Model model ) throws Exception {
		
		System.out.println("/addJsonWishList");
		WishList wishList=new WishList();
		
		wishList.setCustomerId(((User)session.getAttribute("user")).getUserId());
		wishList.setProductNo(prodNo);
		
		if(!productService.checkWishList(wishList)){
			model.addAttribute("countLiked",productService.addWishList(wishList));
		}
	}
	
	@RequestMapping(value={"addJsonComment"}, method=RequestMethod.GET)
	public void addJsonComment( @RequestParam("prodNo") int prodNo, @RequestParam("contents") String contents, HttpSession session, Model model ) throws Exception {
		
		System.out.println("/addJsonComment");
		Comment comment=new Comment();
		comment.setCommenterId(((User)session.getAttribute("user")).getUserId());
		comment.setProdNo(prodNo);
		
		if(contents.startsWith("@")){
			String temp[]=(contents.split(" "));
			comment.setReceiverId(temp[0].substring(1));
			comment.setContents(contents.substring((contents.indexOf(" "))+1));

			if(!userService.checkDuplication(comment.getReceiverId())){
				Message message = new Message();
				message.setContents(comment.getCommenterId()+"���� ��ۿ��� ȸ������ ����߽��ϴ�. �ּ� : http://localhost:8080/product/getProduct?prodNo="+prodNo);
				message.setSenderId("admin");
				message.setReceiverId(comment.getReceiverId());
				userService.sendMessage(message);
			}
		}else{
			comment.setContents(contents);
		}
		
		productService.addComment(comment);
		comment=productService.getComment(comment.getCommentNo());
		
		if(comment.getReceiverId()!=null){
			comment.setReceiverId("@"+comment.getReceiverId()+" ");
		}else{
			comment.setReceiverId("");
		}
		
		model.addAttribute("comment", comment);
	}
	
	@RequestMapping(value="getProduct")
	public String getProduct( @ModelAttribute("product") Product product, @RequestParam(value="menu", defaultValue="no") String menu, HttpSession session, Model model, Search search ) throws Exception {
		
		System.out.println("/getProduct");
		
		String destination="readProduct.jsp";
		boolean isDuplicate=true;
		int prodNo=product.getProdNo();
		
		Product product2=productService.getProduct(prodNo);
		product2.setProTranCode(product.getProTranCode());
		
		if(menu.equals("manage")){
			destination="updateProductView.jsp";
		}else if(menu.equals("search")){
			session.getAttribute("user");

			List<Integer> history=(ArrayList<Integer>)session.getAttribute("history");
			history.add(prodNo);
			session.setAttribute("history", history);
		}

		WishList wishList=new WishList();
		wishList.setCustomerId(((User)session.getAttribute("user")).getUserId());
		wishList.setProductNo(prodNo);
		if(!productService.checkWishList(wishList)){
			isDuplicate=false;
		}
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		Map<String, Object> map=this.listComment(prodNo, search);
		
		model.addAttribute("list",map.get("list"));
		model.addAttribute("resultPage", map.get("resultPage"));
		model.addAttribute("search", map.get("search"));
		model.addAttribute("product", product2);
		model.addAttribute("isDuplicate", isDuplicate);
		
		return "forward:/product/"+destination;
	}
	
	@RequestMapping(value={"/getJsonProduct/{prodNo}"}, method=RequestMethod.GET)
	public void getJsonProduct( @PathVariable int prodNo, HttpSession session, Model model ) throws Exception {
		
		System.out.println("/getJsonProduct");
		WishList wishList=new WishList();
		boolean isDuplicate=true;		
		
		Product product=productService.getProduct(prodNo);
		wishList.setCustomerId(((User)session.getAttribute("user")).getUserId());
		wishList.setProductNo(prodNo);
		if(!productService.checkWishList(wishList)){
			isDuplicate=false;
		}
		
		model.addAttribute("product", product);
		model.addAttribute("isDuplicate", isDuplicate);
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateProduct( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{

		System.out.println("/updateProductView");
		Product product = productService.getProduct(prodNo);
		model.addAttribute("product", product);
		
		return "forward:/product/updateProductView.jsp";
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct( @ModelAttribute("product") Product product , Model model ) throws Exception{

		System.out.println("/updateProduct");
		productService.updateProduct(product);
		return "redirect:/product/getProduct?prodNo="+product.getProdNo();
	}
	
	@RequestMapping(value="listProduct")
	public String listProduct( @ModelAttribute("search") Search search , @RequestParam("menu") String menu, Model model , HttpServletRequest request, HttpSession session) throws Exception{
		
		System.out.println("/listProduct");
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		Map<String , Object> map=productService.getProductList(search);
		User user=(User)session.getAttribute("user");
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		if(user!=null){
			model.addAttribute("role", user.getRole());
		}
		model.addAttribute("menu", menu);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}
	
	@RequestMapping(value="listWishList")
	public ModelAndView listWishList( @RequestParam(value="prodNo", defaultValue="0") int prodNo, @RequestParam( value="chbox", required=false) List<String> values, @ModelAttribute("search") Search search , Model model , HttpSession session) throws Exception{
		
		System.out.println("/listWishList");
		System.out.println(search);
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setSearchKeyword(((User)session.getAttribute("user")).getUserId());
		Map<String , Object> map =productService.getWishList(search);
		List<Product> list=new ArrayList<Product>();
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		ModelAndView modelAndView=new ModelAndView();
		Product product=new Product();
		
		modelAndView.addObject("list",map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("/product/listWishList.jsp");
		
		if(values!=null && prodNo!=0){
			for(int i=0; i<values.size(); i++){
				product = productService.getProduct(Integer.parseInt(values.get(i)));
				list.add(product);
			}
			modelAndView.addObject("list",list);
			modelAndView.setViewName("/product/deleteWishesView.jsp");
		}
		
		
		return modelAndView;
	}
	
	@RequestMapping(value="listComment")
	public Map<String, Object> listComment(int prodNo, Search search) throws Exception{
		
		System.out.println("/listComment");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setSearchKeyword(Integer.toString(prodNo));
		Map<String , Object> map =productService.getCommentList(search);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
	
	@RequestMapping(value={"listJsonComment/{prodNo}/{currentPage}"}, method=RequestMethod.GET)
	public void listJsonComment( @PathVariable int prodNo, @PathVariable int currentPage, Model model ) throws Exception {
		
		System.out.println("/listJsonComment");
		Search search= new Search();
		
		if(currentPage==0){
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setSearchKeyword(Integer.toString(prodNo));
		search.setCurrentPage(currentPage+1);
		
		Map<String , Object> map =productService.getCommentList(search);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		
		model.addAttribute("list",map.get("list"));
		model.addAttribute("resultPage", map.get("resultPage"));
		model.addAttribute("currentPage", search.getCurrentPage());
		
	}
}