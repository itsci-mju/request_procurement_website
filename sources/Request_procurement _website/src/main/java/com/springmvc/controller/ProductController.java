package com.springmvc.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.OrderRequest;
import bean.Product;
import bean.Staff;

import util.OrderRequestManager;
import util.ProductManager;
import util.QuantityManager;
import util.StaffManager;

public class ProductController {

	//โหลดข้อมูล Product
	@RequestMapping(value = "/loadallproduct", method = RequestMethod.GET)
	public String loadallHospitalPage(HttpServletRequest request) throws UnsupportedEncodingException {
		request.setCharacterEncoding("UTF-8");
		ProductManager pm = new ProductManager();
		List<Product> list = new ArrayList<>();
		list =pm.listAllProducts();
		
		request.setAttribute("result", list);
		
		return "RequestOrderRroduct";
	}
	 
	/*
	@RequestMapping(value="/addProdct", method=RequestMethod.POST)
	public ModelAndView do_addOrderRequest(HttpServletRequest  request, HttpSession session,@RequestBody String param) throws UnsupportedEncodingException {
	request.setCharacterEncoding("UTF-8");
	// Product mb = (Product) session.getAttribute(""); 
		String message = ""; 
		OrderRequestManager orm = new OrderRequestManager();
		ModelAndView mav = new ModelAndView("RequestOrderProduct");
		
		StaffManager sm = new StaffManager();
			try {          
			//	String chList = request.getParameter("chList");
				String status  = "กำลังรอการดำเนินการจากหน่วยพันสดุ";
				String request_type =  "ไม่มีใบเสนอราคา";
				String comment = "-";
				

				String product = request.getParameter("p");
				String total = request.getParameter("t");
				String unit = request.getParameter("u");
				Calendar c = Calendar.getInstance();
			//	System.out.println(product);
			//	System.out.println(chList);
				String username = request.getParameter("username");
				OrderRequest or = new OrderRequest(orm.getMaxOrderRequestID(),c,status,request_type,comment);
				Staff  s = sm.getStaff(username);
				or.setStaff(s);
				orm.insertOrderRequest2(or);
				
				//int r = orm.insertOrderRequest(new OrderRequest(orm.getMaxOrderRequestID(),calorderRequest_date,status,request_type,comment));
			
		}catch (Exception e) {
			e.printStackTrace();
			message = "โปรดลองใหม่อีกครั้ง....";
		}
			return mav;
	
	}*/
	
	
	
	  @RequestMapping(value = "/submitEditProduct", method = RequestMethod.POST)
		public String submitEditPage(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
			request.setCharacterEncoding("UTF-8");
			String message = ""; 
			OrderRequestManager orm = new OrderRequestManager();
			QuantityManager qm = new QuantityManager();
			ModelAndView mav = new ModelAndView("Edit_Requestproduct");
			StaffManager sm = new StaffManager();
			
			String username = request.getParameter("username");
			Staff  s = sm.getStaff(username);
			
			int number = Integer.parseInt(request.getParameter("number"));
			
			ArrayList<Integer> pid = new ArrayList<Integer>();
			ProductManager pm = new ProductManager();
			ArrayList<Integer> qty = new ArrayList<Integer>();
			ArrayList<Double> total = new ArrayList<Double>();
			
			ArrayList<String> product = new ArrayList<String>();
			for (int i=0 ;i<number; i++) {
				if(request.getParameter("t"+(i+1))!=null) {
				 qty.add(Integer.parseInt(request.getParameter("t"+(i+1))));
				 total.add(Double.parseDouble(request.getParameter("tt"+(i+1)))) ;
				 product.add(request.getParameter("p"+(i+1)));
				 pid.add(Integer.parseInt(request.getParameter("id"+(i+1)).trim())) ;
				}
			}
			
			
			
		/*
			Product m = new Product(pid,product,qty,total);
			ProductManager pm = new ProductManager();
			int r = pm.();
			 session.setAttribute("member", m);	
			request.setAttribute("Editresult", r);*/
			return "Edit_Requestproduct";
		}
}
