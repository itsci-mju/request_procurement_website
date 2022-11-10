package com.springmvc.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.util.URLEncoder;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody;

import com.google.protobuf.TextFormat.ParseException;

import bean.*;

import util.ConnectionDB;
import util.FileManager;
import util.LoginManager;
import util.OrderRequestManager;
import util.ProductManager;
import util.QuantityManager;
import util.StaffManager;


@Controller
public class OrderRequestController {
	
	public OrderRequestController() {
		// TODO Auto-generated constructor stub
		
	}
	
	
	
	//insert OrderRequest Product Controller by lecturer
	@RequestMapping(value="/addOrderRequest", method=RequestMethod.POST)
	public ModelAndView do_addOrderRequest(HttpServletRequest  request, HttpSession session) throws UnsupportedEncodingException {
	request.setCharacterEncoding("UTF-8");
	// Product mb = (Product) session.getAttribute(""); 
		String message = ""; 
		OrderRequestManager orm = new OrderRequestManager();
		QuantityManager qm = new QuantityManager();
		ModelAndView mav = new ModelAndView("ListRequest");
		StaffManager sm = new StaffManager();
			try {          
			//	orderRequest
				String status  = "กำลังรอการดำเนินการจากหน่วยพัสดุ";
				String request_type =  "ไม่มีใบเสนอราคา";
				String comment = "-";
				Calendar c = Calendar.getInstance();
				String username = request.getParameter("username");
				Staff  s = sm.getStaff(username);
				OrderRequest or = new OrderRequest(orm.getMaxOrderRequestID(),c,status,request_type,comment,s);
				
				or.setStaff(s);
				orm.insertOrderRequest2(or);
				
				//number get value from screen
			int number = Integer.parseInt(request.getParameter("number"));
		
				ArrayList<Integer> pid = new ArrayList<Integer>();
			//	System.out.println(number);
				ProductManager pm = new ProductManager();
				ArrayList<Integer> qty = new ArrayList<Integer>();
				ArrayList<Double> total = new ArrayList<Double>();
				
				//loop insert
				ArrayList<String> product = new ArrayList<String>();
				for (int i=0 ;i<number; i++) {
					if(request.getParameter("t"+(i+1))!=null) {
					 qty.add(Integer.parseInt(request.getParameter("t"+(i+1))));
					 total.add(Double.parseDouble(request.getParameter("tt"+(i+1)).replace(",", ""))) ;
					 product.add(request.getParameter("p"+(i+1)));
					 pid.add(Integer.parseInt(request.getParameter("id"+(i+1)).trim())) ;
					}
				}
				//System.out.println(product);
				//System.out.println(qty);
						
				for(int j=0;j<product.size();j++) {
					Product p = new Product();
					p.setProduct_id(pid.get(j));
					Quantity q = new Quantity(qty.get(j),total.get(j),or,p);
					
					qm.insertQuantity(q);
				}
				
		}catch (Exception e) {
			e.printStackTrace();
			message = "โปรดลองใหม่อีกครั้ง....";
		}
			return mav;
	}
	
	

