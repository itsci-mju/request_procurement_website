package com.springmvc.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
	//Controller read file 
	@RequestMapping(value = "/pdf", method=RequestMethod.GET)
	  public void showPdf(HttpServletResponse response, HttpServletRequest request) throws IOException {
			request.setCharacterEncoding("UTF-8");
			String filename = request.getParameter("filename");
			String path = request.getServletContext().getRealPath("/")+ "pdf/";
			response.setContentType("application/pdf");
			response.setHeader("Content-Disposition", "inline; filename=" + filename);
		    System.out.println(path+filename);
		    
			InputStream inputStream = new FileInputStream(new File(path+filename));
		    int nRead;
		    while ((nRead = inputStream.read()) != -1) {
		        response.getWriter().write(nRead);
		    }	  
	  } 

}
