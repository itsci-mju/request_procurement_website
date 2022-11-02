<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.*,util.*,java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%

Login l = (Login) session.getAttribute("login");
FileManager fmanager = new FileManager();
OrderRequest order_q = (OrderRequest) session.getAttribute("OrderRequest");
List<File_Quotation> listFile = (List<File_Quotation>) fmanager.getAllQuotation(order_q.getOrderRequest_id()); 

SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

Calendar calendar = Calendar.getInstance();
SimpleDateFormat caldateformat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
String  nowDate = caldateformat.format(calendar.getTime());
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
       	
			<h2 class="page-section-heading text-center text-uppercase text-secondary mb-0" style="font-size: 40px;">ยืนยันการแจ้งความประสงค์การจัดซื้อจัดจ้าง</h2>
                 <div class="container product-table" style="height: 1000px;"> 
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
                                         <td><%= listFile.get(i).getCompany_name() %></td>  
                                     
                                        </tr>                
                                      </tbody>
                                      	<%} %>
                                      <%} %>
                                    </table>   
                                   
									
                                    <br>
                                    
                                     
                                    <div>                                    
                                    <h4 style="text-align: center;">แบบยืนยันความประสงค์ในการขอซื้อของจ้าง</h4>
                                   <form class="" id="frm" name="frm" action="addConfirmform"  method="post">
                					<input type="hidden" name="OrderRequest_id" value="<%= order_q.getOrderRequest_id() %>">
                                  <h6 style="text-align: right;"> วันที่ <%=caldateformat.format(calendar.getTime()) %> </h6>
                                    <table class="table">
									  <thead  class="thead-dark">
									    <tr>
									      <th scope="col" style="width: 160px;">ใบเสนอราคา บริษัท : </th>								    
								      <th scope="col" style="width: 350px;">
								      <select style="width: 300px; color: black;"  name="cars" id="cars">
									        <% if (listFile != null){%>
                                        <%for (int i=0 ; i<listFile.size(); i++) {%>										 
										  <option value="<%=listFile.get(i).getFile_name() %>"><%=listFile.get(i).getFile_name() %></option>
										<%} %>
                                      <%} %>
										</select>									
										</th>									
									      <th scope="col">เลขที่</th>
									      <th scope="col">123123123</th>
									      <th scope="col">วันที่ใบเสนอราคา</th>
									      <th scope="col">20/12/2000</th>									      
									    </tr>	
									    </thead>
									     </table>	
									   <table class="">				    
									   <tr>
									   <td style="width: 148px;">ใช้เงิน :</td>
									   <td>
									   		<div class="form-check">
											  <input class="form-check-input" type="radio" value="เงินรายได้" name="money_type" id="money_type1">
											  <label class="form-check-label" for="flexCheckDefault">เงินรายได้ </label></div>
									   </td>
									 
									   <td>
									   <div class="form-check">
											  <input class="form-check-input" type="radio" value="เงินสะสมเพื่อการบริหารรายได้" name="money_type" id="money_type2">
											  <label class="form-check-label" for="flexCheckDefault"> เงินสะสมเพื่อการบริหารรายได้</label></div>
									   </td>
									   
									   <td>
									   <div class="form-check">
											  <input class="form-check-input" type="radio" value="" name="money_type" id="money_type3"> 
											  <label class="form-check-label" for="flexCheckDefault"> อื่นๆ </label>
											  <span><input style="width:150px" type="text" class="form-control" name="money_type_etc">
											 </span>
											</div>
											  
									   </td>
																												   
									 </tr>
									  </table>
									  									  
									  <table >
									 <tr>
									  <td>
									   เหตุผลความจำเป็น : 
									   </td>
									   <td> <div class="form-check">
											  <input class="form-check-input" type="radio" value="1" name="necessity_type" id="necessity_type1" >
											  <label class="form-check-label" for="flexCheckChecked">
											  เพื่อใช้สำหรับการเรียนการสอน รายวิชา</label>
											</div>
										</td>	
										
										<td>
										 <input style="width:150px" type="text" class="form-control" name="necessity_type1_text" >
											 
										</td>
									</tr>									
									<tr>
									<td></td>
									<td>
										 <div class="form-check">
											  <input class="form-check-input" type="radio" value="2" name="necessity_type" id="necessity_type2"  >
											  <label class="form-check-label" for="flexCheckChecked">
											  เพื่อใช้สำหรับการเรียนการสอน รายวิชา วท.498											  
											  </label>
											  </div>
										</td>	

										<td ><label  class="form-check-label" for="flexCheckChecked">&nbsp;&nbsp; หัวข้อ </label>&nbsp;&nbsp;
										</td>
										
										<td>
										<input style="width:150px" type="text" class="form-control" name="necessity_type2_text1">
										</td>
										<td></td>
										<td><label class="form-check-label" for="flexCheckChecked">&nbsp;&nbsp; ชื่อ-นามสกุล นักศึกษา</label>&nbsp;&nbsp; 
										</td>
										
										<td>
										<input style="width:150px" type="text" class="form-control" name="necessity_type2_text2">
										</td>
									</tr>
									
									<tr>
									  <td> </td>
									   <td> <div class="form-check">
											  <input class="form-check-input" type="radio" value="เพื่อใช้ในการปฎิบัติงานในหลักสูตร" name="necessity_type" id="necessity_type3"  >
											  <label class="form-check-label" for="flexCheckChecked">
										  เพื่อใช้ในการปฎิบัติงานในหลักสูตร</label>
											</div>
										</td>	
										
									
									</tr>
										<tr>
									  <td> </td>
									   <td> <div class="form-check">
											  <input class="form-check-input" type="radio" value="เพื่อใช้ในโครงการตามยุตธศาสตร์" name="necessity_type" id="necessity_type4" >
											  <label class="form-check-label" for="flexCheckChecked">
										  เพื่อใช้ในโครงการตามยุตธศาสตร์</label>
											</div>
										</td>	

									</tr>
									 <tr>
									  <td>
									   </td>
									   <td> <div class="form-check">
											  <input class="form-check-input" type="radio" value="" name="necessity_type" id="necessity_type5" >
											  <label class="form-check-label" for="flexCheckChecked">
											  อื่นๆ </label>
											</div>
										</td>	
										
										<td>
										 <input style="width:150px" type="text" class="form-control" name="necessity_type_etc">
											 
										</td>
									</tr>	

                                    </table>
                                    
                                    
                                    <table>
                                    <br>
                                   	<h4> คณะกรรมการตรวจรับพัสดุ (วงเงิน 10,000.- ขึ้นไป กรรมการ 3 ท่าน) : </h4>
									 
									<tr>
									<td></td>
									  <td> <div class="form-check">
											  <label class="form-check-label" for="flexCheckChecked">1. ประธานกรรมการ&nbsp;&nbsp;
											  </label>
											</div>
										</td>	
										
										<td>
										 <input style="width:250px" type="text" class="form-control" name="chairman_Board_name">
											 
										</td>
										
										  <td> <div class="form-check">
											  <label class="form-check-label" for="flexCheckChecked">2. กรรมการ&nbsp;&nbsp;
											  </label>
											</div>
										</td>	
										
										<td>
										 <input style="width:250px" type="text" class="form-control" name="board_name1">
											 
										</td>
										
											  <td> <div class="form-check">
											  <label class="form-check-label" for="flexCheckChecked">3. กรรมการ&nbsp;&nbsp;
											  </label>
											</div>
										</td>	
										
										<td>
										 <input style="width:250px" type="text" class="form-control" name="board_name2">
											 
										</td>
									
									</tr>	
									
							
                                    </table>
                                    <br><br>
                                        <div > 
                                   <input style="width:250px" type="text" class="form-control" >
											 </div>
                                 <div style="text-align:center"> 
                                  <label class="form-check-label" for="flexCheckChecked">ผู้เสนอ / ผู้ต้องการใช้พัสดุ</label>
									</div>
							 <br><br>			  
								 <!-- Button link-->
                    <div>
                    <button type="submit"  style=" margin-left: 37%; margin-top: 15px; width: 25% ;  background-color: #1abc9c; border-color: #1abc9c;" class="btn btn-dark" OnClick="return checkquotation(frm);"> เพิ่มใบเสนอราคา  </button>             
                    </div>
                                    
                                    </form>
                                       	  <!-- Button link-->
				               	  <div>
				                    <a class="" href="loadpagelistorder"  style=" margin-left: 37%;">
				                     <button   style="  margin-top: 150px; width: 25%" type="button" class="btn btn-dark">ย้อนกลับ</button>         
				              		</a></div>
									</div>
                                    </div>                                   
                                </div>    
                            </div>
                        </div>
                   <br><br>
            
               	 
          			
            

         <br><br><br> <br><br><br> <br><br><br>
                <!-- Footer -->
      <div>    <jsp:include page="common/footer.jsp"/>       </div>

	<!-- script link -->
  	<script src="layout/scripts/jquery.min.js"></script>
	<script src="layout/scripts/jquery.backtotop.js"></script>
	<script src="layout/scripts/jquery.mobilemenu.js"></script>
    </body>
</html>
