<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.*,util.*,java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
OrderRequestManager qm = new OrderRequestManager();
StaffManager sm = new StaffManager();
Login l = (Login) session.getAttribute("login");
String major = (String) session.getAttribute("major");     
List<OrderRequest> listorderRequest = qm.getAllListOrderRequest(major);
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
String status1 = "รอยืนยันความประสงค์";
String status2 = "ยืนยันความประสงค์";
int a = 0;
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

    
    <link href='https://css.gg/lock.css' rel='stylesheet'>
    <link href='https://css.gg/mail.css' rel='stylesheet'>
       <!-- css icon listRequest -->
    <link href='https://css.gg/chevron-right.css' rel='stylesheet'>
    <link href='https://css.gg/eye.css' rel='stylesheet'>
    <link href='https://css.gg/thermometer.css' rel='stylesheet'>
    <link href='https://css.gg/backspace.css' rel='stylesheet'>
    <link href='https://css.gg/check.css' rel='stylesheet'>
    <link href='https://css.gg/search-found.css' rel='stylesheet'>
    <link href='https://css.gg/check-o.css' rel='stylesheet'>
<style>
.product-table{
 max-height:1500px ;

 overflow:scroll;
 overflow-x:hidden;
 padding-top:0;
}

/*button view*/
.button-17 {
  align-items: center; 
  appearance: none;
  background-color: #017f3f;
  border-radius: 24px;
  border-style: none;
  box-shadow: rgba(0, 0, 0, .2) 0 3px 5px -1px,rgba(0, 0, 0, .14) 0 6px 10px 0,rgba(0, 0, 0, .12) 0 1px 18px 0;
  box-sizing: border-box;
  color: #fff;
  cursor: pointer;
  display: inline-flex;
  fill: currentcolor;
  font-size: 14px;
  font-weight: 500;
  height: 34px;
  justify-content: center;
  letter-spacing: .25px;
  line-height: normal;
  max-width: 100%;
  overflow: visible;
  padding: 2px 24px;
  position: relative;
  text-align: center;
  text-transform: none;
  transition: box-shadow 280ms cubic-bezier(.4, 0, .2, 1),opacity 15ms linear 30ms,transform 270ms cubic-bezier(0, 0, .2, 1) 0ms;
  user-select: none;
  -webkit-user-select: none;
  touch-action: manipulation;
  width: auto;
  will-change: transform,opacity;
  z-index: 0;
}

.button-17:hover {
  background: #F6F9FE;
  color: #174ea6;
}

.button-17:active {
  box-shadow: 0 4px 4px 0 rgb(60 64 67 / 30%), 0 8px 12px 6px rgb(60 64 67 / 15%);
  outline: none;
}

.button-17:focus {
  outline: none;
  border: 2px solid #4285f4;
}

