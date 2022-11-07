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
ConfirmForm cf_form = (ConfirmForm) session.getAttribute("ConfirmForm");
List<File_Quotation> listFile = (List<File_Quotation>) fmanager.getAllQuotation(order_q.getOrderRequest_id()); 
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
String staffname = (String) session.getAttribute("staffname");   
Calendar calendar = Calendar.getInstance();
SimpleDateFormat caldateformat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
String  nowDate = caldateformat.format(calendar.getTime());

ProductManager pmanager = new ProductManager();
List<Quantity> listProduct = pmanager.getproductdetail(order_q.getOrderRequest_id()); 
double sum = 0.0;
String t ="";

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
<style>
@import url('https://fonts.googleapis.com/css2?family=Kanit:wght@200&display=swap');
 .h4font{
 font-family: 'Kanit', sans-serif;
 }

 .inputRadio{
 height: 35px;
    font-size: 14px;
    font-weight: 600;
 }
 .formcon{
     background-color: #F4F9F9;
    border: solid; 
    padding: 25px;
    border-radius: 90px;}
</style>
<body id="page-top">
        <!-- Navigation -->
       <jsp:include page="common/Navbar.jsp"/>
     
        <!--head-text-->
       	
			<h2 class="page-section-heading text-center text-uppercase text-secondary mb-0" style="font-size: 40px;"><b>"ยืนยันความประสงค์การจัดซื้อจัดจ้าง" </b></h2>
			 
			
			
                 <div class="container product-table" > 
                    
                               
                               <% if(order_q.getRequest_type().equals("ไม่มีใบเสนอราคา")){ %>
                                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0" style="font-size: 30px;">รายละเอียดข้อมูลการแจ้งความประสงค์การจัดซื้อจัดจ้าง</h2>
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
                                    <%} %>
                             
                                    
                                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0" style="font-size: 30px;">ไฟล์ใบเสนอราคา  </h2>
                               
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
                                   
									
                                    <br>
                                    
                                     
                                 <div class="formcon">                                    
                                 <h4 style="text-align: center;">  <b>แบบฟอร์มยืนยันความประสงค์ในการขอซื้อของจ้าง</b></h4>
                                   <form class="" id="frm" name="frm" action="addConfirmform"  method="post">
                					<input type="hidden" name="OrderRequest_id" value="<%= order_q.getOrderRequest_id() %>">
                                  <h6 style="text-align: right;" class="h4font"> <b>วันที่ <%=caldateformat.format(calendar.getTime()) %></b> </h6>
                                    <table class="table">
									  <thead  class="thead-dark">
									    <tr>
									      <th scope="col" style="width: 160px;">ใบเสนอราคา บริษัท : </th>								    
								      <th scope="col" style="width: 350px;">
								      <select style="width: 300px; color: black;"  name="company_name" id="company_name" onchange='validate()'>
									        <% if (listFile != null){%>
                                      	 <option disabled selected>กรุณาเลือกใบเสนอราคาที่ต้องการ</option>
                                          <%for (int i=0 ; i<listFile.size(); i++) {%>		
                                      
										  <option value="<%=listFile.get(i).getFile_name() %>"><%=listFile.get(i).getFile_name() %></option>
										<%} %>
                                    <%} %>
										</select>								
										</th>									
									      <th scope="col" >เลขที่</th>
									       <th scope="col"> <input style="width:150px ;color:black" type="text" id="quotation_no"name="quotation_no"></label></th>
									      <!--  //<th scope="col"><label  id="quotation_no" name="quotation_no"  ></label></th>-->
									      <th scope="col">วันที่ใบเสนอราคา</th>
									      <th scope="col"> <input style="width:150px ;color:black" type="text" id="quotation_date"name="quotation_date"></label></th>
									     <!--  <th scope="col"><label id="quotation_date" name="quotation_date"></label></th> -->								      
									    </tr>	
									    </thead>
									     </table>	
									 	<h6 style="color:red"  class="h4font"><b>*หมายเหตุ เลือกใบเสนอราคาตามความต้องการ*</b> </h6> 
									 	<div>
									 	 <h4><b> ใช้เงิน :</b> </h4> 
									 	 
									 	 
									 	</div>	
									 	
										<div class="form-check">
											 <input class="" type="radio" value="เงินรายได้" name="money_type" id="money_type1" >
										<label class="form-check-label" for="flexCheckDefault">เงินรายได้ </label> 
										</div>
										
										<div class="form-check">
											  <input class="" type="radio" value="เงินสะสมเพื่อการบริหารรายได้" name="money_type" id="money_type2">
											  <label class="form-check-label" for="flexCheckDefault"> เงินสะสมเพื่อการบริหารรายได้</label>
										</div>
										<div class="form-check">
											  <input class="" type="radio" value="" name="money_type" id="money_type3" value="Yes"> 
											  <label class="form-check-label" for="flexCheckDefault"> อื่นๆ :</label>	
											  <input style="width:150px" type="text" class="inputRadio" name="money_type_etc" > 																								   
														
										</div> 
									  	
									  	<br>		
									 	<div>
									 	<h4><b>เหตุผลความจำเป็น : </b> </h4> 
									 	</div>									  
										<div class="form-check">
											  <input class="" type="radio" value="1" name="necessity_type" id="necessity_type1" >
											  <label class="form-check-label" for="flexCheckChecked">
											  เพื่อใช้สำหรับการเรียนการสอน รายวิชา :</label>
											   <input style="width:150px" type="text" class="inputRadio" name="necessity_type1_text">
										</div>
											
										<div class="form-check" style="margin-top:5px">
											  <input class="" type="radio" value="2" name="necessity_type" id="necessity_type2"  >
											  <label class="form-check-label" for="flexCheckChecked">
											  เพื่อใช้สำหรับการเรียนการสอน รายวิชา วท.498											  
											  </label>
											  
											  <label  class="form-check-label" for="flexCheckChecked">&nbsp;&nbsp; หัวข้อ : </label>
											  <input style="width:150px" type="text" class="inputRadio" name="necessity_type2_text1" >&nbsp; 
											  
											  <label class="form-check-label" for="flexCheckChecked">&nbsp;&nbsp; ชื่อ-นามสกุล นักศึกษา :</label>&nbsp;
											<input style="width:150px" type="text" class="inputRadio" name="necessity_type2_text2" >
											  
											  
										</div>
										
										<div class="form-check" style="margin-top:5px">
											  <input class="" type="radio" value="เพื่อใช้ในการปฎิบัติงานในหลักสูตร" name="necessity_type" id="necessity_type3"  >
											  <label class="form-check-label" for="flexCheckChecked">เพื่อใช้ในการปฎิบัติงานในหลักสูตร </label>
										</div>
										
										<div class="form-check" style="margin-top:5px">
											  <input class="" type="radio" value="เพื่อใช้ในโครงการตามยุตธศาสตร์" name="necessity_type" id="necessity_type4" >
											  <label class="form-check-label" for="flexCheckChecked">เพื่อใช้ในโครงการตามยุตธศาสตร์ </label>
										</div>  
										
										<div class="form-check" style="margin-top:5px">
											  <input class="" type="radio" value="" name="necessity_type" id="necessity_type5" >
											  <label class="form-check-label" for="flexCheckChecked">อื่นๆ :</label>
											  <input style="width:150px" type="text" class="inputRadio" name="necessity_type_etc" >	 
											</div>	  
                                    
                                    <br>
                                    
                                    
                                    
                                    <table>
                                    
                                   	<h4><b>คณะกรรมการตรวจรับพัสดุ (วงเงิน 10,000.- ขึ้นไป กรรมการ 3 ท่าน) :</b>  </h4>
									 
									<tr>
									<td></td>
									  <td> <div class="form-check">
											  <label class="form-check-label" for="flexCheckChecked">1.ประธานกรรมการ:&nbsp;&nbsp;</label>
											  
											</div>
										</td>	
										
										<td>
										 <input style="width:250px" type="text" class="inputRadio" name="chairman_Board_name" >		 
										</td>
										
										  <td> <div class="form-check">
											  <label class="form-check-label" for="flexCheckChecked">2.กรรมการ:&nbsp;&nbsp;
											  </label>
											</div>
										</td>	
																				
										<td>
										 <input style="width:250px" type="text" class="inputRadio" name="board_name1">											 
										</td>
										
											  <td> <div class="form-check">
											  <label class="form-check-label" for="flexCheckChecked">3.กรรมการ:&nbsp;&nbsp;
											  </label>
											</div>
										</td>	
										
										<td>
										 <input style="width:250px" type="text" class="inputRadio" name="board_name2">
											 
										</td>
									
									</tr>	

                                    </table>
                                    <br><br>
                                   <div > 
                                   <input style="width:250px ; margin-left: 428px; text-align:center;" type="text" class="inputRadio"  value="<%=staffname%>" readonly>
								  </div>
                                 <div style="text-align:center"> 
                                  <label class="form-check-label" for="flexCheckChecked">ผู้เสนอ / ผู้ต้องการใช้พัสดุ</label>
									</div>
							 <br><br>			  
					<!-- Button link-->
                    <div>
                    <button type="submit"  style=" margin-left: 37%; margin-top: 15px; width: 25% ;  background-color: #1abc9c; border-color: #1abc9c;" class="btn btn-dark" OnClick="return checkconfirm(frm); "> ยืนยืนความประสงค์  </button>             
                    </div>
                
                      <div>
				     <a class="" href="loadpagelistorder"  style=" margin-left: 37%;">
				     <button   style="  margin-top: 15px; width: 25%" type="button" class="btn btn-dark">ย้อนกลับ</button>         
				     </a>
				     </div> 
                           </form>              	
									</div>
                             
                        </div>
                

        
                <!-- Footer -->
      <div style=" margin-top: 250px;" >   <jsp:include page="common/footer.jsp"/>       </div>
      
    
