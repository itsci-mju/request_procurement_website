<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.*,util.*,java.util.*,java.text.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%Login l = (Login) session.getAttribute("login"); 

String OrderRequest_id = (String) session.getAttribute("OrderRequest_id");     
ProductManager pmanager = new ProductManager();
OrderRequest order_q = (OrderRequest) session.getAttribute("OrderRequest");
List<Quantity> listProduct = pmanager.getproductdetail(order_q.getOrderRequest_id()); 
double sum = 0.0;

FileManager fmanager = new FileManager();

List<File_Quotation> listFile = (List<File_Quotation>) fmanager.getAllQuotation(order_q.getOrderRequest_id()); 

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
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
    <link href='https://css.gg/chevron-right.css' rel='stylesheet'>
  
  
    </head>
    
  
    
     <body id="page-top">
        <!-- Navigation -->
      <jsp:include page="common/Navbar.jsp"/>
     
        <!--head-text-->
	
         <br>
         	 <% if(order_q.getStatus().equals("กำลังรอการดำเนินการจากหน่วยพัสดุ") ) { %>
              <% if (l != null){ %>
            <!-- Form Table -->
             <form class="" id="frm" name="frm" action="addQuotationBysupplies?username=<%= l.getUsername() %>&&OrderRequest_id=<%=OrderRequest_id %> "  method="post" enctype="multipart/form-data">
                
                    <div class="container" style="margin-top: -50px;">
                     
                        <div class="row"> 
                            <div class="col-md-12">
                                <div class="table-wrap">
                                 <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0" style="font-size: 40px;"><b>รายละเอียดการแจ้งความประสงค์การจัดซื้อจัดจ้าง <span  style="color:#FF884B;">(ไม่มีใบเสนอราคา)</span></b></h2>
         
                                  <table class="table" id="form_table" style="text-align: center;">
                                   
                                      <thead class="thead-dark">
                                        <tr>
                                            <th>ลำดับที่</th>
				                            <th>รายละเอียด</th>
				                            <th>จำนวน</th> 
				                            <th>หน่วย</th>
				                            <th>ราคา/หน่วย</th> 
				                            <th>จำนวนเงิน</th>
                                        <th></th>
                                        </tr>
                                      </thead>
                                       <% if (listProduct != null){%>
                                        <%for (int i=0 ; i<listProduct.size(); i++) {%>
                                     <!-- row input -->
                                      <tbody>
                                        <tr class="alert" role="alert">
                                          <th  scope="row"><%= i+1 %></th>
                                          <td><%=listProduct.get(i).getProduct().getProduct_detail() %></td>     
                                          <td> <%=listProduct.get(i).getQty() %> </td>  
                                          <td><%=listProduct.get(i).getProduct().getUnit() %></td>  
                                         <td><%=listProduct.get(i).getProduct().getPrice() %></td>  
                                          <td><%=listProduct.get(i).getPrice() %></td>  
                                          
                                        </tr>                
                                      </tbody>
                                      	<%} %>
                                      <%} %>
                                     
                                       <thead class="thead-dark">
                                        <tr>
                                            <th></th>
				                            <th></th>
				                            <th></th> 
				                            <th></th>
				                            <th>ค่าใช้จ่ายทั้งหมด</th> 
				                            
				                          <% for (int j=0 ; j<listProduct.size(); j++ ){%>
				                          <label hidden><%=sum = sum+listProduct.get(j).getPrice() %></label>
				                          
				                            <%} %>
				                            <th >
				                          <label><%=sum%> </label>
				                           </th>
                                        <th>บาท</th>
                                        </tr>
                                      </thead>
                                    </table> 
                                    
                                    <!-- ----------------------------------------------------------------------------------- -->
                                    
                                    <% if(order_q.getStatus().equals("กำลังรอการดำเนินการจากหน่วยพัสดุ") ) { %>
                                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0" style="font-size: 30px;"><b>- เพิ่มใบเสนอราคา - </b></h2>
                                    <table class="table" id="form_table" style="text-align: center;">
                                      <thead class="thead-dark">
                                        <tr>
                                          <th style="width: 60px">ลำดับที่</th>
                                          <th>ชื่อบริษัท</th>
                                          <th style="width: ">เลขที่</th>
                                          <th style="width: ">วันที่ใบเสนอราคา</th>
                                          <th style="width: ">ใบเสนอราคา</th>
                                          <th>&nbsp;</th>
                                        </tr>
                                      </thead>
                                      
                                      <!-- row1 input -->
                                      <tbody >
                                        <tr class="alert" role="alert">
                                          <th  scope="row" style="width: 120px; ">001</th>
                                          <td><input type="text" class="form-control" id="a_name_company" name ="a_name_company" placeholder="ชื่อบริษัท ที่ 1"></td> 
                                          <td><input type="text" class="form-control" id="a_number_quotation" name="a_number_quotation" style="width: 215px" placeholder="เลขประจำตัวผู้เสียภาษี ที่ 1"></td>
                                          <td><input type="date" class="form-control" id="a_date_quotation" name="a_date_quotation" style="width: 170px"></td>    
                                          <td><input type="file" class="form-control" id="a_file_quotation" name="a_file_quotation" style="width: 250px"></td>                                                             
                                        </tr>     

                                       <!-- row2 input --> 
                                        <tr class="alert" role="alert">
                                          <th  scope="row" style="width: 120px">002</th>
                                          <td><input type="text" class="form-control" id="b_name_company" name ="b_name_company" placeholder="ชื่อบริษัท ที่ 2"></td> 
                                          <td><input type="text" class="form-control" id="b_number_quotation" name="b_number_quotation" style="width: 215px" placeholder="เลขประจำตัวผู้เสียภาษี ที่ 2"></td>
                                          <td><input type="date" class="form-control" id="b_date_quotation" name="b_date_quotation" style="width: 170px"></td>    
                                          <td><input type="file" class="form-control" id="b_file_quotation" name="b_file_quotation" style="width: 250px"></td>                                            
                                        </tr>  
                                        
                                        <!-- row3 input --> 
                                          <tr class="alert" role="alert">
                                          <th  scope="row" style="width: 120px">003</th>
                                          <td><input type="text" class="form-control" id="c_name_company" name ="c_name_company" placeholder="ชื่อบริษัท ที่ 3"></td> 
                                          <td><input type="text" class="form-control" id="c_number_quotation" name="c_number_quotation" style="width: 215px" placeholder="เลขประจำตัวผู้เสียภาษี ที่ 3"></td>
                                          <td><input type="date" class="form-control" id="c_date_quotation" name="c_date_quotation" style="width: 170px"></td>    
                                          <td><input type="file" class="form-control" id="c_file_quotation" name="c_file_quotation" style="width: 250px"></td>                                         
                                        </tr>         
                                      </tbody>
                                    </table>  
                                       <%} %> 
                                        
                                       <% if(order_q.getStatus().equals("กำลังรอการดำเนินการจากหน่วยพัสดุ")) { %>
                                    	 <div>
		                                   <label for="exampleFormControlTextarea1" style="color: red;">*หมายเหตุ : ผู้ใช้สามารถแก้ไขด้วยการอัพโหลดใบเสนอราคาใหม่ได้*</label>
					                    </div>
	                                    <div>
		                                    <label for="exampleFormControlTextarea1">คำเสนอแนะจากผู้แจ้งความประสงค์</label>
		                                    <label for="exampleFormControlTextarea1" style="color: red;">: <%= order_q.getComment() %></label>
					                    </div>
	                                    
                                     <%} %> 
                                </div>  
                            </div>
                        </div>
                    </div>   
                 
                    <!-- Button link-->
                    <div>
                    <button type="submit"  style=" margin-left: 37%; margin-top: 15px; width: 25% ;  background-color: #1abc9c; border-color: #1abc9c;" class="btn btn-dark" 
                    OnClick="return checkquotation(frm);"> เพิ่มใบเสนอราคา  </button>             
                    </div>
                   </form>
                    <%} %>  
                  <%} %> 
                  
                  
                   <!------------------------------------------------------------------------->
                  <% if(order_q.getStatus().equals("ข้อมูลใบเสนอราคาจากเจ้าหน้าที่ไม่ถูกต้อง")|| order_q.getStatus().equals("ยืนยันความประสงค์") ) { %>
              <% if (l != null){ %>
            <!-- Form Table -->
             <form class="" id="frm2" name="frm2" action="EditQuotaionBySupplies?username=<%= l.getUsername() %>&&OrderRequest_id=<%=OrderRequest_id %> "  method="post" enctype="multipart/form-data">
                
                    <div class="container" style="margin-top: -50px;">
                     
                        <div class="row"> 
                            <div class="col-md-12">
                                <div class="table-wrap">
                                 <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0" style="font-size: 40px;"><b>รายละเอียดการแจ้งความประสงค์การจัดซื้อจัดจ้าง <span  style="color:#FF884B;">(ไม่มีใบเสนอราคา)</span></b></h2>
         
                                  <table class="table" id="form_table" style="text-align: center;">
                                   
                                      <thead class="thead-dark">
                                        <tr>
                                            <th>ลำดับที่</th>
				                            <th>รายละเอียด</th>
				                            <th>จำนวน</th> 
				                            <th>หน่วย</th>
				                            <th>ราคา/หน่วย</th> 
				                            <th>จำนวนเงิน</th>
                                        <th></th>
                                        </tr>
                                      </thead>
                                       <% if (listProduct != null){%>
                                        <%for (int i=0 ; i<listProduct.size(); i++) {%>
                                     <!-- row input -->
                                      <tbody>
                                        <tr class="alert" role="alert">
                                          <th  scope="row"><%= i+1 %></th>
                                          <td><%=listProduct.get(i).getProduct().getProduct_detail() %></td>     
                                          <td> <%=listProduct.get(i).getQty() %> </td>  
                                          <td><%=listProduct.get(i).getProduct().getUnit() %></td>  
                                         <td><%=listProduct.get(i).getProduct().getPrice() %></td>  
                                          <td><%=listProduct.get(i).getPrice() %></td>  
                                          
                                        </tr>                
                                      </tbody>
                                      	<%} %>
                                      <%} %>
                                     
                                       <thead class="thead-dark">
                                        <tr>
                                            <th></th>
				                            <th></th>
				                            <th></th> 
				                            <th></th>
				                            <th>ค่าใช้จ่ายทั้งหมด</th> 
				                            
				                          <% for (int j=0 ; j<listProduct.size(); j++ ){%>
				                          <label hidden><%=sum = sum+listProduct.get(j).getPrice() %></label>
				                          
				                            <%} %>
				                            <th >
				                          <label><%=sum%> </label>
				                           </th>
                                        <th>บาท</th>
                                        </tr>
                                      </thead>
                                    </table> 
                                    
                                 
                                <% if (order_q.getStatus().equals("ข้อมูลใบเสนอราคาจากเจ้าหน้าที่ไม่ถูกต้อง")|| order_q.getStatus().equals("ยืนยันความประสงค์") ){ %>
                                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0" style="font-size: 30px;"><b>- แก้ไขใบเสนอราคา -</b></h2>
                                  <table class="table" id="form_table" style="text-align: center;">
                                      <thead class="thead-dark">
                                        <tr>
                                          <th style="width: 60px">ลำดับที่</th>
                                          <th>ชื่อบริษัท</th>
                                          <th style="width: ">เลขที่</th>
                                          <th style="width: ">วันที่ใบเสนอราคา</th>
                                          <th style="width: ">ใบเสนอราคา</th>
                                        </tr>
                                      </thead>
                                      
                                      <!-- row1 input -->
                                      <tbody >
                                        <tr class="alert" role="alert">
                                          <th  scope="row" style="width: 120px; ">001</th>
                                          <td><input type="text" class="form-control" id="a-row1" name ="a_name_company" placeholder="ชื่อบริษัท ที่ 1" value="<%= listFile.get(0).getFile_name() %>"></td> 
                                          <td><input type="text" class="form-control" id="a-row2" name="a_number_quotation" style="width: 215px" placeholder="เลขประจำตัวผู้เสียภาษี ที่ 1" value="<%= listFile.get(0).getQuotation_no() %>"></td>
                                          <td><input type="date" class="form-control" id="a-row3" name="a_date_quotation" style="width: 170px" value="<%= sdf.format(listFile.get(0).getQuotation_date().getTime()) %>"></td>    
                                          <td><input type="file" class="form-control" id="a-row4" name="a_file_quotation" style="width: 250px" value="<%= listFile.get(0).getCompany_name() %>"><a href="./pdf/<%= listFile.get(0).getCompany_name() %>"><%= listFile.get(0).getCompany_name() %></a></td>                                                                                           
                                        </tr>     

                                       <!-- row2 input --> 
                                        <tr class="alert" role="alert">
                                          <th  scope="row" style="width: 120px">002</th>
                                          <td><input type="text" class="form-control" id="b-row1" name ="b_name_company" placeholder="ชื่อบริษัท ที่ 2" value="<%= listFile.get(1).getFile_name() %>"></td> 
                                          <td><input type="text" class="form-control" id="b-row2" name="b_number_quotation" style="width: 215px" placeholder="เลขประจำตัวผู้เสียภาษี ที่ 2" value="<%= listFile.get(1).getQuotation_no() %>"></td>
                                          <td><input type="date" class="form-control" id="b-row3" name="b_date_quotation" style="width: 170px" value="<%= sdf.format(listFile.get(1).getQuotation_date().getTime()) %>"></td>                                            
                                          <td><input type="file" class="form-control" id="b-row4" name="b_file_quotation" style="width: 250px" value="<%= listFile.get(1).getCompany_name() %>"><a href="./pdf/<%= listFile.get(1).getCompany_name() %>"><%= listFile.get(1).getCompany_name() %></a></td>                                                                                 
                                        </tr>  
                                        
                                        <!-- row3 input --> 
                                          <tr class="alert" role="alert">
                                          <th  scope="row" style="width: 120px">003</th>
                                          <td><input type="text" class="form-control" id="c-row1" name ="c_name_company" placeholder="ชื่อบริษัท ที่ 3" value="<%= listFile.get(2).getFile_name() %>"></td> 
                                          <td><input type="text" class="form-control" id="c-row2" name="c_number_quotation" style="width: 215px" placeholder="เลขประจำตัวผู้เสียภาษี ที่ 3" value="<%= listFile.get(2).getQuotation_no() %>"></td>
                                          <td><input type="date" class="form-control" id="c-row3" name="c_date_quotation" style="width: 170px" value="<%= sdf.format(listFile.get(2).getQuotation_date().getTime()) %>"></td>    
                                          <td><input type="file" class="form-control" id="c-row4" name="c_file_quotation" style="width: 250px" value="<%= listFile.get(2).getCompany_name() %>"><a href="./pdf/<%= listFile.get(2).getCompany_name() %>"><%= listFile.get(2).getCompany_name() %></a></td>                                                                         
                                        </tr>         
                                      </tbody>
                                    </table> 
                                       <%} %> 
                                        <% if (order_q.getStatus().equals("ข้อมูลใบเสนอราคาจากเจ้าหน้าที่ไม่ถูกต้อง")|| order_q.getStatus().equals("ยืนยันความประสงค์")){ %>
                                    	 <div>
		                                    <label for="exampleFormControlTextarea1" style="color: red;">*หมายเหตุ : ผู้ใช้สามารถแก้ไขด้วยการอัพโหลดใบเสนอราคาใหม่ได้*</label>
					                    </div>
	                                    <div>
		                                    <label for="exampleFormControlTextarea1">คำเสนอแนะจากผู้แจ้งความประสงค์</label>
		                                    <label for="exampleFormControlTextarea1" style="color: red;">: <%= order_q.getComment() %></label>
					                    </div>
	                                    
                                     <%} %> 
                                </div>  
                            </div>
                        </div>
                    </div>   
                 
                    <!-- Button link-->
                    <div>
                    <button type="submit"  style=" margin-left: 37%; margin-top: 15px; width: 25% ;  background-color: #1abc9c; border-color: #1abc9c;" class="btn btn-dark" OnClick="return checkquotation(frm2);"> แก้ไขใบเสนอราคา  </button>             
                    </div>
                   </form>
                    <%} %>  
                  <%} %> 
                  
                    <div><a class="" href="loadpagelistorder">
                     <button   style=" margin-left: 37%; margin-top: 15px; width: 25%" type="button" class="btn btn-dark">ย้อนกลับ</button>         
              		</a>	</div>
                	
                
                <br><br><br>
                <!-- Footer -->
                  <div>    <jsp:include page="common/footer.jsp"/>       </div>
      
        <script type="text/javascript">