.button-17:not(:disabled) {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

.button-17:not(:disabled):hover {
  box-shadow: rgba(60, 64, 67, .3) 0 2px 3px 0, rgba(60, 64, 67, .15) 0 6px 10px 4px;
}

.button-17:not(:disabled):focus {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

.button-17:not(:disabled):active {
  box-shadow: rgba(60, 64, 67, .3) 0 4px 4px 0, rgba(60, 64, 67, .15) 0 8px 12px 6px;
}

.button-17:disabled {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

/*button edit*/
.button-18 {
  align-items: center;
  appearance: none;
  background-color: #ffc107;
  border-radius: 24px;
  border-style: none;
  box-shadow: rgba(0, 0, 0, .2) 0 3px 5px -1px,rgba(0, 0, 0, .14) 0 6px 10px 0,rgba(0, 0, 0, .12) 0 1px 18px 0;
  box-sizing: border-box;
  color: #fff;
  cursor: pointer;
  display: inline-flex;
  fill: currentcolor;
  font-size: 14px;
  font-weight: 500;
  height: 34px;
  justify-content: center;
  letter-spacing: .25px;
  line-height: normal;
  max-width: 100%;
  overflow: visible;
  padding: 2px 24px;
  position: relative;
  text-align: center;
  text-transform: none;
  transition: box-shadow 280ms cubic-bezier(.4, 0, .2, 1),opacity 15ms linear 30ms,transform 270ms cubic-bezier(0, 0, .2, 1) 0ms;
  user-select: none;
  -webkit-user-select: none;
  touch-action: manipulation;
  width: auto;
  will-change: transform,opacity;
  z-index: 0;
}

.button-18:hover {
  background: #F6F9FE;
  color: #174ea6;
}

.button-18:active {
  box-shadow: 0 4px 4px 0 rgb(60 64 67 / 30%), 0 8px 12px 6px rgb(60 64 67 / 15%);
  outline: none;
}

.button-18:focus {
  outline: none;
  border: 2px solid #4285f4;
}

.button-18:not(:disabled) {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

.button-18:not(:disabled):hover {
  box-shadow: rgba(60, 64, 67, .3) 0 2px 3px 0, rgba(60, 64, 67, .15) 0 6px 10px 4px;
}

.button-18:not(:disabled):focus {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

.button-18:not(:disabled):active {
  box-shadow: rgba(60, 64, 67, .3) 0 4px 4px 0, rgba(60, 64, 67, .15) 0 8px 12px 6px;
}

.button-18:disabled {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

/*button delete*/
.button-19 {
  align-items: center;
  appearance: none;
  background-color: #dc3545;
  border-radius: 24px;
  border-style: none;
  box-shadow: rgba(0, 0, 0, .2) 0 3px 5px -1px,rgba(0, 0, 0, .14) 0 6px 10px 0,rgba(0, 0, 0, .12) 0 1px 18px 0;
  box-sizing: border-box;
  color: #fff;
  cursor: pointer;
  display: inline-flex;
  fill: currentcolor;
  font-size: 14px;
  font-weight: 500;
  height: 34px;
  justify-content: center;
  letter-spacing: .25px;
  line-height: normal;
  max-width: 100%;
  overflow: visible;
  padding: 2px 24px;
  position: relative;
  text-align: center;
  text-transform: none;
  transition: box-shadow 280ms cubic-bezier(.4, 0, .2, 1),opacity 15ms linear 30ms,transform 270ms cubic-bezier(0, 0, .2, 1) 0ms;
  user-select: none;
  -webkit-user-select: none;
  touch-action: manipulation;
  width: auto;
  will-change: transform,opacity;
  z-index: 0;
}

.button-19:hover {
  background: #F6F9FE;
  color: #174ea6;
}

.button-19:active {
  box-shadow: 0 4px 4px 0 rgb(60 64 67 / 30%), 0 8px 12px 6px rgb(60 64 67 / 15%);
  outline: none;
}

.button-19:focus {
  outline: none;
  border: 2px solid #4285f4;
}

.button-19:not(:disabled) {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

.button-19:not(:disabled):hover {
  box-shadow: rgba(60, 64, 67, .3) 0 2px 3px 0, rgba(60, 64, 67, .15) 0 6px 10px 4px;
}

.button-19:not(:disabled):focus {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

.button-19:not(:disabled):active {
  box-shadow: rgba(60, 64, 67, .3) 0 4px 4px 0, rgba(60, 64, 67, .15) 0 8px 12px 6px;
}

.button-19:disabled {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

</style>
 </head>
   
     <body id="page-top">
        <!-- Navigation -->
       <jsp:include page="common/Navbar.jsp"/>  
        <!--head-text-->      
        
        <% if (!major.equals("0") ){ %>
          	<div class="container">
			<div>
                <h1 style="text-align: center;" class="masthead-heading text-uppercase mb-0" ><b> ยินดี<span style="color:#017f3f">ต้อนรับ</span></b></h1>
            </div>
            <div>
                <h2 style="text-align: center;" class="masthead-heading text-uppercase mb-0" >กรุณาเลือกประเภทการแจ้งความประสงค์ตามที่ต้องการ</h2>
            </div>
            <div>
              
                <form class=" validate-form" name="frm" action="" method=GET>
                    <span class="login100-form-title p-b-43">
                    </span>
                                <div>
                                <a class="" href="loadpageorder1" >
                                <input id="tt" class="login100-form-btn2" type="button" value="แจ้งความประสงค์จัดซื้อจัดจ้าง (ไม่มีใบเสนอราคา)">
                                </a>
                                </div>
                
                                <div   style=" margin-top: 22px;">
                                <a class="" href="loadpageorder2">
                                    <input id="tt" class="login100-form-btn2 "    type="button" value="แจ้งความประสงค์จัดซื้อจัดจ้าง (มีใบเสนอราคา)">
                                </a>
                                </div>         
                            </form> 
		            </div>
		       
				</div>
         <% } %> 
        
        <% if (listorderRequest.size() > 0 || major.equals("0") ) {%>   
			<h2 class="page-section-heading text-center text-uppercase text-secondary mb-0" style="font-size: 40px;"><b>ประวัติการแจ้งความประสงค์การจัดซื้อจัดจ้าง</b></h2>
            
             <br>
            <!-- Form Table -->
             <form class="" name="frm" action=""  id="product_form">    
                     <div class=" product-table">
                        <div class="row">
                        	<div class="col-md-12">          
                                    <table class="table" id="form_table" style="text-align: center;">
                                      <thead class="thead-dark">
                                        <tr>     
                                         <th></th>     
                                          <th></th> 
                                           <% if(major.equals("0")){ %>                          
                                          <th style="width: 150px;">ลำดับที่</th>
                                          <th style="width: 230px;">วันที่แจ้ง</th>
                                     
                                          <th style="width: 300px;">ชื่อผู้แจ้ง</th>
                                          <th style="width: 250px;">สาขา</th>
                                          <th style="width: 650px;">ประเภทการแจ้งความประสงค์</th>
                                          <th style="width: 600px;">สถานะ</th>
                                           <th colspan="4" style="text-aglign:center" style="width: 450px;">จัดการข้อมูล</th>
                                          <% } %>
                                          
                                          <% if(!major.equals("0")){ %>
                                           <th style="width: 85px;">ลำดับที่</th>
                                          <th style="width: 230px;">วันที่แจ้ง</th>
                                          <th style="width: 220px;">ประเภทการแจ้งความประสงค์</th>
                                          <th style="width: 300px;">สถานะ</th>
                                          <th colspan="4" style="text-aglign:center" >จัดการข้อมูล</th>
                                          <% } %>
                                     	  
                                     	  <th ></th>
                                     	
                                     	   
                                          
                                           
                                       
                                        </tr>
                                      </thead>
                                      <% if (listorderRequest != null){%>                                  
                                        <%for (int i=0 ; i<listorderRequest.size(); i++) {%>
                                        	<% if(!listorderRequest.get(i).getStatus().equals("ยืนยันความประสงค์สำเร็จ")){ %> 
		                                     <!-- row input -->
		                                      <tbody>
		                                        <tr class="alert" role="alert">
		                                        <td></td>
		                                        <td></td>
		                                   
		                                          <th  scope="row"><%= i+1 %></th>
		                                          <td><%=sdf.format(listorderRequest.get(i).getOrderRequest_date().getTime())  %></td>     
		                                          <% if(major.equals("0")){ %>
                                        	 		<td><%= listorderRequest.get(i).getStaff().getStaff_name() %></td>
                                          	 		<td><%= listorderRequest.get(i).getStaff().getMajor().getMajor_name() %></td>
                                          		  <% } %>
		                                          <td><%=listorderRequest.get(i).getRequest_type() %> </td>  
		                                          
		                                          <% if(listorderRequest.get(i).getStatus().equals("ยืนยันความประสงค์") && major.equals("0")){ %>
		                                          	<td><label style="color: orange;"><b><%=status1 %></b></label></td>  
	                                          	  <% }else if(listorderRequest.get(i).getStatus().equals("ยืนยันความประสงค์") && !major.equals("0")){ %>
	                                          	    <td><label style="color: green;"><%=listorderRequest.get(i).getStatus() %></label></td>  
		                                          <% }else if(listorderRequest.get(i).getStatus().equals("กำลังรอการดำเนินการจากหน่วยพัสดุ")){ %>
		                                          	<td><label style="color: orange;"><%=listorderRequest.get(i).getStatus() %></label></td>  
	                                          	  <% }else if(listorderRequest.get(i).getStatus().equals("รอยืนยันความประสงค์") && major.equals("0")){ %>
	                                          		<td><label style="color: orange;"><%= listorderRequest.get(i).getStatus() %></label></td>  
                                          		  <% }else if(listorderRequest.get(i).getStatus().equals("รอยืนยันความประสงค์") && !major.equals("0")){ %>
                                          		    <td><label style="color: green;"><b><%=status2 %></b></label></td>  
		                                          <% }else if(listorderRequest.get(i).getStatus().equals("ข้อมูลใบเสนอราคาไม่ถูกต้อง")){ %>
		                                          	<td><label style="color: red;"><%=listorderRequest.get(i).getStatus() %></label></td> 
		                                          	<% }else if(listorderRequest.get(i).getStatus().equals("ข้อมูลใบเสนอราคาจากเจ้าหน้าที่ไม่ถูกต้อง")){ %>
		                                          	<td><label style="color: red;"><%=listorderRequest.get(i).getStatus() %></label></td> 
		                                          <% }else if(listorderRequest.get(i).getStatus().equals("ยืนยันความประสงค์สำเร็จ")){ %>
		                                          	<td><label style="color: green;"><%=listorderRequest.get(i).getStatus() %></label></td> 
		                                          <% } %>
		                                        
		                                       
		                                          <td > 
		                                           <a href="loadRequestDetail?OrderRequest_id=<%=listorderRequest.get(i).getOrderRequest_id() %>&request_type=<%=listorderRequest.get(i).getRequest_type()%>">
														<button type="button" class="button-17" role="button" style="width: 180px;">ดู 
														&nbsp; 	<i class="gg-eye"></i>										
														</button></a>
													</td>	
														
												<% if((listorderRequest.get(i).getStatus().equals("กำลังรอการดำเนินการจากหน่วยพัสดุ") 
														|| listorderRequest.get(i).getStatus().equals("ข้อมูลใบเสนอราคาจากเจ้าหน้าที่ไม่ถูกต้อง")
														|| listorderRequest.get(i).getStatus().equals("รอยืนยันความประสงค์")
														|| listorderRequest.get(i).getStatus().equals("ข้อมูลใบเสนอราคาไม่ถูกต้อง"))  && major.equals("0")  ){ %>
													<td > 			
		                                           <a href="loadEditRequest?OrderRequest_id=<%=listorderRequest.get(i).getOrderRequest_id() %>&request_type=<%=listorderRequest.get(i).getRequest_type() %>  "> 
		                                          		<button type="button" class="button-18" role="button" style="width: 180px;">แก้ไข
														&nbsp; 	<i class="gg-thermometer"></i>									
														</button></a> 
														</td>	
															<%}%>
															
													<% if((listorderRequest.get(i).getStatus().equals("กำลังรอการดำเนินการจากหน่วยพัสดุ") 
														|| listorderRequest.get(i).getStatus().equals("ข้อมูลใบเสนอราคาจากเจ้าหน้าที่ไม่ถูกต้อง")
														
														|| listorderRequest.get(i).getStatus().equals("ข้อมูลใบเสนอราคาไม่ถูกต้อง"))  && !major.equals("0")  ){ %>
													<td > 			
		                                           <a href="loadEditRequest?OrderRequest_id=<%=listorderRequest.get(i).getOrderRequest_id() %>&request_type=<%=listorderRequest.get(i).getRequest_type() %>  "> 
		                                          		<button type="button" class="button-18" role="button" style="width: 180px;">แก้ไข
														&nbsp; 	<i class="gg-thermometer"></i>									
														</button></a> 
														</td>	
															<%}%>	
															
													<% if((listorderRequest.get(i).getStatus().equals("ยืนยันความประสงค์")&& 
														listorderRequest.get(i).getRequest_type().equals("มีใบเสนอราคา")) && major.equals("0")  ){ %>
													<td > 			
		                                           <a href="loadEditRequest?OrderRequest_id=<%=listorderRequest.get(i).getOrderRequest_id() %>&request_type=<%=listorderRequest.get(i).getRequest_type() %>  "> 
		                                          		<button type="button" class="button-18" role="button" style="width: 180px;">แก้ไข
														&nbsp; 	<i class="gg-thermometer"></i>									
														</button></a> 
														</td>	
															<%}%>		
													
														<% if((listorderRequest.get(i).getStatus().equals("ยืนยันความประสงค์")&& 
														listorderRequest.get(i).getRequest_type().equals("ไม่มีใบเสนอราคา")) && major.equals("0")  ){ %>
													<td > 			
		                                           <a href="loadEditRequest?OrderRequest_id=<%=listorderRequest.get(i).getOrderRequest_id() %>&request_type=<%=listorderRequest.get(i).getRequest_type() %>  "> 
		                                          		<button type="button" class="button-18" role="button" style="width: 180px;">แก้ไข
														&nbsp; 	<i class="gg-thermometer"></i>									
														</button></a> 
														</td>	
															<%}%>		
																		
														
														<%-- 	<% if(	(listorderRequest.get(i).getStatus().equals("ข้อมูลใบเสนอราคาจากเจ้าหน้าที่ไม่ถูกต้อง")) && 
																listorderRequest.get(i).getRequest_type().equals("ไม่มีใบเสนอราคา") && 
																!major.equals("0") ){ %>
														<td >
													
															</td>
														<%}%>	 --%>	
														
														<%-- 	<% if(	(listorderRequest.get(i).getStatus().equals("ข้อมูลใบเสนอราคาจากเจ้าหน้าที่ไม่ถูกต้อง")) && 
																listorderRequest.get(i).getRequest_type().equals("ไม่มีใบเสนอราคา") && 
																major.equals("0") ){ %>
														<td >
													
															</td>
														<%}%>	 --%>
															
													<%-- 	<!-- เพิ่มใหม่ -->
																<% if((listorderRequest.get(i).getRequest_type().equals("ไม่มีใบเสนอราคา")  
																&& listorderRequest.get(i).getStatus().equals("ข้อมูลใบเสนอราคาจากเจ้าหน้าที่ไม่ถูกต้อง")
																 ||  listorderRequest.get(i).getStatus().equals("ข้อมูลใบเสนอราคาไม่ถูกต้อง")) && !major.equals("0") ){ %>
														<td > 
															<a href="loadEditRequest?OrderRequest_id=<%=listorderRequest.get(i).getOrderRequest_id() %>&request_type=<%=listorderRequest.get(i).getRequest_type()%>"> 
		                                          		<button type="button" class="button-18" role="button" style="width: 180px;">แก้ไขsdf
														&nbsp; 	<i class="gg-thermometer"></i>									
														</button></a> 
														</td>	
											
															<%}%>	 --%>	
															
													<%--  <!-- เพิ่มใหม่ -->
														<% if(	(listorderRequest.get(i).getStatus().equals("กำลังรอการดำเนินการจากหน่วยพัสดุ")) && 
																listorderRequest.get(i).getRequest_type().equals("ไม่มีใบเสนอราคา") && 
																!major.equals("0") ){ %>
														<td >
													
															</td>
														<%}%>	 --%>
														
														<%-- 	 <!-- เพิ่มใหม่ -->
														<% if(	(listorderRequest.get(i).getStatus().equals("กำลังรอการดำเนินการจากหน่วยพัสดุ")) && 
																listorderRequest.get(i).getRequest_type().equals("มีใบเสนอราคา") && 
																!major.equals("0") ){ %>
														<td >
													
															</td>
														<%}%>	 --%>
														 <!-- เพิ่มใหม่ -->
														<% if(	(listorderRequest.get(i).getStatus().equals("รอยืนยันความประสงค์")) && 
																listorderRequest.get(i).getRequest_type().equals("ไม่มีใบเสนอราคา") && 
																major.equals("0") ){ %>
														<td >
													
															</td>
														<%}%>	 
													
								
											
												
															
														
													<%-- 		
															<!-- เพิ่มใหม่ -->
														<% if(	(listorderRequest.get(i).getStatus().equals("ข้อมูลใบเสนอราคาไม่ถูกต้อง")) && 
																listorderRequest.get(i).getRequest_type().equals("มีใบเสนอราคา") && 
																!major.equals("0") ){ %>
														<td >
													
															</td>
														<%}%>	 --%>
															
														
														<% if((listorderRequest.get(i).getStatus().equals("ยืนยันความประสงค์") && !major.equals("0")) || (listorderRequest.get(i).getStatus().equals("รอยืนยันความประสงค์") && !major.equals("0"))){ %>
														 <td >
														   <a href="loadpageConfirm?OrderRequest_id=<%=listorderRequest.get(i).getOrderRequest_id() %>">
														<button type="button" class="button-17" role="button" style="width: 180px;">ยืนยัน
														&nbsp; 	<i class="gg-check"></i>									
														</button></a>
													</td>
														<%}%>
														
													 <!-- เพิ่มใหม่ -->
														<% if(	(listorderRequest.get(i).getStatus().equals("ยืนยันความประสงค์")) && 
																listorderRequest.get(i).getRequest_type().equals("มีใบเสนอราคา") && 
																!major.equals("0") ){ %>
														<td >
													
															</td>
														<%}%>  
														
														
															 	<% if((listorderRequest.get(i).getRequest_type().equals("ไม่มีใบเสนอราคา")  
																&& listorderRequest.get(i).getStatus().equals("ข้อมูลใบเสนอราคาจากเจ้าหน้าที่ไม่ถูกต้อง"))&& major.equals("0") ){ %>
														<td > 
															<a href="loadpageAddQuotation?OrderRequest_id=<%=listorderRequest.get(i).getOrderRequest_id() %>&request_type=<%=listorderRequest.get(i).getRequest_type()%>"> 
		                                          		<button type="button" class="button-18" role="button" style="width: 180px; background-color: #a1a4c1;">แก้ไขใบเสนอราคา 
														&nbsp; 	<i class="gg-thermometer"></i>									
														</button></a> 
														</td>	
											
															<%}%> 
														
														
															<% if(listorderRequest.get(i).getStatus().equals("กำลังรอการดำเนินการจากหน่วยพัสดุ") 
																	&& listorderRequest.get(i).getRequest_type().equals("มีใบเสนอราคา")
																	&& major.equals("0")  ){ %>
														<td > 
															<a href="loadpageQuotationDetailBySupplise?OrderRequest_id=<%=listorderRequest.get(i).getOrderRequest_id() %>&request_type=<%=listorderRequest.get(i).getRequest_type()%>"> 
		                                          		<button type="button" class="button-18" role="button" style="width: 180px; background-color: #a1a4c1;">ตรวจสอบ
														&nbsp; 	<i class="gg-search-found"></i>									
														</button></a>
														</td>	
														<%}%>
														
													<%-- 	 	<!-- เพิ่มใหม่ -->
														<% if(	(listorderRequest.get(i).getStatus().equals("ยืนยันความประสงค์")) && 
																listorderRequest.get(i).getRequest_type().equals("ไม่มีใบเสนอราคา") && 
																major.equals("0") ){ %>
														<td >
													
															</td>
														<%}%>  --%>
													
														
															<% if((listorderRequest.get(i).getStatus().equals("รอยืนยันความประสงค์")  
																	|| listorderRequest.get(i).getStatus().equals("ยืนยันความประสงค์")
																	|| listorderRequest.get(i).getStatus().equals("ข้อมูลใบเสนอราคาจากเจ้าหน้าที่ไม่ถูกต้อง")) 
																	&& listorderRequest.get(i).getRequest_type().equals("ไม่มีใบเสนอราคา")
																	&& !major.equals("0")  ){ %>
														<td >
															<a href="loadpageQuotationDetailByLecturer?OrderRequest_id=<%=listorderRequest.get(i).getOrderRequest_id() %>&request_type=<%=listorderRequest.get(i).getRequest_type()%>"> 
		                                          		<button type="button" class="button-18" role="button" style="width: 180px; background-color: #a1a4c1;">ตรวจสอบ
														&nbsp; 	<i class="gg-search-found"></i>									
														</button></a>
															</td>
														<%}%>
														
															<!-- เพิ่มใหม่ -->
														<% if((listorderRequest.get(i).getStatus().equals("ข้อมูลใบเสนอราคาไม่ถูกต้อง")																 
																&& listorderRequest.get(i).getRequest_type().equals("มีใบเสนอราคา")) && 
																!major.equals("0") ){ %>
																
														<td >
													
															</td>
														<%}%> 
														
													 	<!-- เพิ่มใหม่ -->
														<% if((	
																 listorderRequest.get(i).getStatus().equals("กำลังรอการดำเนินการจากหน่วยพัสดุ")
																|| listorderRequest.get(i).getStatus().equals("ข้อมูลใบเสนอราคาไม่ถูกต้อง")
																 
																&& listorderRequest.get(i).getRequest_type().equals("ไม่มีใบเสนอราคา")) && 
																!major.equals("0") ){ %>
																
														<td >
													
															</td>
														<%}%> 
														
														
														<!-- เพิ่มใหม่ -->
														<% if((listorderRequest.get(i).getStatus().equals("ข้อมูลใบเสนอราคาไม่ถูกต้อง")  || 
																(listorderRequest.get(i).getStatus().equals("ยืนยันความประสงค์")) && 
																listorderRequest.get(i).getRequest_type().equals("มีใบเสนอราคา")) && 
																major.equals("0") ){ %>
														<td >
															<a href="loadpageQuotationDetailByLecturer?OrderRequest_id=<%=listorderRequest.get(i).getOrderRequest_id() %>&request_type=<%=listorderRequest.get(i).getRequest_type()%>"> 
		                                          		<button type="button" class="button-18" role="button" style="width: 180px; background-color: #a1a4c1;">แก้ไขคำเสนอแนะ
														&nbsp; 	<i class="gg-search-found"></i>									
														</button></a>
															</td>
														<%}%>
														<!-- เพิ่มใหม่ -->
														<% if((	(listorderRequest.get(i).getStatus().equals("ยืนยันความประสงค์")) && 
																listorderRequest.get(i).getRequest_type().equals("ไม่มีใบเสนอราคา")) && 
																major.equals("0") ){ %>
														<td >
													
															</td>
														<%}%>
													
													
														
															<% if(listorderRequest.get(i).getRequest_type().equals("ไม่มีใบเสนอราคา")  && major.equals("0") && listorderRequest.get(i).getStatus().equals("กำลังรอการดำเนินการจากหน่วยพัสดุ")  ){ %>
														<td >
															<a href="loadpageAddQuotation?OrderRequest_id=<%=listorderRequest.get(i).getOrderRequest_id() %>&request_type=<%=listorderRequest.get(i).getRequest_type()%>"> 
		                                          		<button type="button" class="button-18" role="button" style="width: 180px; background-color: #a1a4c1;">เพิ่มใบเสนอราคา
														&nbsp; 	<i class="gg-thermometer"></i>									
														</button></a> 
														</td>	
														<%}%>
														
														
	
												<% if(listorderRequest.get(i).getStatus().equals("ดำเนินการไม่สำเร็จ") ){ %>
											<td >
												<a href="deleteOrderRequest?OrderRequest_id=<%=listorderRequest.get(i).getOrderRequest_id() %>">												
												<button type="button" class="button-19" role="button"  onclick="return confirm('แน่ใจหรือไม่ว่าต้องการลบข้อมูลนี้ ?');" style="width: 180px;">ลบ
														&nbsp; &nbsp;	<i class="gg-backspace"></i>								
														</button></a>
														</td>
												<%}else {%>
												<td >
												<a href="deleteOrderRequest?OrderRequest_id=<%=listorderRequest.get(i).getOrderRequest_id() %>">												
												<button type="button" class="button-19" role="button"  onclick="return confirm('แน่ใจหรือไม่ว่าต้องการลบข้อมูลนี้ ?');" style="width: 180px;">ยกเลิก
														&nbsp; &nbsp;	<i class="gg-backspace"></i>								
														</button></a>
														</td>  
												<%} %>
												                                  
		  										 <td></td>
		                                       
		                                      
		                                        </tr>                
		                                      </tbody>
		                                      <%} %>
                                      	<%} %>
                                      <%} %>
                                    </table>   
                                  
                            </div>
                        </div>
					</div>
                   </form>
                   
                <br><br><br>
                 <% } %>
                    <!-- Button link
                
                    <a class="" href="loadindex"  style=" margin-left: 37%;">
                     <button   style="  margin-top: 15px; width: 25%" type="button" class="btn btn-dark">ย้อนกลับ</button>         
              		</a>
        -->
         <br><br><br>
                <!-- Footer -->
      <div>    <jsp:include page="common/footer.jsp"/>       </div>

  <script type="text/javascript">
  var totals= document.getElementById("totals").textContent;
  
  
  </script>

	<!-- script link -->
  	<script src="layout/scripts/jquery.min.js"></script>
	<script src="layout/scripts/jquery.backtotop.js"></script>
	<script src="layout/scripts/jquery.mobilemenu.js"></script>
	 
    </body>
</html>

