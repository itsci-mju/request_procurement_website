<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.*,util.*,java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%

Login l = (Login) session.getAttribute("login");
ProductManager pmanager = new ProductManager();
OrderRequest order_q = (OrderRequest) session.getAttribute("OrderRequest");
List<Quantity> listProduct = pmanager.getproductdetail(order_q.getOrderRequest_id()); 


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
       	
			<h2 class="page-section-heading text-center text-uppercase text-secondary mb-0" style="font-size: 40px;">รายละเอียดการแจ้งความประสงค์การจัดซื้อจัดจ้าง (ไม่มีใบเสนอราคา)</h2>
                 <div class="container product-table" style="height: 500px;"> 
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-wrap" style="height: 300px;">
                                    <table class="table" id="form_table" style="text-align: center;">
                                   
                                      <thead class="thead-dark">
                                        <tr>
                                            <th>ลำดับที่</th>
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
                                    </table>   
                                </div>    
                            </div>
                        </div>
					</div>
               
          			<!-- Button link-->
                    <a class="" href="loadpagelistorder"  style=" margin-left: 37%;">
                     <button   style="  margin-top: 15px; width: 25%" type="button" class="btn btn-dark">ย้อนกลับ</button>         
              		</a>

         <br><br><br>
                <!-- Footer -->
      <div>    <jsp:include page="common/footer.jsp"/>       </div>

	<!-- script link -->
  	<script src="layout/scripts/jquery.min.js"></script>
	<script src="layout/scripts/jquery.backtotop.js"></script>
	<script src="layout/scripts/jquery.mobilemenu.js"></script>
    </body>
</html>