function checkquotation(frm) {
	
	var companyname = /^[A-Za-z0-9ก-์\s]{2,150}$/; 
	var quotationNo = /^[A-Za-z0-9\-]{4,20}$/; 
	var FILE = /^([A-Za-z0-9ก-์\s_\\.\-\(\):])+(.pdf)$/;

	//company  1 
	if(frm.a_name_company.value == "") {
		alert("กรุณากรอกชื่อบริษัท ที่ 1 ");
		frm.a_name_company.focus();
		return false;
	}
	
	//No Quotatuion
	if(frm.a_number_quotation.value == "") {
		alert("กรุณากรอกเลขที่ใบเสนอราคา ที่ 1 ");
		frm.a_number_quotation.focus();
		return false;
	}
	if(!frm.a_number_quotation.value.match(quotationNo)){
		alert("กรุณากรอกเลขที่ใบเสนอราคาให้ถูกต้อง");		
		frm.a_number_quotation.focus();
		return false;
	}

	//Date Quotatuion
	var ToDate = new Date();
    var UserDate = document.getElementById("a_date_quotation").value;
	console.log(ToDate)
    if(UserDate==""){
        alert("กรุณากรอกวันที่ใบเสนอราคา ที่ 1 ");
        return false;
    }    
    if (new Date (UserDate).getTime() >= (ToDate).getTime()) {
         alert("วันที่เริ่มเป็นวันปัจจุบันหรือวันหลังจากปัจจุบันต้นไป");
         document.getElementById("a_date_quotation").value ="";	         
          return false;
     }
    
	//File
	if(frm.a_file_quotation.value == "") {
		alert("กรุณาเพิ่มไฟล์ใบเสนอราคา ที่ 1");
		frm.a_file_quotation.focus();
		return false;
	}

	
	
	//company  2 
	if(frm.b_name_company.value == "") {
		alert("กรุณากรอกชื่อบริษัท ที่ 2 ");
		frm.b_name_company.focus();
		return false;
	}
	
	if(frm.b_number_quotation.value == "") {
		alert("กรุณากรอกเลขที่ใบเสนอราคา ที่ 2 ");
		frm.b_number_quotation.focus();
		return false;
	}
	if(!frm.b_number_quotation.value.match(quotationNo)){
		alert("กรุณากรอกเลขที่ใบเสนอราคาให้ถูกต้อง");		
		frm.b_number_quotation.focus();
		return false;
	}
	

	//Date Quotatuion
	var ToDate = new Date();
    var UserDate = document.getElementById("b_date_quotation").value;
	console.log(ToDate)
    if(UserDate==""){
        alert("กรุณากรอกวันที่ใบเสนอราคา ที่ 2 ");
        return false;
    }    
    if (new Date (UserDate).getTime() >= (ToDate).getTime()) {
         alert("วันที่เริ่มเป็นวันปัจจุบันหรือวันหลังจากปัจจุบันต้นไป");
         document.getElementById("b_date_quotation").value ="";	         
          return false;
     }
	
	
	//File
	if(frm.b_file_quotation.value == "") {
		alert("กรุณาเพิ่มไฟล์ใบเสนอราคา ที่ 2 ");
		frm.b_file_quotation.focus();
		return false;
	}

	
	
	//company  3 
	if(frm.c_name_company.value == "") {
		alert("กรุณากรอกชื่อบริษัท ที่ 3");
		frm.c_name_company.focus();
		return false;
	}
	if(frm.c_number_quotation.value == "") {
		alert("กรุณากรอกเลขที่ใบเสนอราคา ที่ 3 ");
		frm.c_number_quotation.focus();
		return false;
	}
	if(!frm.c_number_quotation.value.match(quotationNo)){
		alert("กรุณากรอกเลขที่ใบเสนอราคาให้ถูกต้อง");		
		frm.c_number_quotation.focus();
		return false;
	}
	

	//Date Quotatuion
	var ToDate = new Date();
    var UserDate = document.getElementById("c_date_quotation").value;
	console.log(ToDate)
    if(UserDate==""){
        alert("กรุณากรอกวันที่ใบเสนอราคา ที่ 3");
        return false;
    }    
    if (new Date (UserDate).getTime() >= (ToDate).getTime()) {
         alert("วันที่เริ่มเป็นวันปัจจุบันหรือวันหลังจากปัจจุบันต้นไป");
         document.getElementById("c_date_quotation").value ="";	         
          return false;
     }
	
	//File
	if(frm.c_file_quotation.value == "") {
		alert("กรุณาเพิ่มไฟล์ใบเสนอราคา ที่ 3 ");
		frm.c_file_quotation.focus();
		return false;
	}
	
	  return confirm('ต้องการเพิ่มใบเสนอราคาใช่หรือไม่?');

} 

