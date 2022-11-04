package com.springmvc.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import bean.Login;
import bean.Staff;
import util.LoginManager;
import util.StaffManager;

@Controller
public class LoginController {

	public LoginController() {
		// TODO Auto-generated constructor stub
	}

	//load Error
	@RequestMapping(value = "/loaderror", method = RequestMethod.GET)
	public String loaderrorPage() {
		return "error";
	}
	
	//load Login page
	@RequestMapping(value = "/loadlogin", method = RequestMethod.GET)
	public String loadLoginPage() {
		return "login";
	}
	
	//Login Controller & sent session data
	  @RequestMapping(value = "/login", method = RequestMethod.POST) 
		  public String  doLogin1(HttpServletRequest request, Model md, HttpSession session) { 
		  String uname = request.getParameter("uname"); 
		  String pwd = request.getParameter("pwd");
		  LoginManager lm = new LoginManager();
		  StaffManager sm = new StaffManager();
		  Login l = null;
		  l = lm.verifyLogin( new Login(uname, pwd,""));
		 
		  if (l != null) { 
			  Staff s = sm.getStaff(l.getUsername());
			  md.addAttribute("user", l.getUsername());
			  session.setMaxInactiveInterval(60 * 60);
			  session.setAttribute("login", l);
			  session.setAttribute("username", l.getUsername());
			  session.setAttribute("major", String.valueOf(s.getMajor().getMajor_id()));
			  session.setAttribute("majorName", s.getMajor().getMajor_name());
			  session.setAttribute("staffname", s.getStaff_name());
			  if(s.getMajor().getMajor_id()==0){
				  return "ListRequest"; 
				  
			  }else {
			  return "ListRequest"; 
			  }
		}else  {
			  session.setAttribute("login", "ชื่อผู้ใช้หรือรหัสไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง");
			  return  "login";
		} 
		  
	  }
	  
	  
	//Logout
	  @RequestMapping(value = "/logout", method = RequestMethod.GET) 
	  public String  doLogout(HttpSession session) { 
		  session.removeAttribute("login");
		  session.removeAttribute("user");
		  
		  return  "login";
	  }
	    
	
	}



