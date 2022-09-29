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

}
