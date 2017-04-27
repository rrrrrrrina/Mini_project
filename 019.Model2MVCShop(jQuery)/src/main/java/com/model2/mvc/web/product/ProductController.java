package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.domain.WishList;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 Controller
@Controller
@RequestMapping("/product/*")

public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product, HttpServletRequest request, Model model ) throws Exception {

		System.out.println("/addProduct");
		System.out.println("/addProductControll내:"+product);
		
		//File file=new File("C:\\Users\\BitCamp\\git\\017PJT\\017.Model2MVCShop(URI,pattern)\\WebContent\\images\\uploadFiles\\"+product.getFile().getOriginalFilename());
		
		/*try{
			product.getFile().transferTo(file);
		}catch(IOException e){
			e.printStackTrace();
		}*/
		
		productService.addProduct(product);
		
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
	public void deleteJsonWishList( @RequestParam( value="productNo", defaultValue="0") int productNo, HttpSession session, Model model ) throws Exception {

		System.out.println("/deleteJsonWishList");
		WishList wishList=new WishList();
		
		wishList.setCustomerId(((User)session.getAttribute("user")).getUserId());
		wishList.setProductNo(productNo);
		
		productService.deleteWishList(wishList);
		Product product=productService.getProduct(productNo);
		
		model.addAttribute("product", product);
	}
	
	@RequestMapping(value="addWishList", method=RequestMethod.POST)
	public String addWishList( @ModelAttribute("wishList") WishList wishList, HttpSession session, Model model ) throws Exception {
		
		wishList.setCustomerId(((User)session.getAttribute("user")).getUserId());
		
		System.out.println("/addWishList");
		
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
			productService.addWishList(wishList);
		}
		
		Product product=productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
	}
	
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public String getProduct( @ModelAttribute("product") Product product, @RequestParam(value="menu", defaultValue="no") String menu, HttpSession session, Model model ) throws Exception {
		
		System.out.println("/getProduct");
		String destination="readProduct.jsp";
		boolean isDuplicate=true;
		Product product2=productService.getProduct(product.getProdNo());
		product2.setProTranCode(product.getProTranCode());
		if(menu.equals("manage")){
			destination="updateProductView.jsp";
		}else if(menu.equals("search")){
			session.getAttribute("user");

			List<Integer> history=(ArrayList<Integer>)session.getAttribute("history");
			history.add(product.getProdNo());
			session.setAttribute("history", history);
		}

		WishList wishList=new WishList();
		wishList.setCustomerId(((User)session.getAttribute("user")).getUserId());
		wishList.setProductNo(product.getProdNo());
		if(!productService.checkWishList(wishList)){
			isDuplicate=false;
		}
		
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
}