<script type="text/javascript">
function checkconfirm(frm) {
	
	var Board_name = /^[ก-์A-Za-z]{2,50}$/;
	var alertconfirm ;
	
	//Money Type
    var checked_moneyType = document.getElementsByName("money_type");
    var i=0;
    var ChooseMoneyType = false;
    
    for(i=0;i<checked_moneyType.length;i++){
        if(checked_moneyType[i].checked){
            ChooseMoneyType = true;
            break;
        }
    }
    if(!ChooseMoneyType){
        alert("กรุณาเลือกประเภทการใช้เงิน");
        return ChooseMoneyType;
    }
    
	//necessity type
    var checked_necessity_type = document.getElementsByName("necessity_type");
    var i=0;
    var Choosenecessity_type = false;
    
    for(i=0;i<checked_necessity_type.length;i++){
        if(checked_necessity_type[i].checked){
        	Choosenecessity_type = true;
            break;
        }
    }
    if(!Choosenecessity_type){
        alert("กรุณาเลือกเหตุผลความจำเป็น");
        return Choosenecessity_type;
    }
    
   
     
	//chairman_Board_name
	if(frm.chairman_Board_name.value == "") {
		alert("กรุณากรอกชื่อประธานกรรมการ");
		frm.chairman_Board_name.focus();
		return false;
	}
	if(!frm.chairman_Board_name.value.match(Board_name)){
		alert("กรุณากรอกชื่อประธานกรรมการ เป็นภาษาไทยหรือภาษาอังกฤษเท่านั้น");		
		frm.chairman_Board_name.focus();
		return false;
	}
	
	//Board_name1
	if(frm.board_name1.value == "") {
		alert("กรุณากรอกกรรมการคนที่ 1");
		frm.board_name1.focus();
		return false;
	}
	if(!frm.board_name1.value.match(Board_name)){
		alert("กรุณากรอกชื่อกรรมการคนที่ 1 เป็นภาษาไทยหรือภาษาอังกฤษเท่านั้น");		
		frm.board_name1.focus();
		return false;
	}
	
	//Board_name2
	if(frm.board_name2.value == "") {
		alert("กรุณากรอกชื่อกรรมการคนที่ 2");
		frm.board_name2.focus();
		return false;
	}
	if(!frm.board_name2.value.match(Board_name)){
		alert("กรุณากรอกชื่อกรรมการคนที่ 2 เป็นภาษาไทยหรือภาษาอังกฤษเท่านั้น");		
		frm.board_name2.focus();
		return false;
	}
	

	  return confirm('ยืนยันแล้ว ไม่สามารถกลับมาแก้ไขได้อีก คุณต้องการยืนยันหรือไม่?');


	
}  



function validate(){
	 var ddl = document.getElementById("company_name");
	 var selectedValue = ddl.options[ddl.selectedIndex].value;
	 //var results
	
		 <%for (int i=0; i<listFile.size(); i++) {%>
		 	if (selectedValue == '<%= listFile.get(i).getFile_name() %>'){
		 		var no = '<%=listFile.get(i).getQuotation_no() %>' ;
		 		var dateno = '<%= sdf.format(listFile.get(i).getQuotation_date().getTime() ) %>' ;
		 		document.getElementById('quotation_no').value = no;
		 		document.getElementById('quotation_date').value = dateno;

		 	
		 		}
		 <%} %>
	 
	}


    </script> 


	<!-- script link -->
  	<script src="layout/scripts/jquery.min.js"></script>
	<script src="layout/scripts/jquery.backtotop.js"></script>
	<script src="layout/scripts/jquery.mobilemenu.js"></script>
    </body>
</html>
