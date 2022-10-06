package com.springmvc.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.protobuf.TextFormat.ParseException;

import bean.*;

import util.ConnectionDB;
import util.FileManager;

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
	public String loadtListOrderPage() {
		return "ListRequest";
	}
	
	//โหลดหน้ารายการรายละเอียดข้อมูลการแจ้งแบบไม่มีใบเสนอราคา
		@RequestMapping(value = "/loadRequestDetail", method = RequestMethod.GET)
		public String loadRequestDetailPage() {
			return "RequestDetail";
		}
		
	
	
	//Controller OrderRequest Product
	@RequestMapping(value="/addOrderRequest", method=RequestMethod.POST)
	public ModelAndView do_addOrderRequest(HttpServletRequest  request, HttpSession session) throws UnsupportedEncodingException {
	request.setCharacterEncoding("UTF-8");
	// Product mb = (Product) session.getAttribute(""); 
		String message = ""; 
		OrderRequestManager orm = new OrderRequestManager();
		QuantityManager qm = new QuantityManager();
		ModelAndView mav = new ModelAndView("Requestproduct");
		StaffManager sm = new StaffManager();
			try {          
			//	String chList = request.getParameter("chList");
				String status  = "กำลังรอการดำเนินการจากหน่วยพันสดุ";
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
		ModelAndView mav = new ModelAndView("Requestquotation");
		StaffManager sm = new StaffManager();
				try {          
			
					String status  = "กำลังรอการดำเนินการจากหน่วยพันสดุ";
					String request_type =  "มีใบเสนอราคา";
					String comment = "-";
					Calendar c = Calendar.getInstance();
					String username = request.getParameter("username");
					Staff  s = sm.getStaff(username);
					OrderRequest or = new OrderRequest(orm.getMaxOrderRequestID(),c,status,request_type,comment,s);
					
					or.setStaff(s);
					orm.insertOrderRequest2(or);
					
					//quotation  1
					String afilequotation = request.getParameter("a_file_quotation");
					String anamecompany = request.getParameter("a_name_company");
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
					String bfilequotation = request.getParameter("b_file_quotation");
					String bnamecompany = request.getParameter("b_name_company");
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
					String cfilequotation = request.getParameter("c_file_quotation");
					String cnamecompany = request.getParameter("c_name_company");
					String cnumberquotation = request.getParameter("c_number_quotation");
					String cdatequotation = request.getParameter("c_date_quotation");
					
					
					Calendar cal_cdatequotation = Calendar.getInstance();
					String pattern3 = "yyyy-MM-dd";
					SimpleDateFormat sdf3 = new SimpleDateFormat(pattern3);
					cal_bdatequotation.setTime(sdf3.parse(bdatequotation));
					
					File_Quotation fq3 = new File_Quotation(fm.getMaxFilequotationID(),cfilequotation,cnamecompany,cnumberquotation,cal_cdatequotation,request_type);
					fq3.setOrderRequest(or);
					fm.insertFileQuotaion(fq3);
					
					String insertfile = "";
			        
			            MultipartFile file = file1;
			            String name = afilequotation;
			            
			                byte[] bytes = file.getBytes();

			                // Creating the directory to store file
			                String rootPath = System.getProperty("catalina.home");
			                File dir = new File(rootPath + File.separator + "tmpFiles");
			                if (!dir.exists())
			                    dir.mkdirs();

			                // Create the file on server
			                File serverFile = new File(dir.getAbsolutePath()
			                        + File.separator + name);
			                BufferedOutputStream stream = new BufferedOutputStream(
			                        new FileOutputStream(serverFile));
			                stream.write(bytes);
			                stream.close();

			               System.out.println("Server File Location="
			                        + serverFile.getAbsolutePath());

			                insertfile = insertfile + "You successfully uploaded file=" + name
			                        + "<br />";        
			}catch (Exception e) {
				e.printStackTrace();
				message = "โปรดลองใหม่อีกครั้ง....";
			}
				return mav;
		
		}
	

	/*
	//OrderRequest & fileQuotation
	@RequestMapping(value="/insertOrderRequest", method=RequestMethod.POST)
	public ModelAndView do_register(HttpServletRequest  request, HttpSession session) throws UnsupportedEncodingException {
		request.setCharacterEncoding("UTF-8");
		Lecturer lc = (Lecturer) session.getAttribute("lecturer");
		OrderRequestManager orm = new OrderRequestManager();
		String message = null;
		//OrderRequest or = new OrderRequest();
		ModelAndView mav = new ModelAndView("insertOrderRequest");
			try {          
				
				//String orderRequest_id = request.getParameter("orderRequest_id");
				String orderRequest_date = request.getParameter("orderRequest_date");
				String status = request.getParameter("status");
				String request_type = "มีใบเสนอราคา";
				String comment = request.getParameter("comment");
				
				Calendar calorderRequest_date = Calendar.getInstance();
				String pattern = "yyyy/MM/dd";
				SimpleDateFormat sdf = new SimpleDateFormat(pattern);
				calorderRequest_date.setTime(sdf.parse(orderRequest_date));
			//	OrderRequest or = new OrderRequest(orm.getMaxOrderRequestID(),calorderRequest_date,status,request_type,comment);
				
				int r = orm.insertOrderRequest(new OrderRequest(orm.getMaxOrderRequestID(),calorderRequest_date,status,request_type,comment));
				if (r == 1) {
					for (int i=1;i<=3;i++) {
						FileManager fm = new FileManager();
						
						String anamecompany = request.getParameter("a-name-company");
						String anumberquotation = request.getParameter("a-number-quotation");
						String adatequotation = request.getParameter("a-date-quotation");
						String afilequotation = request.getParameter("a-file-quotation");
						
						String bnamecompany = request.getParameter("b-name-company");
						String bnumberquotation = request.getParameter("b-number-quotation");
						String bdatequotation = request.getParameter("b-date-quotation");
						String bfilequotation = request.getParameter("b-file-quotation");
						
						String cnamecompany = request.getParameter("c-name-company");
						String cnumberquotation = request.getParameter("c-number-quotation");
						String cdatequotation = request.getParameter("c-date-quotation");
						String cfilequotation = request.getParameter("c-file-quotation");
						
					
						Calendar caldate1 = Calendar.getInstance();
						Calendar caldate2 = Calendar.getInstance();
						Calendar caldate3 = Calendar.getInstance();
						
						String pattern2 = "yyyy/MM/dd";
						SimpleDateFormat sdf2 = new SimpleDateFormat(pattern2);
						try {
							caldate1.setTime(sdf.parse(adatequotation));
							caldate2.setTime(sdf.parse(bdatequotation));
							caldate3.setTime(sdf.parse(cdatequotation));
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					
				int a = fm.insertFileQuotaion(new File_Quotation(fm.getMaxFilequotationID(),afilequotation,anamecompany,anumberquotation,caldate1,""));
				
				
					}
					
				}
				
		}catch (Exception e) {
			e.printStackTrace();
			message = "โปรดลองใหม่อีกครั้ง....";
		}
	
		mav.addObject("message", message); 
		return mav; 
	}
	*/
	
}

