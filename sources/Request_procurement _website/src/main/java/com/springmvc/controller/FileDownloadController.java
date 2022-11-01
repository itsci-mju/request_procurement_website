package com.springmvc.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/download")
public class FileDownloadController 	
{
  @RequestMapping("/pdf/{fileName:.+}")
  public void downloadPDFResource( HttpServletRequest request, 
                   HttpServletResponse response, 
                   @PathVariable("fileName") String fileName) 
  {
    //If user is not authorized - he should be thrown out from here itself
     
    //Authorized user will download the file
    String dataDirectory = request.getServletContext().getRealPath("/WEB-INF/downloads/pdf/");
    Path file = Paths.get(dataDirectory, fileName);
    if (Files.exists(file)) 
    {
      response.setContentType("application/pdf");
      response.addHeader("Content-Disposition", "attachment; filename="+fileName);
      try
      {
        Files.copy(file, response.getOutputStream());
        response.getOutputStream().flush();
      } 
      catch (IOException ex) {
        ex.printStackTrace();
      }
    }
  }
  
  
  
}