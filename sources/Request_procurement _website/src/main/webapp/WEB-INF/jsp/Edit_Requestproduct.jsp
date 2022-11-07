<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.*,util.*,java.util.*,java.text.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<% Login l = (Login) session.getAttribute("login");
	ProductManager pmanager = new ProductManager();
	OrderRequest order_q = (OrderRequest) session.getAttribute("OrderRequest");
	List<Quantity> listProduct = pmanager.getproductdetail(order_q.getOrderRequest_id()); 
	double sum = 0.0;
	double totalsEd = 0.0;
	List<Product> listselect = pmanager.getAllListProduct(); 
	int number = 0 ;
	String majorname = (String) session.getAttribute("majorName");   
	DecimalFormat df = new DecimalFormat("###,###,###.00");
	
	FileManager fmanager = new FileManager();
	List<File_Quotation> listFile = (List<File_Quotation>) fmanager.getAllQuotation(order_q.getOrderRequest_id()); 

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	//List<Product> listTypeProduct = pmanager.getTypeProduct();
	//System.out.println(listProduct.toString());
	//System.out.println(listTypeProduct.size());
	// System.out.println(listProduct.size()); %>


<!DOCTYPE html>

<html lang="">

<head>
<title>ระบบแจ้งความประสงค์ขอให้จัดซื้อจัดจ้างพัสดุ</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

  	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
   
   	<link href="https://cdn.jsdelivr.net/npm/tom-select@2.0.0-rc.4/dist/css/tom-select.css" rel="stylesheet">
   	<script src="https://cdn.jsdelivr.net/npm/tom-select@2.0.0-rc.4/dist/js/tom-select.complete.min.js"></script>
  
   
       <!-- link css -->
    <link rel="stylesheet" type="text/css" href="css/layout.css">
    <link rel="stylesheet" type="text/css" href="css/login.css">
    <link rel="stylesheet" type="text/css" href="css/footer.css">
     
    <link href='https://css.gg/lock.css' rel='stylesheet'>
    <link href='https://css.gg/mail.css' rel='stylesheet'>
    <link href='https://css.gg/chevron-right.css' rel='stylesheet'>
    

    
</head>



