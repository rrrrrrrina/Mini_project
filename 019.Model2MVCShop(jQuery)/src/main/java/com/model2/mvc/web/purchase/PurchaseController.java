package com.model2.mvc.web.purchase;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.domain.WishList;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 Controller
@Controller
@RequestMapping("/purchase/*")

public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음
		
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="addPurchase")
	public String addPurchase( @ModelAttribute("purchase") Purchase purchase, @RequestParam(value="prodNo", required=false) String prodNo, HttpSession session,Model model ) throws Exception {
		
		System.out.println("/addPurchase");
		
		User user=userService.getUser(((User)session.getAttribute("user")).getUserId());
		String[] temp=prodNo.split(",");
		List<Product> list=new ArrayList<Product>();
		purchase.setBuyer(user);
		purchase.setTranCode("1");
		
		Product product=new Product();
		for(int i=0; i<temp.length; i++){
			product=productService.getProduct(Integer.parseInt(temp[i]));
			list.add(product);
			purchase.setPurchaseProd(product);
			purchaseService.addPurchase(purchase);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("purchase",purchase);

		return "forward:/purchase/addPurchase.jsp";
		
	}
	
	@RequestMapping(value="addPurchaseView")
	public ModelAndView addPurchaseView( @RequestParam(value="prodNo", defaultValue="0") int prodNo, @RequestParam( value="chbox", required=false) List<String> values, Model model ) throws Exception{

		System.out.println("/addPurchaseView");
		
		List<Product> list=new ArrayList<Product>();
		ModelAndView modelAndView=new ModelAndView();

		Product product=new Product();
		if(values != null && values.size()>1){
			for(int i=0; i<values.size(); i++){
				product = productService.getProduct(Integer.parseInt(values.get(i)));
				list.add(product);
			}
			modelAndView.addObject("list",list);
			modelAndView.setViewName("/purchase/addPurchaseListView.jsp");
		}else{
			product = productService.getProduct(prodNo);
			modelAndView.addObject("product",product);
			modelAndView.setViewName("/purchase/addPurchaseView.jsp");
		}
		
		return modelAndView;
	}
	
	
	@RequestMapping(value="getPurchase", method=RequestMethod.GET)
	public ModelAndView getPurchase(@RequestParam ("tranNo") int tranNo, Model model ) throws Exception {
		
		System.out.println("/getPurchase");
		Purchase purchase=purchaseService.getPurchase(tranNo);
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.addObject("purchase",purchase);
		modelAndView.setViewName("/purchase/readPurchase.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.GET)
	public ModelAndView updatePurchase( @RequestParam("tranNo") int tranNo , Model model ) throws Exception{

		System.out.println("/updatePurchaseView");
		
		Purchase purchase=purchaseService.getPurchase(tranNo);
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.addObject("purchase",purchase);
		modelAndView.setViewName("/purchase/updatePurchaseView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.POST)
	public ModelAndView updatePurchase( @ModelAttribute("purchase") Purchase purchase , Model model ) throws Exception{

		System.out.println("/updatePurchase");
		purchaseService.updatePurcahse(purchase);
		Purchase purchase2=purchaseService.getPurchase(purchase.getTranNo());
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.addObject("purchase", purchase2);
		modelAndView.setViewName("redirect:/purchase/listPurchase");
		
		return modelAndView;
	}
	
	@RequestMapping(value="updateTranCode", method=RequestMethod.GET)
	public ModelAndView updateTranCode( @ModelAttribute("purchase") Purchase purchase , Model model ) throws Exception{

		System.out.println("/updateTranCode");
		Purchase purchase2=purchaseService.getPurchase(purchase.getTranNo());
		purchaseService.updateTranCode(purchase2);
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.setViewName("redirect:/purchase/listPurchase");
		
		return modelAndView;
	}
	
	@RequestMapping(value="updateTranCodeByProd", method=RequestMethod.GET)
	public ModelAndView updateTranCodeByProd( @RequestParam("prodNo") int prodNo , @RequestParam("proTranCode") String proTranCode, Model model ) throws Exception{

		System.out.println("/updateTranCodeByProd");
		Purchase purchase2=purchaseService.getPurchase2(prodNo);
		purchase2.setTranCode(proTranCode);
		purchaseService.updateTranCode(purchase2);
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.setViewName("redirect:/product/listProduct?menu=manage");
		
		return modelAndView;
	}
	
	@RequestMapping(value="listPurchase")
	public ModelAndView listPurchase( @ModelAttribute("search") Search search , Model model , HttpSession session) throws Exception{
		
		System.out.println("/listPurchase");
		System.out.println("listProductController내:"+search);
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		String userId=((User)session.getAttribute("user")).getUserId();
		Map<String , Object> map =purchaseService.getPurchaseList(search, userId);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.addObject("list",map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("/purchase/listPurchase.jsp");
		
		
		return modelAndView;
	}
	
	
	@RequestMapping(value="listSale", method=RequestMethod.GET)
	public ModelAndView listSale( @ModelAttribute("search") Search search , Model model , HttpSession session) throws Exception{
		
		System.out.println("/listSale");
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		Map<String , Object> map=purchaseService.getSaleList(search);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.addObject("list",map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("/purchase/listPurchase.jsp");
		
		
		return modelAndView;
	}
}