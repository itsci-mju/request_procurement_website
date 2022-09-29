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
import util.LoginManager;
import util.StaffManager;

@Controller
public class StaffController {

	public StaffController() {
		// TODO Auto-generated constructor stub
		
	}
	/*
	@RequestMapping(value = "/loadStaff", method = RequestMethod.GET)
	public String loadKidprofilePage(HttpServletRequest request, HttpSession session) {
		
		Login l = (Login) session.getAttribute("login");
		String username = l.getUsername();
		StaffManager sm = new StaffManager();
		sm.getStaff(username);
		
		
		String kid = mb.getUsername();
		list = k.getAllKid(kid);
		
		request.setAttribute("listKid", list);
		session.setAttribute("listKid", list);
		return "KidProfile";
	}
	*/
 
}

