package com.model2.mvc.common;


//==>����Ʈȭ���� �𵨸�(�߻�ȭ/ĸ��ȭ)�� Bean 
public class Search {
	
	///Field
	private int currentPage;
	private String searchCondition;
	private String searchKeyword;
	private String orderByPrice;
	private int pageSize;
	private String startPrice;
	private String endPrice;
	private String searchMenu;
	//==> ����Ʈȭ�� currentPage�� �ش��ϴ� ȸ�������� ROWNUM ��� SELECT ���� �߰��� Field 
	//==> UserMapper.xml �� 
	//==> <select  id="getUserList"  parameterType="search"	resultMap="userSelectMap">
	//==> ����
	private int endRowNum;
	private int startRowNum;
	
	///Constructor
	public Search() {
	}
	
	///Method
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	//==> Select Query �� ROWNUM ������ �� 
	public int getEndRowNum() {
		return getCurrentPage()*getPageSize();
	}
	//==> Select Query �� ROWNUM ���� ��
	public int getStartRowNum() {
		return (getCurrentPage()-1)*getPageSize()+1;
	}

	public String getStartPrice() {
		return startPrice;
	}

	public void setStartPrice(String startPrice) {
		this.startPrice = startPrice;
	}

	public String getEndPrice() {
		return endPrice;
	}

	public void setEndPrice(String endPrice) {
		this.endPrice = endPrice;
	}

	public String getOrderByPrice() {
		return orderByPrice;
	}

	public void setOrderByPrice(String orderByPrice) {
		this.orderByPrice = orderByPrice;
	}

	public String getSearchMenu() {
		return searchMenu;
	}

	public void setSearchMenu(String searchMenu) {
		this.searchMenu = searchMenu;
	}

	@Override
	public String toString() {
		return "Search [currentPage=" + currentPage + ", searchCondition=" + searchCondition + ", searchKeyword="
				+ searchKeyword + ", orderByPrice=" + orderByPrice + ", pageSize=" + pageSize + ", startPrice="
				+ startPrice + ", endPrice=" + endPrice + ", searchMenu=" + searchMenu + ", endRowNum=" + endRowNum
				+ ", startRowNum=" + startRowNum + "]";
	}

	

	
}