package com.springmvc.controller;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.protobuf.TextFormat.ParseException;

import bean.File_Quotation;
import bean.Staff;
import bean.OrderRequest;
import util.FileManager;
import util.OrderRequestManager;



@Controller
public class FileController {
	/*
	@RequestMapping(value="/addfilequotation", method=RequestMethod.POST)
	public ModelAndView do_register1(HttpServletRequest  request, HttpSession session) throws UnsupportedEncodingException {
	request.setCharacterEncoding("UTF-8");
	
	try {
		request.setCharacterEncoding("UTF-8");
	} catch (UnsupportedEncodingException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
	
	Lecturer lc = (Lecturer) session.getAttribute("lecturer");
	String message = ""; 
	FileManager fm = new FileManager();
	OrderRequestManager or = new OrderRequestManager();
	ModelAndView mav = new ModelAndView("AddFileQuotaion");
	try {
				
				String file_name = request.getParameter("file_name");
				String company_name = request.getParameter("company_name");
				String quotation_no = request.getParameter("quotation_no");
				String quotation_date = request.getParameter("quotation_date");
				String status_file = request.getParameter("status_file");
			
				Calendar caldate = Calendar.getInstance();
				String pattern = "yyyy/MM/dd";
				SimpleDateFormat sdf = new SimpleDateFormat(pattern);
				try {
					caldate.setTime(sdf.parse(quotation_date));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				//int r = cm.insertCow(new Cow(no,img,genes,calbirth,gender,bw,father,mother,status,member));
				//File_Quotation fq = new File_Quotation(fm.getMaxFilequotationID(),file_name,company_name,quotation_no,caldate,status_file,or.getMaxOrderRequestID());
				int a = fm.insertFileQuotaion(new File_Quotation(fm.getMaxFilequotationID(),file_name,company_name,quotation_no,caldate,status_file,or.getMaxOrderRequestID());
				
		}catch (Exception e) {
			e.printStackTrace();
			message = "โปรดลองใหม่อีกครั้ง....";
		}
		
		mav.addObject("message", message); 
		return mav; 
	}*/

}
