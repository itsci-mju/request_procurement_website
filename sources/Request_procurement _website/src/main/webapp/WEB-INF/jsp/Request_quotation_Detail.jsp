<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.*,util.*,java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
request.setCharacterEncoding("UTF-8");	
Login l = (Login) session.getAttribute("login");
String OrderRequest_id = (String) session.getAttribute("OrderRequest_id");    
FileManager fmanager = new FileManager();
OrderRequest order_q = (OrderRequest) session.getAttribute("OrderRequest");
List<File_Quotation> listFile = (List<File_Quotation>) fmanager.getAllQuotation(order_q.getOrderRequest_id()); 
String majorname = (String) session.getAttribute("majorName");   
System.out.println(listFile.toString());


ProductManager pmanager = new ProductManager();
List<Quantity> listProduct = pmanager.getproductdetail(order_q.getOrderRequest_id()); 
double sum = 0.0;

SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>ระบบแจ้งความประสงค์ขอให้จัดซื้อจัดจ้างพัสดุ</title>    
	     <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
		 <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
		 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	   
	   
	     <!-- link css -->
	     <link rel="stylesheet" type="text/css" href="css/layout.css">
	     <link rel="stylesheet" type="text/css" href="css/login.css">
	     <link rel="stylesheet" type="text/css" href="css/footer.css">
		<link href='https://css.gg/file.css' rel='stylesheet'>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	    
	     <link href='https://css.gg/lock.css' rel='stylesheet'>
    	 <link href='https://css.gg/mail.css' rel='stylesheet'>
</head>
<body id="page-top">
        <!-- Navigation -->
       <jsp:include page="common/Navbar.jsp"/>
     
        <!--head-text-->
       	
			<h2 class="page-section-heading text-center text-uppercase text-secondary mb-0" style="font-size: 40px;"><b>รายละเอียดการแจ้งความประสงค์การจัดซื้อจัดจ้าง <span  style="color:#FF884B;">(มีใบเสนอราคา)</span></b></h2>
                 <div class="container product-table" "> 
                        
                                        
                                    <table class="table" id="form_table" style="text-align: center;">
                                   
                                      <thead class="thead-dark">
                                        <tr>
                                            <th>ลำดับที่</th>
				                            <th>ชื่อบริษัท</th>
				                            <th>เลขที่ใบเสนอราคา</th> 
				                            <th>วันที่ใบเสนอราคา</th>
				                            <th>ใบเสนอราคา</th>             
                                        <th></th>
                                        </tr>
                                      </thead>
                                       <% if (listFile != null){%>
                                        <%for (int i=0 ; i<listFile.size(); i++) {%>
                                     <!-- row input -->
                                      <tbody>
                                        <tr class="alert" role="alert">
                                          <th  scope="row"><%= i+1 %></th>
                                          <td style="width: 300px"><%=listFile.get(i).getFile_name() %></td>     
                                          <td> <%=listFile.get(i).getQuotation_no() %> </td>  
                                         <td><%= sdf.format(listFile.get(i).getQuotation_date().getTime() ) %></td>  
                                         <td><a href="./pdf/<%= listFile.get(i).getCompany_name() %>"  ><img width="100" height="200" src="images/pdf.png" /></a></td>  
                                     
                                        </tr>                
                                      </tbody>
                                      	<%} %>
                                      <%} %>
                                      
                                      
                                    </table> 
                                    <% if (order_q.getStatus().equals("ข้อมูลใบเสนอราคาไม่ถูกต้อง")){ %>
                                    <form id="frm" name="frm" action="loadpageAddcommentBySupplise" method="post" >
                                    	 <div>
		                                    <label for="exampleFormControlTextarea1" style="color: red;">*หมายเหตุ : ผู้ใช้สามารถแก้ไขด้วยการอัพโหลดใบเสนอราคาใหม่ได้*</label>
					                    </div>
	                                    <div>
		                                    <label for="exampleFormControlTextarea1">คำเสนอแนะ</label>
		                                    <label for="exampleFormControlTextarea1" style="color: red;">: <%= order_q.getComment() %></label>
					                    </div>
	                                    </form>
                                     <%} %>
                                    
                                  <div> 
			          			<!-- Button link-->
			                    <a class="" href="loadpagelistorder"  style=" margin-left: 37%;">
			                     <button   style="  margin-top: 15px; width: 25%" type="button" class="btn btn-dark">ย้อนกลับ</button>         
			              		</a>
                                    </div>
                                    
                                    	
                        
					</div>
             
         <br><br><br>
         <br><br><br>
                <!-- Footer -->
      <div>    <jsp:include page="common/footer.jsp"/>       </div>

	<!-- script link -->
  	<script src="layout/scripts/jquery.min.js"></script>
	<script src="layout/scripts/jquery.backtotop.js"></script>
	<script src="layout/scripts/jquery.mobilemenu.js"></script>
    </body>
</html>
