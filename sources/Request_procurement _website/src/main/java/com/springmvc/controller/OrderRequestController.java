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
	//โหลดหน้าหลัก 
	@RequestMapping(value = "/loadindex", method = RequestMethod.GET)
	public String loadthomePage() {
		
		return "index";
	}
	//โหลดหน้าแจ้งความประสงค์แบบไม่มีใบเสนอราคา
	@RequestMapping(value = "/loadpageorder1", method = RequestMethod.GET)
	public String loadtRequestproductPage() {
		return "Requestproduct";
	}
	//โหลดหน้าแจ้งความประสงค์แบบมีใบเสนอราคา
	@RequestMapping(value = "/loadpageorder2", method = RequestMethod.GET)
	public String loadtRequestquotationPage() {
		return "Requestquotation";
	}
	
	//โหลดหน้ารายการทั้งหมดที่แจ้งความประสงค์
	@RequestMapping(value = "/loadpagelistorder", method = RequestMethod.GET)
	public String loadtListOrderPage(HttpServletRequest request, Model md, HttpSession session) throws UnsupportedEncodingException {
		request.setCharacterEncoding("UTF-8");	
	
		return "ListRequest";
	}
	
	//โหลดหน้ายืนยันการแจ้งความประสงค์
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
		
	//โหลดหน้ารายการทั้งหมดที่แจ้งความประสงค์
	@RequestMapping(value = "/loadpagelistrequestHistory", method = RequestMethod.GET)
	public String loadtListRequestHistory(HttpServletRequest request, Model md, HttpSession session) {
	
		return "ListRequest_History";
	}	
	
	
	//โหลดหน้าแก้ไขรายการแจ้งความประสงค์
		@RequestMapping(value = "/loadEditRequestproduct", method = RequestMethod.GET)
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
		
	
	
	//โหลดหน้ารายการรายละเอียดข้อมูลการแจ้งความประสงค์
		@RequestMapping(value = "/loadRequestDetail", method = RequestMethod.GET)
		public String loadRequestDetailPage(HttpServletRequest request, Model md, HttpSession session) throws java.text.ParseException {
			
		String Text_OrderRequest_id = request.getParameter("OrderRequest_id");
		String request_type = request.getParameter("request_type");
		int OrderRequest_id = Integer.parseInt(Text_OrderRequest_id);
		System.out.println(request_type);
		OrderRequestManager orm = new OrderRequestManager();
			OrderRequest order_r = orm.OrderRequestByID(Text_OrderRequest_id);
			session.setAttribute("OrderRequest", order_r);	
			
			if(request_type.trim().equals("ไม่มีใบเสนอราคา")) {
				return "RequestDetail";
			}else {
				return "Request_quotation_Detail";
			}
			
			
		}
		
		
	//Controller OrderRequest Product
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
			//	String chList = request.getParameter("chList");
				String status  = "กำลังรอการดำเนินการจากหน่วยพัสดุ";
				String request_type =  "ไม่มีใบเสนอราคา";
				String comment = "-";
				Calendar c = Calendar.getInstance();
				String username = request.getParameter("username");
				Staff  s = sm.getStaff(username);
				OrderRequest or = new OrderRequest(orm.getMaxOrderRequestID(),c,status,request_type,comment,s);
				
				or.setStaff(s);
				orm.insertOrderRequest2(or);
				
			//	Quantity_Pk qpk = new Quantity_Pk();
			//	qpk.setOrderRequest_pk(or);
				int number = Integer.parseInt(request.getParameter("number"));
		
				ArrayList<Integer> pid = new ArrayList<Integer>();
			//	System.out.println(number);
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
				System.out.println(product);
				System.out.println(qty);
				
				//List<Product> pd = pm.listAllProducts();
				
				for(int j=0;j<product.size();j++) {
					Product p = new Product();
					p.setProduct_id(pid.get(j));
					Quantity q = new Quantity(qty.get(j),total.get(j),or,p);
					
					qm.insertQuantity(q);
				}
				/*
				double total = 0;
					for (int j=0;j< pm.listAllProducts().size()-1;j++) {
						if(pm.listAllProducts().get(j).getProduct_detail().equals(product)) {
							int Product_id = pm.listAllProducts().get(j).getProduct_id();
							String Product_detail = pm.listAllProducts().get(j).getProduct_detail();
							String Unit =  pm.listAllProducts().get(j).getUnit();
							String Type =  pm.listAllProducts().get(j).getType();
							double Price =  pm.listAllProducts().get(j).getPrice();
							
							Product p = new Product(Product_id,Product_detail,Unit,Type,Price);
							qpk.setProduct_pk(p);
							double price = pm.listAllProducts().get(j).getPrice();
							total = price*qty;
							System.out.println(total);
							Quantity q = new Quantity(qty,total,qpk);
							qm.insertQuantity(q);
						}
					}		
				}*/
		}catch (Exception e) {
			e.printStackTrace();
			message = "โปรดลองใหม่อีกครั้ง....";
		}
			return mav;
	}
	
	

	//Controller OrderRequest FileQuotation
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
					String afilequotation = "ใบเสนอราคา_"+om.getMaxFileID()+"_"+anamecompany+".pdf";
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
					String bfilequotation = "ใบเสนอราคา_"+om.getMaxFileID()+"_"+bnamecompany+".pdf";
					
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
					String cfilequotation = "ใบเสนอราคา_"+om.getMaxFileID()+"_"+cnamecompany+".pdf";
					String cnumberquotation = request.getParameter("c_number_quotation");
					String cdatequotation = request.getParameter("c_date_quotation");
					
					
					Calendar cal_cdatequotation = Calendar.getInstance();
					String pattern3 = "yyyy-MM-dd";
					SimpleDateFormat sdf3 = new SimpleDateFormat(pattern3);
					cal_bdatequotation.setTime(sdf3.parse(bdatequotation));
					
					File_Quotation fq3 = new File_Quotation(fm.getMaxFilequotationID(),cfilequotation,cnamecompany,cnumberquotation,cal_cdatequotation,request_type);
					fq3.setOrderRequest(or);
					fm.insertFileQuotaion(fq3);
					
					if (!file1.isEmpty()) {
					
							byte[] bytes = file1.getBytes();

							// Creating the directory to store file
							String rootPath = System.getProperty("catalina.home");
							File dir = new File(rootPath + File.separator + "tmpFiles");
							if (!dir.exists())
								dir.mkdirs();

							// Create the file on server
							File serverFile = new File(dir.getAbsolutePath()
									+ File.separator + afilequotation);
							BufferedOutputStream stream = new BufferedOutputStream(
									new FileOutputStream(serverFile));
							stream.write(bytes);
							stream.close();
							System.out.println("Server File Location="+ serverFile.getAbsolutePath());

							System.out.println("You successfully uploaded file=" + afilequotation);
					} else {
						System.out.println("You failed to upload " + afilequotation+ " because the file was empty.");
					}    
					if (!file2.isEmpty()) {
						
						byte[] bytes = file2.getBytes();

						// Creating the directory to store file
						String rootPath = System.getProperty("catalina.home");
						File dir = new File(rootPath + File.separator + "tmpFiles");
						if (!dir.exists())
							dir.mkdirs();
							
						// Create the file on server
						File serverFile = new File(dir.getAbsolutePath()
								+ File.separator + bfilequotation);
						BufferedOutputStream stream = new BufferedOutputStream(
								new FileOutputStream(serverFile));
						stream.write(bytes);
						stream.close();
						System.out.println("Server File Location="+ serverFile.getAbsolutePath());

						System.out.println("You successfully uploaded file=" + bfilequotation);
				} else {
					System.out.println("You failed to upload " + bfilequotation+ " because the file was empty.");
				}    
					if (!file3.isEmpty()) {
						
						byte[] bytes = file3.getBytes();

						// Creating the directory to store file
						String rootPath = System.getProperty("catalina.home");
						File dir = new File(rootPath + File.separator + "tmpFiles");
						if (!dir.exists())
							dir.mkdirs();

						// Create the file on server
						File serverFile = new File(dir.getAbsolutePath()
								+ File.separator + cfilequotation);
						BufferedOutputStream stream = new BufferedOutputStream(
								new FileOutputStream(serverFile));
						stream.write(bytes);
						stream.close();
						System.out.println("Server File Location="+ serverFile.getAbsolutePath());

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
		
		@RequestMapping(value = "/pdf", method=RequestMethod.GET)
		  public void showPdf(HttpServletResponse response, HttpServletRequest request) throws IOException {
				request.setCharacterEncoding("UTF-8");
				String filename = request.getParameter("filename");
				String path = "E:/apache-tomcat-9.0.62/tmpFiles/";
				response.setContentType("application/pdf");
			    
			    
				response.setHeader("Content-Disposition","inline; filename="+filename+"");
			    
				InputStream inputStream = new FileInputStream(new File(path+filename));
			    int nRead;
			    while ((nRead = inputStream.read()) != -1) {
			        response.getWriter().write(nRead);
			    }
			   
			    inputStream.close();
			   
			  
			    
		  } 
		
		
		//Controller Edit OrderRequest Product
		@RequestMapping(value="/EditOrderRequestProduct", method=RequestMethod.POST)
		public ModelAndView do_EditOrderRequestProduct(HttpServletRequest  request, HttpSession session) throws UnsupportedEncodingException {
		request.setCharacterEncoding("UTF-8");
		// Product mb = (Product) session.getAttribute(""); 
			String message = ""; 
			ModelAndView mav = new ModelAndView("ListRequest");
				try {          
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
						 total.add(Double.parseDouble(request.getParameter("tt"+(i+1)))) ;
						 product.add(request.getParameter("p"+(i+1)));
						 pid.add(Integer.parseInt(request.getParameter("id"+(i+1)).trim())) ;
						}
					}
					System.out.println(product);
					System.out.println(qty);
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
		
		//Controller Edit OrderRequest Quotation
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
					String orderRequest_id  = request.getParameter("OrderRequest_id");
					String request_type =  "มีใบเสนอราคา";
					String username = request.getParameter("username");
					Staff  s = sm.getStaff(username);
					OrderRequest or = om.OrderRequestByID(orderRequest_id);
					
					or.setStaff(s);
					
					List<File_Quotation> f = fm.getAllQuotation(Integer.parseInt(orderRequest_id));
					//quotation  1
					String anamecompany = request.getParameter("a_name_company");
					String afilequotation = "ใบเสนอราคา_"+f.get(0).getFile_id()+"_"+anamecompany+".pdf";
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
					String bfilequotation = "ใบเสนอราคา_"+f.get(1).getFile_id()+"_"+bnamecompany+".pdf";
					
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
					String cfilequotation = "ใบเสนอราคา_"+f.get(2).getFile_id()+"_"+cnamecompany+".pdf";
					String cnumberquotation = request.getParameter("c_number_quotation");
					String cdatequotation = request.getParameter("c_date_quotation");
					
					
					Calendar cal_cdatequotation = Calendar.getInstance();
					String pattern3 = "yyyy-MM-dd";
					SimpleDateFormat sdf3 = new SimpleDateFormat(pattern3);
					cal_cdatequotation.setTime(sdf3.parse(cdatequotation));
					
					File_Quotation fq3 = new File_Quotation(f.get(2).getFile_id(),cfilequotation,cnamecompany,cnumberquotation,cal_cdatequotation,request_type);
					fq3.setOrderRequest(or);
					fm.updateFileQuotaion(fq3);
					orm.updateStatus("กำลังรอการดำเนินการจากหน่วยพัสดุ", orderRequest_id);
					
					if (!file1.isEmpty()) {
					
							byte[] bytes = file1.getBytes();

							// Creating the directory to store file
							String rootPath = System.getProperty("catalina.home");
							File dir = new File(rootPath + File.separator + "tmpFiles");
							if (!dir.exists())
								dir.mkdirs();

							// Create the file on server
							File serverFile = new File(dir.getAbsolutePath()
									+ File.separator + afilequotation);
							BufferedOutputStream stream = new BufferedOutputStream(
									new FileOutputStream(serverFile));
							stream.write(bytes);
							stream.close();
							System.out.println("Server File Location="+ serverFile.getAbsolutePath());

							System.out.println("You successfully uploaded file=" + afilequotation);
					} else {
						System.out.println("You failed to upload " + afilequotation+ " because the file was empty.");
					}    
					if (!file2.isEmpty()) {
						
						byte[] bytes = file2.getBytes();

						// Creating the directory to store file
						String rootPath = System.getProperty("catalina.home");
						File dir = new File(rootPath + File.separator + "tmpFiles");
						if (!dir.exists())
							dir.mkdirs();
							
						// Create the file on server
						File serverFile = new File(dir.getAbsolutePath()
								+ File.separator + bfilequotation);
						BufferedOutputStream stream = new BufferedOutputStream(
								new FileOutputStream(serverFile));
						stream.write(bytes);
						stream.close();
						System.out.println("Server File Location="+ serverFile.getAbsolutePath());

						System.out.println("You successfully uploaded file=" + bfilequotation);
				} else {
					System.out.println("You failed to upload " + bfilequotation+ " because the file was empty.");
				}    
					
					if (!file3.isEmpty()) {
						
						byte[] bytes = file3.getBytes();

						// Creating the directory to store file
						String rootPath = System.getProperty("catalina.home");
						File dir = new File(rootPath + File.separator + "tmpFiles");
						if (!dir.exists())
							dir.mkdirs();

						// Create the file on server
						File serverFile = new File(dir.getAbsolutePath()
								+ File.separator + cfilequotation);
						BufferedOutputStream stream = new BufferedOutputStream(
								new FileOutputStream(serverFile));
						stream.write(bytes);
						stream.close();
						System.out.println("Server File Location="+ serverFile.getAbsolutePath());

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
		
		
	
		
		
		
//-----------------------------------------------------supplies officer--------------------------------
		
		//โหลดหน้าเพิ่มใบเสนอราคา
		@RequestMapping(value = "/loadpageAddQuotation", method = RequestMethod.GET)
		public String loadtAddQuotationPage(HttpServletRequest  request, HttpSession session) {
			String OrderRequest_id = request.getParameter("OrderRequest_id");
			session.setAttribute("OrderRequest_id", OrderRequest_id);	
			return "Addquotation";
		}
		
		//โหลดหน้ารายการทั้งหมดที่แจ้งความประสงค์
		@RequestMapping(value = "/loadpageQuotationDetailBySupplise", method = RequestMethod.GET)
		public String loadtQuotationDetailBySupplise(HttpServletRequest request, Model md, HttpSession session) throws java.text.ParseException {

			String OrderRequest_id = request.getParameter("OrderRequest_id");
			String request_type = request.getParameter("request_type");
			
			OrderRequestManager orm = new OrderRequestManager();
			OrderRequest order_r = orm.OrderRequestByID(OrderRequest_id);
			session.setAttribute("OrderRequest", order_r);	
			
			return "Quotation_Detail_BySupplies";
		}	
		
		//comment
		@RequestMapping(value = "/loadpageAddcommentBySupplise", method = RequestMethod.POST)
		public String loadtAddcommentBySupplise(HttpServletRequest request, Model md, HttpSession session) throws java.text.ParseException {
			
			String OrderRequest_id = request.getParameter("OrderRequest_id");
			String quotation_check = request.getParameter("quotation_check");
			String comment = request.getParameter("comment");
			OrderRequestManager orm = new OrderRequestManager();
			
			if(quotation_check.equals("1")) {
				orm.updateStatus("ยืนยันความประสงค์",OrderRequest_id);
			}else if(quotation_check.equals("2")) {
				orm.updateStatusAndAddComment(OrderRequest_id, "ข้อมูลความประสงค์ไม่ถูกต้อง", comment);
			}
			
			return "ListRequest";
		}	
		

		//Controller OrderRequest FileQuotation
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
						String afilequotation = "ใบเสนอราคา_"+om.getMaxFileID()+"_"+anamecompany+".pdf";
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
						String bfilequotation = "ใบเสนอราคา_"+om.getMaxFileID()+"_"+bnamecompany+".pdf";
						
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
						String cfilequotation = "ใบเสนอราคา_"+om.getMaxFileID()+"_"+cnamecompany+".pdf";
						String cnumberquotation = request.getParameter("c_number_quotation");
						String cdatequotation = request.getParameter("c_date_quotation");
						
						
						Calendar cal_cdatequotation = Calendar.getInstance();
						String pattern3 = "yyyy-MM-dd";
						SimpleDateFormat sdf3 = new SimpleDateFormat(pattern3);
						cal_bdatequotation.setTime(sdf3.parse(bdatequotation));
						
						File_Quotation fq3 = new File_Quotation(fm.getMaxFilequotationID(),cfilequotation,cnamecompany,cnumberquotation,cal_cdatequotation,request_type);
						fq3.setOrderRequest(or);
						result = fm.insertFileQuotaion(fq3);
						
						if (!file1.isEmpty()) {
						
								byte[] bytes = file1.getBytes();

								// Creating the directory to store file
								String rootPath = System.getProperty("catalina.home");
								File dir = new File(rootPath + File.separator + "tmpFiles");
								if (!dir.exists())
									dir.mkdirs();

								// Create the file on server
								File serverFile = new File(dir.getAbsolutePath()
										+ File.separator + afilequotation);
								BufferedOutputStream stream = new BufferedOutputStream(
										new FileOutputStream(serverFile));
								stream.write(bytes);
								stream.close();
								System.out.println("Server File Location="+ serverFile.getAbsolutePath());

								System.out.println("You successfully uploaded file=" + afilequotation);
						} else {
							System.out.println("You failed to upload " + afilequotation+ " because the file was empty.");
						}    
						if (!file2.isEmpty()) {
							
							byte[] bytes = file2.getBytes();

							// Creating the directory to store file
							String rootPath = System.getProperty("catalina.home");
							File dir = new File(rootPath + File.separator + "tmpFiles");
							if (!dir.exists())
								dir.mkdirs();
								
							// Create the file on server
							File serverFile = new File(dir.getAbsolutePath()
									+ File.separator + bfilequotation);
							BufferedOutputStream stream = new BufferedOutputStream(
									new FileOutputStream(serverFile));
							stream.write(bytes);
							stream.close();
							System.out.println("Server File Location="+ serverFile.getAbsolutePath());

							System.out.println("You successfully uploaded file=" + bfilequotation);
					} else {
						System.out.println("You failed to upload " + bfilequotation+ " because the file was empty.");
					}    
						if (!file3.isEmpty()) {
							
							byte[] bytes = file3.getBytes();

							// Creating the directory to store file
							String rootPath = System.getProperty("catalina.home");
							File dir = new File(rootPath + File.separator + "tmpFiles");
							if (!dir.exists())
								dir.mkdirs();

							// Create the file on server
							File serverFile = new File(dir.getAbsolutePath()
									+ File.separator + cfilequotation);
							BufferedOutputStream stream = new BufferedOutputStream(
									new FileOutputStream(serverFile));
							stream.write(bytes);
							stream.close();
							System.out.println("Server File Location="+ serverFile.getAbsolutePath());

							System.out.println("You successfully uploaded file=" + cfilequotation);
					} else {
						System.out.println("You failed to upload " + cfilequotation+ " because the file was empty.");
					} 
					
					//update Status OrderRequest
					if(result == 1) {
						orm.updateStatus("รอยืนยันความประสงค์", OrderRequest_id);
						orm.updateType(OrderRequest_id);
					}
						
					
					
				}catch (Exception e) {
					e.printStackTrace();
					message = "โปรดลองใหม่อีกครั้ง....";
				}
					
					return mav;
			
			}
			
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
				
				ConfirmForm cf = new ConfirmForm(orm.getMaxConfirmFormID(),confirm_date,money_type,necessity_type,chairman_Board_name,board_name1,board_name2,or);
				
				
				orm.insertConfirmForm(cf);
				orm.updateStatus("ยืนยันความประสงค์สำเร็จ", OrderRequest_id);
				
				
				return mav;
			}
}
