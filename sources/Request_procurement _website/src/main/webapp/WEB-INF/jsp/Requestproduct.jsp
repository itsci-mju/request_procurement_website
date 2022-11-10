<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.*,util.*,java.util.*,java.text.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<% OrderRequestManager manager = new OrderRequestManager();
	ProductManager pmanager = new ProductManager();
	Product pd = (Product) session.getAttribute("product");
	Login l = (Login) session.getAttribute("login");
	List<Product> listProduct = pmanager.getAllListProduct(); 
	int number = 0 ;
	
	DecimalFormat df = new DecimalFormat("###,###,###.00");
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



input {
	outline: none;
	border: none;
	
}

</style>

<body id="top ">

	 <jsp:include page="common/Navbar.jsp"/>


<!-- ################################################################################################ -->

<section> 

</section>
    <!-- ################################################################################################ -->
    <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0" style="font-size: 40px;"><b>แจ้งความประสงค์การจัดซื้อจัดจ้าง <span  style="color:#FF884B;">(ไม่มีใบเสนอราคา)</span></b></h2>
        
    <div class="content" style="margin-top: -160px;">
        <div class="container">
          <div class="row align-items-stretch no-gutters contact-wrap">
            <div class="col-md-12">
              <div class="form h-100">
                <h3>รายละเอียดการแจ้งความประสงค์</h3>
                 <form name="form" action=""	method="">
                  <div class="row">
                    <div class="col-md-6 form-group mb-3">
                    	
                      <label for="budget" class="col-form-label">รายละเอียด *</label>
                    
                        <select  style="height: 45px ;width:450px;" class="select-state " id="product"  name="product"   placeholder="ค้นหาตรงนี้..." >
                          <option  value=""></option>
                          <%	 for(int i = 0 ; i <   listProduct.size() ; i++)  {%>	
                            
                            <option   value="<%= listProduct.get(i).getProduct_detail() %>_<%= listProduct.get(i).getUnit()%>_<%= listProduct.get(i).getPrice() %>_<%= listProduct.get(i).getProduct_id() %> "  > <%= listProduct.get(i).getProduct_detail() %> </option>	                              
						<%}%>
                          </select>    				
                    </div>
                     <div class="row">
                    <div class="col-md-6 form-group mb-3" style="width:400px;">
                      <label for="" class="col-form-label"><b>จำนวน *</b></label>
                      <input type="number" class="form-control" name="totalproduct" id="totalproduct" placeholder="กรุณากรอกจำนวน" min="1" max="999"   maxlength="3" style="height: 35px ; font-size: 14px; font-weight: 600;" required>
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
            <form class="" id="frm" name="frm" action="addOrderRequest?username=<%= l.getUsername()  %>" method="Post">
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
                       <tbody>
                           <tr class="alert" role="alert">
                               </tr>          
                    </tbody>
                </table> 
              <table class="table" >
                   
               <thead class="thead-dark" style="text-align: center;"> 
              	 <tr>
                 	 <th style="text-align: initial;">&nbsp;&nbsp;&nbsp;<button type="button" class="remove-row" id="remove-row" style=" border-radius: 15px; " value="ลบ">&nbsp; ลบ &nbsp;</button></th>
					 <th style="text-align: end;"> ค่าใช้จ่ายทั้งหมด	 </th> 
          			 <th><label id="totals">0.0 </label> &nbsp; <label > บาท </label></th>
                 </tr>
               </thead>
              </table>
            </div>
            
            
            <input type="hidden" id="chList"/>
            <br><br> 
            
            <!-- Sent button -->
           <div>  
            </div>

             <div>
                <button type="submit"  style=" margin-left: 37%; margin-top: 15px; width: 25% ;  background-color: #1abc9c; border-color: #1abc9c;" class="btn btn-dark" 
                onclick="return checkpd(frm)">ส่งคำขอ</button>             
             </div>
             <input type="text" name="number" value="0" hidden>
         </form>   
         <%} %>   
         
             
            <div>
                <a class="" href="loadpagelistorder"  style=" margin-left: 37%;"><button   style="  margin-top: 15px; width: 25%" type="button" class="btn btn-dark">ย้อนกลับ</button></a>
              </div>
   
              <br><br><br><br><br>
    
<!-- ################################################################################################ -->

		<div>
		  <!-- Footer -->
		  <jsp:include page="common/footer.jsp"/>
  		</div>

   
       <script type="text/javascript">