	//insert OrderRequest FileQuotation Controller by lecturer
		@RequestMapping(value="/addOrderRequest2", method=RequestMethod.POST)
		public ModelAndView do_addOrderRequest2
				(@RequestParam("a_file_quotation") MultipartFile file1,
				@RequestParam("b_file_quotation") MultipartFile file2,
				@RequestParam("c_file_quotation") MultipartFile file3  ,
				HttpServletRequest  request, HttpSession session) throws UnsupportedEncodingException {
		request.setCharacterEncoding("UTF-8");
		String message = ""; 
		OrderRequestManager orm = new OrderRequestManager();
		QuantityManager qm = new QuantityManager();
		FileManager fm = new FileManager();
		ModelAndView mav = new ModelAndView("ListRequest");
		StaffManager sm = new StaffManager();
		OrderRequestManager om = new OrderRequestManager();
				try {          
			
					String status  = "กำลังรอการดำเนินการจากหน่วยพัสดุ";
					String request_type =  "มีใบเสนอราคา";
					String comment = "-";
					Calendar c = Calendar.getInstance();
					String username = request.getParameter("username");
					Staff  s = sm.getStaff(username);
					OrderRequest or = new OrderRequest(orm.getMaxOrderRequestID(),c,status,request_type,comment,s);
					
					or.setStaff(s);
					orm.insertOrderRequest2(or);
					
					//quotation  1
					String anamecompany = request.getParameter("a_name_company");
					String afilequotation = "Quotation_"+om.getMaxFileID()+"_"+anamecompany+".pdf";
					String anumberquotation = request.getParameter("a_number_quotation");
					String adatequotation = request.getParameter("a_date_quotation");
					
				
					Calendar cal_adatequotation = Calendar.getInstance();
					String pattern = "yyyy-MM-dd";
					SimpleDateFormat sdf = new SimpleDateFormat(pattern);
					cal_adatequotation.setTime(sdf.parse(adatequotation));
					
					File_Quotation fq1 = new File_Quotation(fm.getMaxFilequotationID(),afilequotation,anamecompany,anumberquotation,cal_adatequotation,request_type);
			
					fq1.setOrderRequest(or);
					fm.insertFileQuotaion(fq1);
					//quotation  2
					String bnamecompany = request.getParameter("b_name_company");
					String bfilequotation = "Quotation_"+om.getMaxFileID()+"_"+bnamecompany+".pdf";
					
					String bnumberquotation = request.getParameter("b_number_quotation");
					String bdatequotation = request.getParameter("b_date_quotation");
					
					
					Calendar cal_bdatequotation = Calendar.getInstance();
					String pattern2 = "yyyy-MM-dd";
					SimpleDateFormat sdf2 = new SimpleDateFormat(pattern2);
					cal_bdatequotation.setTime(sdf2.parse(bdatequotation));
					
					File_Quotation fq2 = new File_Quotation(fm.getMaxFilequotationID(),bfilequotation,bnamecompany,bnumberquotation,cal_bdatequotation,request_type);
					fq2.setOrderRequest(or);
					fm.insertFileQuotaion(fq2);
					
					//quotation  3
					String cnamecompany = request.getParameter("c_name_company");
					String cfilequotation = "Quotation_"+om.getMaxFileID()+"_"+cnamecompany+".pdf";
					String cnumberquotation = request.getParameter("c_number_quotation");
					String cdatequotation = request.getParameter("c_date_quotation");
					
					
					Calendar cal_cdatequotation = Calendar.getInstance();
					String pattern3 = "yyyy-MM-dd";
					SimpleDateFormat sdf3 = new SimpleDateFormat(pattern3);
					cal_cdatequotation.setTime(sdf3.parse(cdatequotation));
					
					File_Quotation fq3 = new File_Quotation(fm.getMaxFilequotationID(),cfilequotation,cnamecompany,cnumberquotation,cal_cdatequotation,request_type);
					fq3.setOrderRequest(or);
					fm.insertFileQuotaion(fq3);
					
					if (!file1.isEmpty()) {
					
							byte[] bytes = file1.getBytes();
							String path = request.getServletContext().getRealPath("/")+ "pdf/";

							// Create the file on server
							File serverFile = new File(path + afilequotation);
							BufferedOutputStream stream = new BufferedOutputStream(
									new FileOutputStream(serverFile));
							stream.write(bytes);
							stream.close();
							System.out.println("Server File Location="+ path);

							System.out.println("You successfully uploaded file=" + afilequotation);
					} else {
						System.out.println("You failed to upload " + afilequotation+ " because the file was empty.");
					}    
					if (!file2.isEmpty()) {
						
						byte[] bytes = file2.getBytes();
						String path = request.getServletContext().getRealPath("/")+ "pdf/";

						// Create the file on server
						File serverFile = new File(path + bfilequotation);
						BufferedOutputStream stream = new BufferedOutputStream(
								new FileOutputStream(serverFile));
						stream.write(bytes);
						stream.close();
						System.out.println("Server File Location="+ path);

						System.out.println("You successfully uploaded file=" + bfilequotation);
				} else {
					System.out.println("You failed to upload " + bfilequotation+ " because the file was empty.");
				}    
					if (!file3.isEmpty()) {
						
						byte[] bytes = file3.getBytes();
						String path = request.getServletContext().getRealPath("/")+ "pdf/";

						// Create the file on server
						File serverFile = new File(path + cfilequotation);
						BufferedOutputStream stream = new BufferedOutputStream(
								new FileOutputStream(serverFile));
						stream.write(bytes);
						stream.close();
						System.out.println("Server File Location="+ path);
						
						System.out.println("You successfully uploaded file=" + cfilequotation);
				} else {
					System.out.println("You failed to upload " + cfilequotation+ " because the file was empty.");
				}    
			}catch (Exception e) {
				e.printStackTrace();
				message = "โปรดลองใหม่อีกครั้ง....";
			}
				return mav;
		
		}
	

	
		//Controller Delete OrderRequest 
		@RequestMapping(value = "/deleteOrderRequest", method = RequestMethod.GET)
		public String delkidinjectionPage(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
			OrderRequestManager om = new OrderRequestManager();
			String orderRequest_id = request.getParameter("OrderRequest_id");
			
			om.deleteOrderRequest(orderRequest_id);
		
			return "ListRequest";
		}
		
	
		
		
		// Edit OrderRequest Product Controller  by lecturer
		@RequestMapping(value="/EditOrderRequestProduct", method=RequestMethod.POST)
		public ModelAndView do_EditOrderRequestProduct(HttpServletRequest  request, HttpSession session) throws UnsupportedEncodingException {
		request.setCharacterEncoding("UTF-8");
		// Product mb = (Product) session.getAttribute(""); 
			String message = ""; 
			ModelAndView mav = new ModelAndView("ListRequest");
				try {  
					// orderRequest        
					OrderRequestManager orm = new OrderRequestManager();
					String orderRequest_id = request.getParameter("OrderRequest_id");
					QuantityManager qm = new QuantityManager();
					StaffManager sm = new StaffManager();
					
					int number = Integer.parseInt(request.getParameter("number"));
			
					ArrayList<Integer> pid = new ArrayList<Integer>();
				//	System.out.println(number);
					ProductManager pm = new ProductManager();
					ArrayList<Integer> qty = new ArrayList<Integer>();
					ArrayList<Double> total = new ArrayList<Double>();
					
					ArrayList<String> product = new ArrayList<String>();
					for (int i=0 ;i<number; i++) {
						qm.deleteProduct(orderRequest_id);
						if(request.getParameter("t"+(i+1))!=null) {
						 qty.add(Integer.parseInt(request.getParameter("t"+(i+1))));
						 total.add(Double.parseDouble(request.getParameter("tt"+(i+1)).replace(",", ""))) ;
						 product.add(request.getParameter("p"+(i+1)));
						 pid.add(Integer.parseInt(request.getParameter("id"+(i+1)).trim())) ;
						}
					}
					//System.out.println(product);
					//System.out.println(qty);
					OrderRequest or = new OrderRequest();		
					or = orm.OrderRequestByID(orderRequest_id);
					for(int j=0;j<product.size();j++) {
						Product p = new Product();
						p.setProduct_id(pid.get(j));
						Quantity q = new Quantity(qty.get(j),total.get(j),or,p);
						
						qm.insertQuantity(q);
						
					}
			
			}catch (Exception e) {
				e.printStackTrace();
				message = "โปรดลองใหม่อีกครั้ง....";
			}
				return mav;
		}
		
