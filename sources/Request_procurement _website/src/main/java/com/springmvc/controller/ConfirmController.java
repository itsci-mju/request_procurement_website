package com.springmvc.controller;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.protobuf.TextFormat.ParseException;

import bean.ConfirmForm;
import bean.File_Quotation;
import bean.Staff;
import bean.OrderRequest;
import util.ConfirmManager;
import util.FileManager;
import util.OrderRequestManager;
import java.util.Calendar;
import java.util.Date;

 

@Controller
public class ConfirmController {

	
	//Page Confirm Form Detail
	@RequestMapping(value = "/loadConfirmFormDetail", method = RequestMethod.GET)
	public String loadConfirmFormDetail(HttpServletRequest request, Model md, HttpSession session) throws java.text.ParseException, ParseException {
		
	String Text_OrderRequest_id = request.getParameter("OrderRequest_id");
	int OrderRequest_id = Integer.parseInt(Text_OrderRequest_id);
	OrderRequestManager orm = new OrderRequestManager();
	OrderRequest order_r = orm.OrderRequestByID(Text_OrderRequest_id);
	String File_text = request.getParameter("File");
	
	ConfirmManager cm = new ConfirmManager();
	ConfirmForm cf = cm.ConfirmFormByID(Text_OrderRequest_id);
	
	FileManager fm = new FileManager();
	List<File_Quotation> fq = fm.getAllQuotation(OrderRequest_id) ;
	
	
	session.setAttribute("OrderRequest", order_r);	
	session.setAttribute("ConfirmForm", cf);
	session.setAttribute("File", fq);
		
			return "ConfirmRequestDetail";
		
		
		
	}
	
	//AddConfirmform Controller by lecturer
			@RequestMapping(value="/addConfirmform", method=RequestMethod.POST)
			public ModelAndView do_addConfirmform (HttpServletRequest  request, HttpSession session) throws UnsupportedEncodingException, java.text.ParseException {
				request.setCharacterEncoding("UTF-8");
				ModelAndView mav = new ModelAndView("ListRequest");
				String message = ""; 
				OrderRequestManager orm = new OrderRequestManager();
				Calendar confirm_date = Calendar.getInstance();
				String board_name1 = request.getParameter("board_name1");
				String board_name2 = request.getParameter("board_name2");
				String chairman_Board_name = request.getParameter("chairman_Board_name");
				
				
				String company_name = request.getParameter("company_name");
				String quotation_no = request.getParameter("quotation_no");
				String quotation_date =request.getParameter("quotation_date");

				
				
				Calendar cal_date = Calendar.getInstance();
				String [] arrofStr = quotation_date.split("/");
				int day = Integer.parseInt(arrofStr[0]);
				int month = Integer.parseInt(arrofStr[1]);
				int year = Integer.parseInt(arrofStr[2]);
			
				
				cal_date.set(cal_date.DAY_OF_MONTH,day);
				cal_date.set(cal_date.MONTH,month);
				cal_date.set(cal_date.YEAR,year);
				
				
				
				String money_type = request.getParameter("money_type");
				if(money_type.equals("")) {
					money_type = request.getParameter("money_type_etc");
				}
				
				String necessity_type = request.getParameter("necessity_type");
				String necessity_type1_text;
				String necessity_type2_text1;
				String necessity_type2_text2;
				
				if(necessity_type.equals("")) {
					necessity_type = request.getParameter("necessity_type_etc");
				}else if(necessity_type.equals("1")) {
					necessity_type1_text = request.getParameter("necessity_type1_text");
					necessity_type = "เพื่อใช้สำหรับการเรียนการสอน รายวิชา "+necessity_type1_text;
				}else if(necessity_type.equals("2")) {
					necessity_type2_text1 = request.getParameter("necessity_type2_text1");
					necessity_type2_text2 = request.getParameter("necessity_type2_text2");
					necessity_type = "เพื่อใช้สำหรับการเรียนการสอน รายวิชา วท.498 หัวข้อ "+necessity_type2_text1+" ชื่อ-นามสกุล นักศึกษา "+necessity_type2_text2;
				}
				
				String OrderRequest_id = request.getParameter("OrderRequest_id"); 
				
				OrderRequest or = orm.OrderRequestByID(OrderRequest_id);
				
				ConfirmForm cf = new ConfirmForm(orm.getMaxConfirmFormID(),confirm_date,money_type,necessity_type,chairman_Board_name,board_name1,board_name2,company_name,cal_date,quotation_no,or);
				
				orm.insertConfirmForm(cf);
				//update status
				orm.updateStatus("ยืนยันความประสงค์สำเร็จ", OrderRequest_id);
				
				
				return mav;
			}
	

}
