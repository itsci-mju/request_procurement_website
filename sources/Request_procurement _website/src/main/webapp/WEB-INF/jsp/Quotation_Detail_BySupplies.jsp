<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.*,util.*,java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
request.setCharacterEncoding("UTF-8");	
Login l = (Login) session.getAttribute("login");
FileManager fmanager = new FileManager();
OrderRequest order_q = (OrderRequest) session.getAttribute("OrderRequest");
List<File_Quotation> listFile = (List<File_Quotation>) fmanager.getAllQuotation(order_q.getOrderRequest_id()); 
String majorname = (String) session.getAttribute("majorName");   
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
	
	    
	     <link href='https://css.gg/lock.css' rel='stylesheet'>
    	 <link href='https://css.gg/mail.css' rel='stylesheet'>
</head>
<body id="page-top">
        <!-- Navigation -->
       <jsp:include page="common/Navbar.jsp"/>
     
        <!--head-text-->
       	 <%if (majorname.equals("เจ้าหน้าที่")) {%>
			<h2 class="page-section-heading text-center text-uppercase text-secondary mb-0" style="font-size: 40px;">รายละเอียดการแจ้งความประสงค์การจัดซื้อจัดจ้าง (มีใบเสนอราคา)</h2>
                <form id="frm" name="frm" action="loadpageAddcommentBySupplise" method="post" >
                <input type="hidden" name="OrderRequest_id" id="OrderRequest_id" value="<%= order_q.getOrderRequest_id() %>">
                
                 <div class="container product-table" style="height: 500px;"> 
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-wrap" style="height: 300px;">
                                    <table class="table" id="form_table" style="text-align: center;">
                                   
                                      <thead class="thead-dark">
                                        <tr>
                                            <th>ลำดับที่</th>
				                            <th>ชื่อบริษัท</th>
				                            <th>เลขที่</th> 
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
                                          <td><%=listFile.get(i).getFile_name() %></td>     
                                          <td> <%=listFile.get(i).getQuotation_no() %> </td>  
                                         <td><%= sdf.format(listFile.get(i).getQuotation_date().getTime() ) %></td>  
                                           <td><a href="./pdf/<%= listFile.get(i).getCompany_name() %>"><%= listFile.get(i).getCompany_name() %></a></td>  
                                     
                                        </tr>                
                                      </tbody>
                                      	<%} %>
                                      <%} %>
                                     
                                    </table>   
                                    <div class="form-check">
                                    <div>  <input class="form-check-input" type="radio" name="quotation_check" id="radio1"  value="1" checked>
									  <label class="form-check-label" for="flexRadioDefault1" >
									   ใบเสนอราคาถูกต้อง
									  </label></div>
									
									 <div >
									  <input class="form-check-input" type="radio" name="quotation_check" id="radio2" value="2">
									  <label class="form-check-label" for="flexRadioDefault1">
									   ใบเสนอราคาไม่ถูกต้อง
									  </label>
									</div> 
									</div>
									 

                                   
                                    <div>
                                   
                                    <label for="exampleFormControlTextarea1">คำเสนอแนะ</label>
                                    <textarea class="form-control" id="comment" name="comment" disabled="true"></textarea>
                                    
                                      <div>
				                    <button type="submit"  style=" margin-left: 37%; margin-top: 15px; width: 25% ;  background-color: #1abc9c; border-color: #1abc9c;" class="btn btn-dark" OnClick="return checkquotation(frm);"> ส่งคำเสนอแนะ  </button>             
				                    </div>
                                    
                              
                                
                                
			          			<!-- Button link-->
			                    <a class="" href="loadpagelistorder"  style=" margin-left: 37%;">
			                     <button   style="  margin-top: 15px; width: 25%" type="button" class="btn btn-dark">ย้อนกลับ</button>         
			              		</a>
                                    </div>
                                   
                                    	
                                </div>   
                            </div>
                        </div>
                         
					</div>	
					</form> 
               <%} %>
               
                  	 <%if (!majorname.equals("เจ้าหน้าที่")) {%>
			<h2 class="page-section-heading text-center text-uppercase text-secondary mb-0" style="font-size: 40px;">รายละเอียดการแจ้งความประสงค์การจัดซื้อจัดจ้าง (ไม่มีใบเสนอราคา)</h2>
                <form id="frm2" name="frm2" action="loadAddcommentByLecturer" method="post" >
                <input type="hidden" name="OrderRequest_id" id="OrderRequest_id" value="<%= order_q.getOrderRequest_id() %>">
                
                 <div class="container product-table" style="height: 500px;"> 
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-wrap" style="height: 300px;">
                                    <table class="table" id="form_table" style="text-align: center;">
                                   
                                      <thead class="thead-dark">
                                        <tr>
                                            <th>ลำดับที่</th>
				                            <th>ชื่อบริษัท</th>
				                            <th>เลขที่</th> 
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
                                          <td><%=listFile.get(i).getFile_name() %></td>     
                                          <td> <%=listFile.get(i).getQuotation_no() %> </td>  
                                         <td><%= sdf.format(listFile.get(i).getQuotation_date().getTime() ) %></td>  
                                           <td><a href="./pdf/<%= listFile.get(i).getCompany_name() %>"><%= listFile.get(i).getCompany_name() %></a></td>  
                                     
                                        </tr>                
                                      </tbody>
                                      	<%} %>
                                      <%} %>
                                     
                                    </table>   
                                    <div class="form-check">
                                     <div>
		                                    <label for="exampleFormControlTextarea1" style="color:red">*หมายเหตุ : ผู้ใช้สามารถส่งคำเสนอแนะถึงเจ้าหน้าที่ได้ถ้าใบเสนอราคามีปัญหา หรือไม่ตรงตามความต้องการ*</label>
					                    </div>
                                    <div>  <input class="form-check-input" type="radio" name="quotation_check" id="radio1"  value="1" checked>
									  <label class="form-check-label" for="flexRadioDefault1" >
									   ใบเสนอราคาถูกต้อง
									  </label>
									  </div>
									
									 <div >
									  <input class="form-check-input" type="radio" name="quotation_check" id="radio2" value="2">
									  <label class="form-check-label" for="flexRadioDefault1">
									   ใบเสนอราคาไม่ถูกต้อง
									  </label>
									</div> 
									</div>
  
                                    <div>                                 
                                    <label for="exampleFormControlTextarea1">คำเสนอแนะ</label>
                                    <textarea class="form-control" id="comment" name="comment" disabled="true"></textarea>                                   
                                      <div>
				                    <button type="submit"  style=" margin-left: 37%; margin-top: 15px; width: 25% ;  background-color: #1abc9c; border-color: #1abc9c;" class="btn btn-dark" OnClick="return checkquotation(frm2);"> ส่งคำเสนอแนะถึงเจ้าหน้าที่  </button>             
				                    </div>
                                    
                              
                                
                                
			          			<!-- Button link-->
			                    <a class="" href="loadpagelistorder"  style=" margin-left: 37%;">
			                     <button   style="  margin-top: 15px; width: 25%" type="button" class="btn btn-dark">ย้อนกลับ</button>         
			              		</a>
                                    </div>
                                   
                                    	
                                </div>   
                            </div>
                        </div>
                         
					</div>	
					</form> 
               <%} %>
      
                <!-- Footer -->
      <div style=" margin-top: 350px;" >    <jsp:include page="common/footer.jsp"/>       </div>
<script>


const checked_Quotation = document.getElementsByName("quotation_check");
window.addEventListener('click', function(event) {
    const comment = document.getElementsByName("comment");
    if(checked_Quotation[1].checked){
    	comment[0].disabled=false;
    }else{
    	comment[0].disabled=true;
    }
}, true);

</script>



	<!-- script link -->
  	<script src="layout/scripts/jquery.min.js"></script>
	<script src="layout/scripts/jquery.backtotop.js"></script>
	<script src="layout/scripts/jquery.mobilemenu.js"></script>
    </body>
</html>
