package com.springmvc.controller;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
public class MappingController {
	public MappingController() {
		// TODO Auto-generated constructor stub
		
	}
		
		
	
	
	
		//Load index page
		@RequestMapping(value = "/loadindex", method = RequestMethod.GET)
		public String loadthomePage() {
			
			return "index";
		}
		
		//Load Request Product page
		@RequestMapping(value = "/loadpageorder1", method = RequestMethod.GET)
		public String loadtRequestproductPage() {
			return "Requestproduct";
		}
		
		
		//Load Request Quotation page
		@RequestMapping(value = "/loadpageorder2", method = RequestMethod.GET)
		public String loadtRequestquotationPage() {
			return "Requestquotation";
		}
		
		//Load List Request page
		@RequestMapping(value = "/loadpagelistorder", method = RequestMethod.GET)
		public String loadtListOrderPage(HttpServletRequest request, Model md, HttpSession session) throws UnsupportedEncodingException {
			request.setCharacterEncoding("UTF-8");	
		
			return "ListRequest";
		}
		
		//Load RequestDetail & Quotation detail page
		@RequestMapping(value = "/loadRequestDetail", method = RequestMethod.GET)
		public String loadRequestDetailPage(HttpServletRequest request, Model md, HttpSession session) throws java.text.ParseException {
		String request_type = request.getParameter("request_type");	
		String OrderRequest_id = request.getParameter("OrderRequest_id");
		session.setAttribute("OrderRequest_id", OrderRequest_id);	
		
		
		OrderRequestManager orm = new OrderRequestManager();
			OrderRequest order_r = orm.OrderRequestByID(OrderRequest_id);
			session.setAttribute("OrderRequest", order_r);	
			
			if(request_type.trim().equals("ไม่มีใบเสนอราคา")) {
				return "RequestDetail";
			}else {
				return "Request_quotation_Detail";
			}
			
			
		}
		
	
		

	//load Edit  RequestDetail & Quotation detail page
		@RequestMapping(value = "/loadEditRequest", method = RequestMethod.GET)
		public String loadEditRequestProductPage(HttpServletRequest request, Model md, HttpSession session) throws java.text.ParseException{
			
			String Text_OrderRequest_id = request.getParameter("OrderRequest_id");
			String request_type = request.getParameter("request_type");
			int OrderRequest_id = Integer.parseInt(Text_OrderRequest_id);
			OrderRequestManager orm = new OrderRequestManager();
			OrderRequest order_r = orm.OrderRequestByID(Text_OrderRequest_id);
			session.setAttribute("OrderRequest", order_r);	
				
				if(request_type.trim().equals("ไม่มีใบเสนอราคา")) {
					return "Edit_Requestproduct";
				}else {
					return "Edit_Requestquotation";
				}
			
		}
		
		//load Confirm Form page
		@RequestMapping(value = "/loadpageConfirm", method = RequestMethod.GET)
		public String loadConfirmPage(HttpServletRequest request, Model md, HttpSession session) throws java.text.ParseException {
			String Text_OrderRequest_id = request.getParameter("OrderRequest_id");
			String request_type = request.getParameter("request_type");
			int OrderRequest_id = Integer.parseInt(Text_OrderRequest_id);
			OrderRequestManager orm = new OrderRequestManager();
			OrderRequest order_r = orm.OrderRequestByID(Text_OrderRequest_id);
			session.setAttribute("OrderRequest", order_r);	
			
			return "ConfirmRequest";
		}
		
		//Load List Request History page
		@RequestMapping(value = "/loadpagelistrequestHistory", method = RequestMethod.GET)
		public String loadtListRequestHistory(HttpServletRequest request, Model md, HttpSession session) {
		
			return "ListRequest_History";
		}	
	
		
//-----------------------------------------------------supplies officer--------------------------------
		
		//Load Add File Quotation page
		@RequestMapping(value = "/loadpageAddQuotation", method = RequestMethod.GET)
		public String loadtAddQuotationPage(HttpServletRequest  request, HttpSession session) throws java.text.ParseException {
			String OrderRequest_id = request.getParameter("OrderRequest_id");
			session.setAttribute("OrderRequest_id", OrderRequest_id);	
			OrderRequestManager orm = new OrderRequestManager();
				OrderRequest order_r = orm.OrderRequestByID(OrderRequest_id);
				session.setAttribute("OrderRequest", order_r);	
			
			return "Addquotation";
		}
		
		//Load ConfirmRequestDetail page
				@RequestMapping(value = "/loadpageConfirmRequestDetail", method = RequestMethod.GET)
				public String loadtConfirmRequestDetailPage(HttpServletRequest  request, HttpSession session) throws java.text.ParseException {
					String OrderRequest_id = request.getParameter("OrderRequest_id");
					String request_type = request.getParameter("request_type");
					
					OrderRequestManager orm = new OrderRequestManager();
					OrderRequest order_r = orm.OrderRequestByID(OrderRequest_id);
					session.setAttribute("OrderRequest", order_r);	
					return "ConfirmRequestDetail";
				}
		
		//Load Quotation Detail page
		@RequestMapping(value = "/loadpageQuotationDetailBySupplise", method = RequestMethod.GET)
		public String loadtQuotationDetailBySupplise(HttpServletRequest request, Model md, HttpSession session) throws java.text.ParseException {

			String OrderRequest_id = request.getParameter("OrderRequest_id");
			String request_type = request.getParameter("request_type");
			
			OrderRequestManager orm = new OrderRequestManager();
			OrderRequest order_r = orm.OrderRequestByID(OrderRequest_id);
			session.setAttribute("OrderRequest", order_r);	
			
			return "Quotation_Detail_BySupplies";
		}	
		
		//Load Quotation Detail page
		@RequestMapping(value = "/loadpageQuotationDetailByLecturer", method = RequestMethod.GET)
		public String loadtQuotationDetailByLecturer(HttpServletRequest request, Model md, HttpSession session) throws java.text.ParseException {

			String OrderRequest_id = request.getParameter("OrderRequest_id");
			String request_type = request.getParameter("request_type");
			
			OrderRequestManager orm = new OrderRequestManager();
			OrderRequest order_r = orm.OrderRequestByID(OrderRequest_id);
			session.setAttribute("OrderRequest", order_r);	
			
			return "Quotation_Detail_BySupplies";
		}	
	
}