function checkproduct(form) {
	var nn1 = /^[\d]{3}$/;
	//เช็คกรอกรายการ
	if(form.product.value == "" ){
		alert("กรุณาเลือกรายการพัสดุที่ต้องการ");
		 document.getElementById("product").value= ""; 
         document.getElementById("totalproduct").value= 1;
		return false;
	}
	
	
	/* $('#product').on('change', function() {
		  //console.log($(this).val())
		  if ($(this).val() == '') {
		    alert('กรุณาเลือกรายการพัสดุที่ต้องการ')
		  }
		}) */
	//เช็คจำนวน
	if(form.totalproduct.value == "") {
			alert("กรุณากรอกจำนวนรายการพัสดุ");
			form.totalproduct.focus();
			return false;
		}
	
	if(form.totalproduct.value <= 0.0) {
		alert("กรอกจำนวนเป็นจำนวนเต็มเท่านั้น");	
		return false;
	}
	
	if(form.totalproduct.macth(nn1)) {
		alert("กรอกจำนวนเป็นจำนวนเต็มเท่านั้น 1 - 999");	
		return false;
	}
	
	  document.getElementById("product").value= ""; 
      document.getElementById("totalproduct").value= 1;
    

} 
</script>  
   
   <script type="text/javascript">
   function checkpd(frm) {
	   
 	var totals= document.getElementById("totals").textContent;
	var totalvalue = parseFloat(totals.replaceAll(",","").valueOf());
	
	if(totalvalue == 0) {
		alert("ต้องมีรายการสินค้าอย่างน้อย 1 รายการ");
		return false;
	}else  {
		if(confirm("ต้องการแจ้งความประสงค์แบบไม่มีใบเสนอราคาใช่หรือไม่?") == true ){
			alert("บันทึกสำเร็จ");
			}else{
				return false ;
			}
		
		
		}  
	
   }
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
   var count = 0;
   var listselect = ["1"];

        $(document).ready(function(){
            // Add new row
            $("#add-row").click(function(){
            	
            	var productdetail = $("#product").val();
            	let product=productdetail.split("_") ;
                var totalproduct = $("#totalproduct").val();
                var pricetotal = parseFloat(product[2])*parseFloat(totalproduct);
                var unit = $("#unit").val();
                var nf = Intl.NumberFormat();
                
                var select = product[0]; //Code bas sood tueng
                console.log(select);
                console.info(listselect);
               var flag = true;
               
               if(totalproduct == '' || totalproduct == "" || totalproduct < 1 ){
            	   return false;
            	   }
               
                for(i=0; i<listselect.length; i++){
                	console.log(select+listselect[i]);
                	if(listselect[i] == select){
                		console.log(listselect.length);	  
                		flag = false;
                		 document.getElementById("product").value= productdetail; 
                         document.getElementById("totalproduct").value= 1;
                		alert("รายการห้ามซ้ำกัน");             		
                		return false;
                	}
                
                }
                
                if(flag === true){
    				 listselect.push(select);         
                			count++;
                        	var number = document.getElementsByName("number").value;
                        	number = count;
                		    if(productdetail != "" && totalproduct != ""){
                            	$(".table tbody tr").last().after(
                                '<tr class="fadetext" id="select-row" >'+
                                    '<td><input type="checkbox" style="margin-top: 8px;"></td>'+
                                   // '<td id="no" >'+number+'</td>'+
                                  '<td> <input type="hidden" name="id'+number+'" value="'+product[3]+'" readonly  > '+
                                    ' <input type="text" name="p'+number+'" value="'+product[0]+'" readonly  > </td>'+
                                    '<td> <input type="text" name="t'+number+'" value="'+totalproduct+'" readonly> </td>'+
                                    '<td> <input type="text" name="u'+number+'" value="'+product[1]+'" readonly> </td>'+
                                    '<td> <input type="text" name="pu'+number+'" value="'+nf.format(product[2])+'" readonly> </td>'+
                                    '<td> <input type="text" class="subtotal" name="tt'+number+'" value="'+nf.format(pricetotal)+'" readonly"> </td>'+
                                '</tr>'
                            	);
                            	  frm.number.value=count; // to input:hidden
                          
                            var totals= document.getElementById("totals").textContent;
                            var sum = parseFloat(totals.replaceAll(",","").valueOf())+pricetotal;
                            
                            document.getElementById("totals").innerHTML= (nf.format(parseFloat(sum)));
                            
                           
                          
                          
                           
                             document.getElementById("product").options[2].disabled = true;
                              $('.form-div row col-md-3').parent('div').remove();
                              $("#totalproduct").val(null);
                              $("#unit").val(null); 
                 
                            }
                	
                }
                document.getElementById("product").value= productdetail; 
                document.getElementById("totalproduct").value= 1;
            
                                     
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
           
            	var number = document.getElementsByName("number").value;
            	var nf = Intl.NumberFormat();
                $(".table tbody tr").each(function(){
                    var isChecked = $(this).find('input[type="checkbox"]').is(":checked");
                    var tableSize = $(".table tbody tr").length;
                    if(tableSize == 1){
                        alert('ไม่มีรายการที่ต้องการลบ.');
                    }else if(isChecked){
                    
                     
                      
                        var p = $(this).find("input[class='subtotal']").val();
                        
                        
                        var totals= document.getElementById("totals").textContent;
                        var sum = parseFloat(totals.replaceAll(",","").valueOf())-parseFloat(p.replaceAll(",","").valueOf());
                        
                        document.getElementById("totals").innerHTML= (nf.format(parseFloat(sum)));
   
                  
                        
                        $(this).remove();
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
    


<!-- JAVASCRIPTS -->
<script src="layout/scripts/jquery.min.js"></script>
<script src="layout/scripts/jquery.backtotop.js"></script>
<script src="layout/scripts/jquery.mobilemenu.js"></script>
</body>
</html>