</script>     


        <script type="text/javascript">

function checkquotation(frm2) {
	
	var companyname = /^[A-Za-z0-9ก-์\s]{2,150}$/; 
	var quotationNo = /^[A-Za-z0-9\-]{4,20}$/; 
	var FILE = /^([A-Za-z0-9ก-์\s_\\.\-\(\):])+(.pdf)$/;

	//company  1 
	if(frm1.a_name_company.value == "") {
		alert("กรุณากรอกชื่อบริษัท ที่ 1 ");
		frm1.a_name_company.focus();
		return false;
	}
	
	//No Quotatuion
	if(frm1.a_number_quotation.value == "") {
		alert("กรุณากรอกเลขที่ใบเสนอราคา ที่ 1 ");
		frm1.a_number_quotation.focus();
		return false;
	}
	if(!frm1.a_number_quotation.value.match(quotationNo)){
		alert("กรุณากรอกเลขที่ใบเสนอราคาให้ถูกต้อง");		
		frm1.a_number_quotation.focus();
		return false;
	}

	//Date Quotatuion
	var ToDate = new Date();
    var UserDate = document.getElementById("a_date_quotation").value;
	console.log(ToDate)
    if(UserDate==""){
        alert("กรุณากรอกวันที่ใบเสนอราคา ที่ 1 ");
        return false;
    }    
    if (new Date (UserDate).getTime() >= (ToDate).getTime()) {
         alert("วันที่เริ่มเป็นวันปัจจุบันหรือวันหลังจากปัจจุบันต้นไป");
         document.getElementById("a_date_quotation").value ="";	         
          return false;
     }
    
	//File
	if(frm1.a_file_quotation.value == "") {
		alert("กรุณาเพิ่มไฟล์ใบเสนอราคา ที่ 1");
		frm1.a_file_quotation.focus();
		return false;
	}

	
	
	//company  2 
	if(frm2.b_name_company.value == "") {
		alert("กรุณากรอกชื่อบริษัท ที่ 2 ");
		frm2.b_name_company.focus();
		return false;
	}
	
	if(frm.b_number_quotation.value == "") {
		alert("กรุณากรอกเลขที่ใบเสนอราคา ที่ 2 ");
		frm.b_number_quotation.focus();
		return false;
	}
	if(!frm2.b_number_quotation.value.match(quotationNo)){
		alert("กรุณากรอกเลขที่ใบเสนอราคาให้ถูกต้อง");		
		frm2.b_number_quotation.focus();
		return false;
	}
	

	//Date Quotatuion
	var ToDate = new Date();
    var UserDate = document.getElementById("b_date_quotation").value;
	console.log(ToDate)
    if(UserDate==""){
        alert("กรุณากรอกวันที่ใบเสนอราคา ที่ 2 ");
        return false;
    }    
    if (new Date (UserDate).getTime() >= (ToDate).getTime()) {
         alert("วันที่เริ่มเป็นวันปัจจุบันหรือวันหลังจากปัจจุบันต้นไป");
         document.getElementById("b_date_quotation").value ="";	         
          return false;
     }
	
	
	//File
	if(frm3.b_file_quotation.value == "") {
		alert("กรุณาเพิ่มไฟล์ใบเสนอราคา ที่ 2 ");
		frm3.b_file_quotation.focus();
		return false;
	}

	
	
	//company  3 
	if(frm3.c_name_company.value == "") {
		alert("กรุณากรอกชื่อบริษัท ที่ 3");
		frm3.c_name_company.focus();
		return false;
	}
	if(frm3.c_number_quotation.value == "") {
		alert("กรุณากรอกเลขที่ใบเสนอราคา ที่ 3 ");
		frm3.c_number_quotation.focus();
		return false;
	}
	if(!frm3.c_number_quotation.value.match(quotationNo)){
		alert("กรุณากรอกเลขที่ใบเสนอราคาให้ถูกต้อง");		
		frm3.c_number_quotation.focus();
		return false;
	}
	

	//Date Quotatuion
	var ToDate = new Date();
    var UserDate = document.getElementById("c_date_quotation").value;
	console.log(ToDate)
    if(UserDate==""){
        alert("กรุณากรอกวันที่ใบเสนอราคา ที่ 3");
        return false;
    }    
    if (new Date (UserDate).getTime() >= (ToDate).getTime()) {
         alert("วันที่เริ่มเป็นวันปัจจุบันหรือวันหลังจากปัจจุบันต้นไป");
         document.getElementById("c_date_quotation").value ="";	         
          return false;
     }
	
	//File
	if(frm3.c_file_quotation.value == "") {
		alert("กรุณาเพิ่มไฟล์ใบเสนอราคา ที่ 3 ");
		frm3.c_file_quotation.focus();
		return false;
	}
	
	  return confirm('ต้องการเพิ่มใบเสนอราคาใช่หรือไม่?');

} 

</script>   
        
     <!-- script link -->     
  	 <script src="layout/scripts/jquery.min.js"></script>
	 <script src="layout/scripts/jquery.backtotop.js"></script>
	 <script src="layout/scripts/jquery.mobilemenu.js"></script>
	 
    </body>
</html>