		//Edit OrderRequest Quotation Controller by lecturer
		@RequestMapping(value="/EditOrderRequest2", method=RequestMethod.POST)
		public ModelAndView do_editaddOrderRequest2
				(@RequestParam("a_file_quotation") MultipartFile file1,
				@RequestParam("b_file_quotation") MultipartFile file2,
				@RequestParam("c_file_quotation") MultipartFile file3  ,
				HttpServletRequest  request, HttpSession session) throws UnsupportedEncodingException {
		request.setCharacterEncoding("UTF-8");
		String message = ""; 
		OrderRequestManager orm = new OrderRequestManager();
		QuantityManager qm = new QuantityManager();
		FileManager fm = new FileManager();
		ModelAndView mav = new ModelAndView("ListRequest");
		StaffManager sm = new StaffManager();
		OrderRequestManager om = new OrderRequestManager();
				try {  
					// orderRequest
					String orderRequest_id  = request.getParameter("OrderRequest_id");
					String request_type =  "มีใบเสนอราคา";
					String username = request.getParameter("username");
					Staff  s = sm.getStaff(username);
					String major = request.getParameter("major");
					System.out.println(major);
					OrderRequest or = om.OrderRequestByID(orderRequest_id);
					
					or.setStaff(s);
					
					List<File_Quotation> f = fm.getAllQuotation(Integer.parseInt(orderRequest_id));
					//quotation  1
					String anamecompany = request.getParameter("a_name_company");
					String afilequotation = "Quotation_"+f.get(0).getFile_id()+"_"+anamecompany+".pdf";
					String anumberquotation = request.getParameter("a_number_quotation");
					String adatequotation = request.getParameter("a_date_quotation");
					
				
					Calendar cal_adatequotation = Calendar.getInstance();
					String pattern = "yyyy-MM-dd";
					SimpleDateFormat sdf = new SimpleDateFormat(pattern);
					cal_adatequotation.setTime(sdf.parse(adatequotation));
					
					File_Quotation fq1 = new File_Quotation(f.get(0).getFile_id(),afilequotation,anamecompany,anumberquotation,cal_adatequotation,request_type);
			
					fq1.setOrderRequest(or);
					fm.updateFileQuotaion(fq1);
					//quotation  2
					String bnamecompany = request.getParameter("b_name_company");
					String bfilequotation = "Quotation_"+f.get(1).getFile_id()+"_"+bnamecompany+".pdf";
					
					String bnumberquotation = request.getParameter("b_number_quotation");
					String bdatequotation = request.getParameter("b_date_quotation");
					
					
					Calendar cal_bdatequotation = Calendar.getInstance();
					String pattern2 = "yyyy-MM-dd";
					SimpleDateFormat sdf2 = new SimpleDateFormat(pattern2);
					cal_bdatequotation.setTime(sdf2.parse(bdatequotation));
					
					File_Quotation fq2 = new File_Quotation(f.get(1).getFile_id(),bfilequotation,bnamecompany,bnumberquotation,cal_bdatequotation,request_type);
					fq2.setOrderRequest(or);
					fm.updateFileQuotaion(fq2);
					
					//quotation  3
					String cnamecompany = request.getParameter("c_name_company");
					String cfilequotation = "Quotation_"+f.get(2).getFile_id()+"_"+cnamecompany+".pdf";
					String cnumberquotation = request.getParameter("c_number_quotation");
					String cdatequotation = request.getParameter("c_date_quotation");
					
					
					Calendar cal_cdatequotation = Calendar.getInstance();
					String pattern3 = "yyyy-MM-dd";
					SimpleDateFormat sdf3 = new SimpleDateFormat(pattern3);
					cal_cdatequotation.setTime(sdf3.parse(cdatequotation));
					
					File_Quotation fq3 = new File_Quotation(f.get(2).getFile_id(),cfilequotation,cnamecompany,cnumberquotation,cal_cdatequotation,request_type);
					fq3.setOrderRequest(or);
					fm.updateFileQuotaion(fq3);
					
					if(major.equals("0")) {
						orm.updateStatus("ยืนยันความประสงค์", orderRequest_id);
					}else {
						orm.updateStatus("กำลังรอการดำเนินการจากหน่วยพัสดุ", orderRequest_id);
						}
					
					
					
					
					if (!file1.isEmpty()) {
					
						byte[] bytes = file1.getBytes();
						String path = request.getServletContext().getRealPath("/")+ "pdf/";

						// Create the file on server
						File serverFile = new File(path + afilequotation);
						BufferedOutputStream stream = new BufferedOutputStream(
								new FileOutputStream(serverFile));
						stream.write(bytes);
						stream.close();
						System.out.println("Server File Location="+ path);

							System.out.println("You successfully uploaded file=" + afilequotation);
					} else {
						System.out.println("You failed to upload " + afilequotation+ " because the file was empty.");
					}    
					if (!file2.isEmpty()) {
						
						byte[] bytes = file2.getBytes();
						String path = request.getServletContext().getRealPath("/")+ "pdf/";

						// Create the file on server
						File serverFile = new File(path + bfilequotation);
						BufferedOutputStream stream = new BufferedOutputStream(
								new FileOutputStream(serverFile));
						stream.write(bytes);
						stream.close();
						System.out.println("Server File Location="+ path);

						System.out.println("You successfully uploaded file=" + bfilequotation);
				} else {
					System.out.println("You failed to upload " + bfilequotation+ " because the file was empty.");
				}    
					
					if (!file3.isEmpty()) {
						
						byte[] bytes = file3.getBytes();
						String path = request.getServletContext().getRealPath("/")+ "pdf/";

						// Create the file on server
						File serverFile = new File(path + cfilequotation);
						BufferedOutputStream stream = new BufferedOutputStream(
								new FileOutputStream(serverFile));
						stream.write(bytes);
						stream.close();
						System.out.println("Server File Location="+ path);

						System.out.println("You successfully uploaded file=" + cfilequotation);
				} else {
					System.out.println("You failed to upload " + cfilequotation+ " because the file was empty.");
				}    
			}catch (Exception e) {
				e.printStackTrace();
				message = "โปรดลองใหม่อีกครั้ง....";
			}
				return mav;
		
		}
		
		
		//Add Comment Controller ByLecturer
		@RequestMapping(value = "/loadAddcommentByLecturer", method = RequestMethod.POST)
		public String loadtAddcommentByLecturer(HttpServletRequest request, Model md, HttpSession session) throws java.text.ParseException {
			
			String OrderRequest_id = request.getParameter("OrderRequest_id");
			String quotation_check = request.getParameter("quotation_check");
			String comment = request.getParameter("comment");
			OrderRequestManager orm = new OrderRequestManager();
			
			if(quotation_check.equals("1")) {
				orm.updateStatus("ยืนยันความประสงค์",OrderRequest_id);
			}else if(quotation_check.equals("2")) {
				orm.updateStatusAndAddComment(OrderRequest_id, "ข้อมูลใบเสนอราคาจากเจ้าหน้าที่ไม่ถูกต้อง", comment);
			}
			
			return "ListRequest";
		}	
		
		
	
		
		
		
//-----------------------------------------------------supplies officer--------------------------------
		
	
		