<style>
  body,html{
   /* @import url('https://fonts.googleapis.com/css2?family=Kanit:wght@200&display=swap');*/
    src: url(https://fonts.googleapis.com/css2?family=Kanit:wght@200&display=swap);
font-family: 'Kanit', sans-serif;
}

.product-table{

}

input {
	outline: none;
	border: none;
	text-align:center;
}

</style>

<body id="top ">

	 <jsp:include page="common/Navbar.jsp"/>


<!-- ################################################################################################ -->

<section> 

</section>
    <!-- ################################################################################################ -->
      <% if(!order_q.getRequest_type().equals("มีใบเสนอราคา") &&  !order_q.getStatus().equals("รอยืนยันความประสงค์")   ){ %>
    <div class="content" style="margin-top: -160px;">
        <div class="container">	
          <div class="row align-items-stretch no-gutters contact-wrap">
            <div class="col-md-12">
              <div class="form h-100">
               
                <h3>แก้ไขรายละเอียดการแจ้งความประสงค์</h3>
                 <form name="form" action=""	method="">
                  <div class="row">
                    <div class="col-md-6 form-group mb-3">
                      <label for="budget" class="col-form-label">รายละเอียด *</label>
                    
                        <select  style="height: 45px ;width:450px;" class="select-state " id="product"  name="product"   placeholder="ค้นหาตรงนี้..." >
                          <option  value=""></option>
                          <%	 for(int i = 0 ; i <   listselect.size() ; i++)  {%>	
                            
                            <option   value="<%= listselect.get(i).getProduct_detail() %>_<%= listselect.get(i).getUnit()%>_<%= listselect.get(i).getPrice() %>_<%= listselect.get(i).getProduct_id() %> "  > <%= listselect.get(i).getProduct_detail() %> </option>	                              
						<%}%>
                          </select>    				
                    </div>
                     <div class="row">
                    <div class="col-md-6 form-group mb-3" style="width:400px;">
                      <label for="" class="col-form-label">จำนวน *</label>
                      <input type="number" class="form-control" name="totalproduct" id="totalproduct" placeholder="กรุณากรอกจำนวน" min="1" max="999"  style="height: 35px ; font-size: 14px; font-weight: 600;" required>
                    </div>
                  </div>
                   <div class="">
                      <button type="button"  class="btn btn-primary" id="add-row"  style=" border-radius: 15px; background-color: #17a2b8;     
    				;border-color: #17a2b8;" Onclick="return checkproduct(form)" >เพิ่มรายการ</button>
                    </div>
                  </div>
                 
                  
                  <div class="row">
                   
                  </div>
                </form>
              
              </div>
            </div>
          </div>
        </div>
    
      </div>
      
            <% if (l != null){ %>
            <!-- Form Table -->
            <form class="" id="frm" name="frm" action="EditOrderRequestProduct?username=<%= l.getUsername()  %>&OrderRequest_id=<%= order_q.getOrderRequest_id() %>" method="Post">
            <div class="container product-table"  style="margin-top: -113px;">
                <table class="table" > 
                    <thead class="thead-dark">
                        <tr style="text-align:center;"  >
                            <th>เลือก&nbsp;<input  type="checkbox" id="select-all" style="display: inherit;"></th>
                           
                            <th>รายละเอียด</th>
                            <th>จำนวน</th> 
                            <th>หน่วย</th>
                            <th>ราคา/หน่วย</th> 
                            <th>จำนวนเงิน</th>
                        </tr>
                    </thead>
                    
                      <% if (listProduct != null){%>
                                        <%for (int i=0 ; i<listProduct.size(); i++) {%>
                                     <!-- row input -->
                                      <tbody style="text-align: center;">
                                        <tr class="fadetext" id="select-row" role="alert" >
                                          <td><input type="checkbox" style="margin-top: 8px;"></td>
                                          
                                          <td>
                                          <input type="hidden" name="id<%=i+1%>" value=" <%=listProduct.get(i).getProduct().getProduct_id() %>" readonly  >
                                          <input type="text" name="p<%=i+1%>" value="<%=listProduct.get(i).getProduct().getProduct_detail() %>" readonly></td>     
                                          <td><input type="text" name="t<%=i+1%>" value="<%=listProduct.get(i).getQty() %>" readonly></td>  
                                          <td><input type="text" name="u<%=i+1%>" value="<%=listProduct.get(i).getProduct().getUnit() %>" readonly></td>  
                                          <td><input type="text"  name="pu<%=i+1%>" value="<%=df.format(listProduct.get(i).getProduct().getPrice()) %>" readonly></td>  
                                          <td><input type="text" class="subtotal" name="tt<%=i+1%>"  value="<%=df.format(listProduct.get(i).getPrice()) %>" readonly></td>  
                                      
                                        <label hidden><%=df.format(sum += listProduct.get(i).getPrice())  %></label>
                                        </tr>                
                                      </tbody>
                                      	<%} %>
                                      	 
                                          
                                      <%} %>
                                      <label id="totalEd" hidden>total = <%=sum %></label>
                                    
                </table> 
              <table class="table">
                   
               <thead class="thead-dark" style="text-align: center;"> 
              	 <tr>
                 	 <th style="text-align: initial;">&nbsp;&nbsp;&nbsp;<button type="button" class="remove-row" id="remove-row" style=" border-radius: 15px; " value="ลบ">&nbsp; ลบ &nbsp;</button></th>
					 <th style="text-align: end;"> ค่าใช้จ่ายทั้งหมด	 </th> 
          			 <th><label id="totals"><%=df.format(sum)%></label> &nbsp; <label > บาท </label></th>
                 </tr>
               </thead>
              </table>
            </div>
            
        
            <input type="hidden" id="chList"/>
             
              <%}%>
         
           <div>  
            </div>

             <div>
                <button type="submit"  style=" margin-left: 37%; margin-top: 15px; width: 25% ;  background-color: #1abc9c; border-color: #1abc9c;" class="btn btn-dark" 
                onclick="getGridData()">บันทึกการแก้ไข</button>             
             </div>
                <div>
				<a class="" href="loadpagelistorder"  style=" margin-left: 37%;"><button   style="  margin-top: 15px; width: 25%" type="button" class="btn btn-dark">ย้อนกลับ</button></a>
			</div>
             <input type="text" name="number" id="number" value='<%= listProduct.size() %>'  hidden>
         </form>   
         <%} %>   
           <!-- ------------------------------------------------------------------------------------------------------- -->
            <!-- ------------------------------------------------------------------------------------------------------- -->
             <!-- ------------------------------------------------------------------------------------------------------- -->
           <% if(order_q.getRequest_type().equals("ไม่มีใบเสนอราคา") &&  order_q.getStatus().equals("รอยืนยันความประสงค์") || order_q.getStatus().equals("ข้อมูลใบเสนอราคาไม่ถูกต้อง")  ){ %>
         <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0" style="font-size: 40px;"><b>แก้ไขแจ้งความประสงค์การจัดซื้อจัดจ้าง <span  style="color:#FF884B;">(ไม่มีใบเสนอราคา)</span></b></h2>
         <br>
			 <% if (l != null){ %>             
            <!-- Form Table -->
                    <div class="container" style="margin-top: -50px;">     
                        <div class="row"> 
                            <div class="col-md-12">
                                <div class="table-wrap">
                                 <form class="" id="frm2" name="frm2" action="EditOrderRequest2?username=<%= l.getUsername()  %>&OrderRequest_id=<%= order_q.getOrderRequest_id() %>"  method="post" enctype="multipart/form-data">
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
                                         <td><%=df.format(listProduct.get(i).getProduct().getPrice()) %></td>  
                                          <td><%=df.format(listProduct.get(i).getPrice()) %></td>  
                                          
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
                                
                                <% if(majorname.equals("เจ้าหน้าที่")){ %>
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
                             	 <div>
                                     <input type="hidden" name="OrderRequest_id" id="OrderRequest_id" value="<%= order_q.getOrderRequest_id() %>">
                
	                                    <label for="exampleFormControlTextarea1">คำเสนอแนะจากผู้แจ้งความประสงค์</label>
	                                    <label for="exampleFormControlTextarea1" style="color: red;">: <%= order_q.getComment() %></label>
				                    </div>
                                      <div>
				                    </div>  
				                   
				                      <div>
				                    <button type="submit"  style=" margin-left: 37%; margin-top: 25px; width: 25% ;  background-color: #1abc9c; border-color: #1abc9c;" class="btn btn-dark" OnClick="return checkquotation(frm2);"> บันทึกการแก้ไขใบเสนอราคา  </button>             
				                    </div> 
				                    <%} %>
				                     <div>
					               <a class="" href="loadpagelistorder"  style=" margin-left: 37%;"><button   style="  margin-top: 15px; width: 25%" type="button" class="btn btn-dark">ย้อนกลับ</button></a>
					              </div>				                  
                      </form>  
                      
                      
                  
                                </div>  
                            
                            
                            </div>	
                        </div>
                    </div>                      
           
                    <!-- Button link-->
                  
                    <%} %>  
        <%} %>
        
            
    
            					
               
           
   
              <br><br><br><br><br>
    
<!-- ################################################################################################ -->

		<div>
		  <!-- Footer -->
		  <jsp:include page="common/footer.jsp"/>
  		</div>

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
   
 	<script type="text/javascript">
    
         new TomSelect(".select-state",{
             create: false,
             sortField: {
                 field: "text",
                 direction: "asc"
             }
         });
       
         </script>
  
   <script type="text/javascript">
   var form = $("#form");
   var count = 0 ;
   
  
        $(document).ready(function(){
            // Add new row
            $("#add-row").click(function(){
            	count++;
            	var number =   $("#number").val();
            	number++;
            	var productdetail = $("#product").val();
            	let product=productdetail.split("_") ;
                var totalproduct = $("#totalproduct").val();
                var pricetotal = parseFloat(product[2])*parseFloat(totalproduct);
                var unit = $("#unit").val();
                if(productdetail != "" && totalproduct != ""){
                	$(".table tbody tr").last().after(
                    '<tr class="fadetext" id="select-row" >'+
                        '<td><input type="checkbox" style="margin-top: 8px;"></td>'+
                       // '<td id="no" >'+number+'</td>'+
                      '<td> <input type="hidden" name="id'+number+'" value="'+product[3]+'" readonly  > '+
                        ' <input type="text" name="p'+number+'" value="'+product[0]+'" readonly  > </td>'+
                        '<td> <input type="text" name="t'+number+'" value="'+totalproduct+'" readonly> </td>'+
                        '<td> <input type="text" name="u'+number+'" value="'+product[1]+'" readonly> </td>'+
                        '<td> <input type="text" name="pu'+number+'" value="'+product[2]+'" readonly> </td>'+
                        '<td> <input type="text" class="subtotal" name="tt'+number+'" value="'+pricetotal+'" readonly"> </td>'+
                        
                    '</tr>'
                	);
                	  frm.number.value=number; // to input:hidden
              
 	  				
                var totals= parseFloat(document.getElementById("totals").textContent);
                var nf = Intl.NumberFormat();
                document.getElementById("totals").innerHTML= (nf.format(totals+pricetotal));
                   
                 document.getElementById("product").options[2].disabled = true;
                  $('.form-div row col-md-3').parent('div').remove();
                  $("#totalproduct").val(null);
                  $("#unit").val(null); 
               
                }  
            })
            

            // Select all checkbox
            $("#select-all").click(function(){
                var isSelected = $(this).is(":checked");
                if(isSelected){
                    $(".table tbody tr").each(function(){
                        $(this).find('input[type="checkbox"]').prop('checked', true);
                    })
                }else{
                    $(".table tbody tr").each(function(){
                        $(this).find('input[type="checkbox"]').prop('checked', false);
                    })
                }
            });
            
            // Remove selected rows
            $("#remove-row").click(function(){
                $(".table tbody tr").each(function(){
                    var isChecked = $(this).find('input[type="checkbox"]').is(":checked");
                    var tableSize = $(".table tbody tr").length;
                    if(tableSize == 1){
                        alert('มีรายการเหลืออย่างน้อย 1 รายการ.');
                    }else if(isChecked){
                    	
                        $(this).remove();
                                       
                        var totals= parseFloat(document.getElementById("totals").textContent);        
                      //  var ped = $(this).find("input[class='subtotal_ed']").val();
                        var p = $(this).find("input[class='subtotal']").val();
                        
                        document.getElementById("totals").innerHTML= (totals-parseFloat(p)).toFixed(2)  ;
                    //    document.getElementById("totals").innerHTML= (totals-parseFloat(ped)).toString() ;
                    }
                });
            }); 

        })
        
		  
        function getGridData() {
        console.log($(':text[name="p"]')[0].value);
		var pdData = {};
		var chList = "";
		var chList2 = "";
		var chList3 = "";
		var productsize = $(':text[name="p"]').length;
		
		for(var i=0; i<productsize; i++){
			if (chList == "") {
				chList = $(':text[name="p"]')[i].value+ "," + $(':text[name="t"]')[i].value + "," + $(':text[name="u"]')[i].value;
			} else {
				chList += "_" + $(':text[name="p"]')[i].value+ "," + $(':text[name="t"]')[i].value + "," + $(':text[name="u"]')[i].value;
			}
		}

		
	}
        
 
    </script>   
    
    <script type="text/javascript">

function checkproduct(form) {
	
	//เช็คกรอกรายการ
	if(form.product.value == "" ){
		alert("กรุณาเลือกรายการที่ต้องการ");
		return false;
	}
	
	
	$('#product').on('change', function() {
		  //console.log($(this).val())
		  if ($(this).val() == '') {
		    alert('Select one of the options')
		  }
		})
	//เช็คจำนวน
	if(form.totalproduct.value == "") {
			alert("กรุณากรอกจำนวน");
			form.totalproduct.focus();
			return false;
		}
	
	 return confirm('ต้องการแจ้งความประสงค์แบบไม่มีใบเสนอราคาใช่หรือไม่?');
} 
</script>  
	
<script type="text/javascript">

</script>

<!-- JAVASCRIPTS -->
<script src="layout/scripts/jquery.min.js"></script>
<script src="layout/scripts/jquery.backtotop.js"></script>
<script src="layout/scripts/jquery.mobilemenu.js"></script>
</body>
</html>
