<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.*,util.*,java.util.*,java.text.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%Login l = (Login) session.getAttribute("login"); 
FileManager fmanager = new FileManager();
OrderRequest order_q = (OrderRequest) session.getAttribute("OrderRequest");
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
      
          
			<h2 class="page-section-heading text-center text-uppercase text-secondary mb-0" style="font-size: 40px;"><b>แก้ไขแจ้งความประสงค์การจัดซื้อจัดจ้าง <span  style="color:#FF884B;">(มีใบเสนอราคา)</span></b></h2>
         <br>
              <% if (l != null){ %>
            <!-- Form Table -->
             <form class="" id="frm" name="frm" action="EditOrderRequest2?username=<%= l.getUsername()  %>&OrderRequest_id=<%= order_q.getOrderRequest_id() %>"  method="post" enctype="multipart/form-data">
                
                    <div class="container" style="margin-top: -50px;">
                     
                        <div class="row"> 
                            <div class="col-md-12">
                                <div class="table-wrap">
                                
                             
                                
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
                                     
                                </div>  
                                <% if (order_q.getStatus().equals("ข้อมูลใบเสนอราคาไม่ถูกต้อง")){ %>
                                    <div>
	                                    <label for="exampleFormControlTextarea1">คำเสนอแนะ</label>
	                                    <label for="exampleFormControlTextarea1" style="color: red;">: <%= order_q.getComment() %></label>
				                    </div>
                                <%} %>
                            </div>	
                        </div>
                    </div>   
                    
                 <br><br><br>
                    <!-- Button link-->
                    <div>
                    <button type="submit"  style=" margin-left: 37%; margin-top: 15px; width: 25% ;  background-color: #1abc9c; border-color: #1abc9c;" class="btn btn-dark" OnClick="return checkquotation(frm);"> บันทึกการแก้ไข  </button>             
                    </div>
                   </form>
                    <%} %>  
                    <div><a class="" href="loadpagelistorder">
                     <button   style=" margin-left: 37%; margin-top: 15px; width: 25%" type="button" class="btn btn-dark">ย้อนกลับ</button>         
              		</a>	</div>
                	
                
                <br><br><br>
                <!-- Footer -->
                  <div>    <jsp:include page="common/footer.jsp"/>       </div>
      
        <script type="text/javascript">

function checkquotation(frm) {
	
	var companyname = /^[A-Za-zก-์\s]{2,50}$/; 


	//company name 1
	if(frm.a_name_company.value == "") {
		alert("กรุณากรอกชื่อบริษัท ที่ 1 ");
		frm.a_name_company.focus();
		return false;
	}
	//company name 2
	if(frm.b_name_company.value == "") {
		alert("กรุณากรอกชื่อบริษัท ที่ 2 ");
		frm.a_name_company.focus();
		return false;
	}
	//company name 3
	if(frm.c_name_company.value == "") {
		alert("กรุณากรอกชื่อบริษัท ที่ 3");
		frm.a_name_company.focus();
		return false;
	}
	
	
	
	
} 
</script>       
        
     <!-- script link -->     
  	 <script src="layout/scripts/jquery.min.js"></script>
	 <script src="layout/scripts/jquery.backtotop.js"></script>
	 <script src="layout/scripts/jquery.mobilemenu.js"></script>
	 
    </body>
</html>