		//Add Comment Controller
		@RequestMapping(value = "/loadpageAddcommentBySupplise", method = RequestMethod.POST)
		public String loadtAddcommentBySupplise(HttpServletRequest request, Model md, HttpSession session) throws java.text.ParseException {
			
			String OrderRequest_id = request.getParameter("OrderRequest_id");
			String quotation_check = request.getParameter("quotation_check");
			String comment = request.getParameter("comment");
			OrderRequestManager orm = new OrderRequestManager();
			
			if(quotation_check.equals("1")) {
				orm.updateStatusAndAddComment(OrderRequest_id,"ยืนยันความประสงค์", "-");
			}else if(quotation_check.equals("2")) {
				orm.updateStatusAndAddComment(OrderRequest_id, "ข้อมูลใบเสนอราคาไม่ถูกต้อง", comment);
			}
			
			return "ListRequest";
		}	
		

		// Add  FileQuotation By Supplies officer Controller
			@RequestMapping(value="/addQuotationBysupplies", method=RequestMethod.POST)
			public ModelAndView do_addQuotationBysupplies
					(@RequestParam("a_file_quotation") MultipartFile file1,
					@RequestParam("b_file_quotation") MultipartFile file2,
					@RequestParam("c_file_quotation") MultipartFile file3  ,
					HttpServletRequest  request, HttpSession session) throws UnsupportedEncodingException {
			request.setCharacterEncoding("UTF-8");
			String message = ""; 
			OrderRequestManager orm = new OrderRequestManager();
			QuantityManager qm = new QuantityManager();
			FileManager fm = new FileManager();
			ModelAndView mav = new ModelAndView("ListRequest");
			StaffManager sm = new StaffManager();
			OrderRequestManager om = new OrderRequestManager();
			int result =-1;
					try {          
				
						String status  = "กำลังรอการดำเนินการจากหน่วยพัสดุ";
						String request_type =  "มีใบเสนอราคา";
						String comment = "-";
						Calendar c = Calendar.getInstance();
						String username = request.getParameter("username");
						Staff  s = sm.getStaff(username);
						//OrderRequest or = new OrderRequest(orm.getMaxOrderRequestID(),c,status,request_type,comment,s);
						
						//or.setStaff(s);
						
						
						//quotation  1
						String anamecompany = request.getParameter("a_name_company");
						String afilequotation = "Quotation_"+om.getMaxFileID()+"_"+anamecompany+".pdf";
						String anumberquotation = request.getParameter("a_number_quotation");
						String adatequotation = request.getParameter("a_date_quotation");
						
					
						Calendar cal_adatequotation = Calendar.getInstance();
						String pattern = "yyyy-MM-dd";
						SimpleDateFormat sdf = new SimpleDateFormat(pattern);
						cal_adatequotation.setTime(sdf.parse(adatequotation));
						
						File_Quotation fq1 = new File_Quotation(fm.getMaxFilequotationID(),afilequotation,anamecompany,anumberquotation,cal_adatequotation,request_type);
				
						String OrderRequest_id = (String) session.getAttribute("OrderRequest_id");  
						OrderRequest or = new OrderRequest();
						or.setOrderRequest_id(Integer.parseInt(OrderRequest_id) );
						fq1.setOrderRequest(or);
						
						result = fm.insertFileQuotaion(fq1);
						
						//quotation  2
						String bnamecompany = request.getParameter("b_name_company");
						String bfilequotation = "Quotation_"+om.getMaxFileID()+"_"+bnamecompany+".pdf";						
						String bnumberquotation = request.getParameter("b_number_quotation");
						String bdatequotation = request.getParameter("b_date_quotation");
						
						
						Calendar cal_bdatequotation = Calendar.getInstance();
						String pattern2 = "yyyy-MM-dd";
						SimpleDateFormat sdf2 = new SimpleDateFormat(pattern2);
						cal_bdatequotation.setTime(sdf2.parse(bdatequotation));
						
						File_Quotation fq2 = new File_Quotation(fm.getMaxFilequotationID(),bfilequotation,bnamecompany,bnumberquotation,cal_bdatequotation,request_type);
						fq2.setOrderRequest(or);
						result = fm.insertFileQuotaion(fq2);
						
						//quotation  3
						String cnamecompany = request.getParameter("c_name_company");
						String cfilequotation = "Quotation_"+om.getMaxFileID()+"_"+cnamecompany+".pdf";
						String cnumberquotation = request.getParameter("c_number_quotation");
						String cdatequotation = request.getParameter("c_date_quotation");
						
						
						Calendar cal_cdatequotation = Calendar.getInstance();
						String pattern3 = "yyyy-MM-dd";
						SimpleDateFormat sdf3 = new SimpleDateFormat(pattern3);
						cal_cdatequotation.setTime(sdf3.parse(cdatequotation));
						
						File_Quotation fq3 = new File_Quotation(fm.getMaxFilequotationID(),cfilequotation,cnamecompany,cnumberquotation,cal_cdatequotation,request_type);
						fq3.setOrderRequest(or);
						result = fm.insertFileQuotaion(fq3);
						
						if (!file1.isEmpty()) {
						
							byte[] bytes = file1.getBytes();
							String path = request.getServletContext().getRealPath("/")+ "pdf/";

							// Create the file on server
							File serverFile = new File(path + afilequotation);
							BufferedOutputStream stream = new BufferedOutputStream(
									new FileOutputStream(serverFile));
							stream.write(bytes);
							stream.close();
							System.out.println("Server File Location="+ path);

								System.out.println("You successfully uploaded file=" + afilequotation);
						} else {
							System.out.println("You failed to upload " + afilequotation+ " because the file was empty.");
						}    
						if (!file2.isEmpty()) {
							
							byte[] bytes = file2.getBytes();
							String path = request.getServletContext().getRealPath("/")+ "pdf/";

							// Create the file on server
							File serverFile = new File(path + bfilequotation);
							BufferedOutputStream stream = new BufferedOutputStream(
									new FileOutputStream(serverFile));
							stream.write(bytes);
							stream.close();
							System.out.println("Server File Location="+ path);

							System.out.println("You successfully uploaded file=" + bfilequotation);
					} else {
						System.out.println("You failed to upload " + bfilequotation+ " because the file was empty.");
					}    
						if (!file3.isEmpty()) {
							
							byte[] bytes = file3.getBytes();
							String path = request.getServletContext().getRealPath("/")+ "pdf/";

							// Create the file on server
							File serverFile = new File(path + cfilequotation);
							BufferedOutputStream stream = new BufferedOutputStream(
									new FileOutputStream(serverFile));
							stream.write(bytes);
							stream.close();
							System.out.println("Server File Location="+ path);

							System.out.println("You successfully uploaded file=" + cfilequotation);
					} else {
						System.out.println("You failed to upload " + cfilequotation+ " because the file was empty.");
					} 
					
					//update Status OrderRequest
					if(result == 1) {
						orm.updateStatus("รอยืนยันความประสงค์", OrderRequest_id);
						
					}
		
				}catch (Exception e) {
					e.printStackTrace();
					message = "โปรดลองใหม่อีกครั้ง....";
				}
					
					return mav;
			
			}
			
			
			//Edit OrderRequest Quotation Controller by Supplies
			@RequestMapping(value="/EditQuotaionBySupplies", method=RequestMethod.POST)
			public ModelAndView do_EditQuotaionBySupplies
					(@RequestParam("a_file_quotation") MultipartFile file1,
					@RequestParam("b_file_quotation") MultipartFile file2,
					@RequestParam("c_file_quotation") MultipartFile file3  ,
					HttpServletRequest  request, HttpSession session) throws UnsupportedEncodingException {
			request.setCharacterEncoding("UTF-8");
			String message = ""; 
			OrderRequestManager orm = new OrderRequestManager();
			QuantityManager qm = new QuantityManager();
			FileManager fm = new FileManager();
			ModelAndView mav = new ModelAndView("ListRequest");
			StaffManager sm = new StaffManager();
			OrderRequestManager om = new OrderRequestManager();
					try {  
						// orderRequest
						String orderRequest_id  = request.getParameter("OrderRequest_id");
						String request_type =  "ไม่มีใบเสนอราคา";
						String username = request.getParameter("username");
						Staff  s = sm.getStaff(username);
						OrderRequest or = om.OrderRequestByID(orderRequest_id);
						
						or.setStaff(s);
						
						List<File_Quotation> f = fm.getAllQuotation(Integer.parseInt(orderRequest_id));
						//quotation  1
						String anamecompany = request.getParameter("a_name_company");
						String afilequotation = "Quotation_"+f.get(0).getFile_id()+"_"+anamecompany+".pdf";
						String anumberquotation = request.getParameter("a_number_quotation");
						String adatequotation = request.getParameter("a_date_quotation");
						
					
						Calendar cal_adatequotation = Calendar.getInstance();
						String pattern = "yyyy-MM-dd";
						SimpleDateFormat sdf = new SimpleDateFormat(pattern);
						cal_adatequotation.setTime(sdf.parse(adatequotation));
						
						File_Quotation fq1 = new File_Quotation(f.get(0).getFile_id(),afilequotation,anamecompany,anumberquotation,cal_adatequotation,request_type);
				
						fq1.setOrderRequest(or);
						fm.updateFileQuotaion(fq1);
						//quotation  2
						String bnamecompany = request.getParameter("b_name_company");
						String bfilequotation = "Quotation_"+f.get(1).getFile_id()+"_"+bnamecompany+".pdf";
						
						String bnumberquotation = request.getParameter("b_number_quotation");
						String bdatequotation = request.getParameter("b_date_quotation");
						
						
						Calendar cal_bdatequotation = Calendar.getInstance();
						String pattern2 = "yyyy-MM-dd";
						SimpleDateFormat sdf2 = new SimpleDateFormat(pattern2);
						cal_bdatequotation.setTime(sdf2.parse(bdatequotation));
						
						File_Quotation fq2 = new File_Quotation(f.get(1).getFile_id(),bfilequotation,bnamecompany,bnumberquotation,cal_bdatequotation,request_type);
						fq2.setOrderRequest(or);
						fm.updateFileQuotaion(fq2);
						
						//quotation  3
						String cnamecompany = request.getParameter("c_name_company");
						String cfilequotation = "Quotation_"+f.get(2).getFile_id()+"_"+cnamecompany+".pdf";
						String cnumberquotation = request.getParameter("c_number_quotation");
						String cdatequotation = request.getParameter("c_date_quotation");
						
						
						Calendar cal_cdatequotation = Calendar.getInstance();
						String pattern3 = "yyyy-MM-dd";
						SimpleDateFormat sdf3 = new SimpleDateFormat(pattern3);
						cal_cdatequotation.setTime(sdf3.parse(cdatequotation));
						
						File_Quotation fq3 = new File_Quotation(f.get(2).getFile_id(),cfilequotation,cnamecompany,cnumberquotation,cal_cdatequotation,request_type);
						fq3.setOrderRequest(or);
						fm.updateFileQuotaion(fq3);
						//orm.updateStatus("ยืนยันความประสงค์", orderRequest_id);
						orm.updateStatusAndAddComment(orderRequest_id, "ยืนยันความประสงค์", "-");
						
						if (!file1.isEmpty()) {
						
							byte[] bytes = file1.getBytes();
							String path = request.getServletContext().getRealPath("/")+ "pdf/";

							// Create the file on server
							File serverFile = new File(path + afilequotation);
							BufferedOutputStream stream = new BufferedOutputStream(
									new FileOutputStream(serverFile));
							stream.write(bytes);
							stream.close();
							System.out.println("Server File Location="+ path);

								System.out.println("You successfully uploaded file=" + afilequotation);
						} else {
							System.out.println("You failed to upload " + afilequotation+ " because the file was empty.");
						}    
						if (!file2.isEmpty()) {
							
							byte[] bytes = file2.getBytes();
							String path = request.getServletContext().getRealPath("/")+ "pdf/";

							// Create the file on server
							File serverFile = new File(path + bfilequotation);
							BufferedOutputStream stream = new BufferedOutputStream(
									new FileOutputStream(serverFile));
							stream.write(bytes);
							stream.close();
							System.out.println("Server File Location="+ path);

							System.out.println("You successfully uploaded file=" + bfilequotation);
					} else {
						System.out.println("You failed to upload " + bfilequotation+ " because the file was empty.");
					}    
						
						if (!file3.isEmpty()) {
							
							byte[] bytes = file3.getBytes();
							String path = request.getServletContext().getRealPath("/")+ "pdf/";

							// Create the file on server
							File serverFile = new File(path + cfilequotation);
							BufferedOutputStream stream = new BufferedOutputStream(
									new FileOutputStream(serverFile));
							stream.write(bytes);
							stream.close();
							System.out.println("Server File Location="+ path);

							System.out.println("You successfully uploaded file=" + cfilequotation);
					} else {
						System.out.println("You failed to upload " + cfilequotation+ " because the file was empty.");
					}    
				}catch (Exception e) {
					e.printStackTrace();
					message = "โปรดลองใหม่อีกครั้ง....";
				}
					return mav;
			
			
		
			}
}
