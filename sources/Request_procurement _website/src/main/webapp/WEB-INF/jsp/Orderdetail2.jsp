<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.*,util.*,java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>ระบบแจ้งความประสงค์ขอให้จัดซื้อจัดจ้างพัสดุ</title>    
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" ></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
      
        <link rel="stylesheet" href="css/stylehome.css">
        <link rel="stylesheet" href="css/styletable.css">
        <link rel="stylesheet" href="js/scripts.js">
        <link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
       	<link rel="stylesheet" type="text/css" href="css/style.css">
       	 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />  
       	
    </head>
   
    <script type="text/javascript">
    var countre=1;
    function addOrder(){
        countre+=1
       html= '   <tbody>\
       <tr class="alert" role="alert">\
         <th  scope="row">00'+countre+'</th>\
         <td><input type="text" class="form-control" id="searchporduct'+countre+'" name ="detailproduct" placeholder="Search..." style="width: 90%"><span style=" margin-left: 30%; margin-top:-40px; width: 60px; position: absolute;"><button class="btn btn-primary"><i class="fas fa-search"></i></button> </span></td> \
         <td><input type="number" class="form-control" id="totalproduct'+countre+'" name="totalproduct" style="width: 38%"></td>\
         <td><select id="unit'+countre+'" class="form-control" name="unitproduct" style="width: 38%">\
         <option value="dozen">โหล</option>\
         <option value="item">ชิ้น</option>\
         <option value="bit">อัน</option>\
         <option value="sticks">แท่ง</option>\
         <option value="box">กล่อง</option>\
         <option value="handle">ด้าม</option>\
         <option value="book">เล่ม</option>\
         </select>\
         </td>    \
         <!-- delete order --> \
         <td>\
         <a href="#" class="close" data-dismiss="alert" aria-label="Close">\
           <span aria-hidden="true"><i class="fa fa-close"></i></span>\
         </a>\
       </td>\
       </tr>  </tbody>'
     var t_form = document.getElementById('form_table')
     t_form.innerHTML+= html
    }
  
    

 </script>
    
    <body id="page-top">
        <!-- Navigation -->
       <jsp:include page="common/Navbar.jsp"/>
     
        <!--head-text-->
       	 <section class="page-section portfolio" id="portfolio">
            <div class="container" style="margin-top: -50px;">
			<h2 class="page-section-heading text-center text-uppercase text-secondary mb-0" style="font-size: 40px;">รายละเอียดการแจ้งความประสงค์การจัดซื้อจัดจ้าง (มีใบเสนอราคา)</h2>
            <!-- Icon Star-->
                <div class="divider-custom">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
              
            <!-- Form Table -->
             <form class="" name="frm" action=""  id="product_form">
                <section class="ftco-section">
                    <div class="container">
                        <div class="row justify-content-center">
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-wrap">
                                    <table class="table" id="form_table">
                                      <thead class="thead-dark">
                                        <tr>
                                          <th>ลำดับที่</th>
                                          <th>รายละเอียด</th>
                                          <th style="width: 20%">จำนวน</th>
                                          <th style="width: 20%">หน่วย</th>
                                          <th>&nbsp;</th>
                                        </tr>
                                      </thead>
                                      
                                     <!-- row input -->
                                      <tbody>
                                        <tr class="alert" role="alert">
                                          <th  scope="row"></th>
                                          <td>	

                                          </td>  
                                 
								     
							
                                       
                              			<!--  
											<input type="text" class="form-control" id="searchporduct" name ="detailproduct" placeholder="Search..." style="width: 90% ">
                                          <span style=" margin-left: 30%; margin-top:-40px; width: 60px; position: absolute;"><button class="btn btn-primary"><i class="fas fa-search"></i></button> </span> </td>
								-->
                                          <td></td>
                                          <td>
                                          </td>  
                                          
                                          <!-- delete order -->    
                                          <td>
                                       
                                        </td>
                                        </tr>                
                                      </tbody>
                                    </table>   
                                </div>    
                            </div>
                        </div>
                    </div>   
                     
                    <!-- Button link-->
                    <a class="" href="loadthomeselect"  style=" margin-left: 37%;">
                     <button   style="  margin-top: 15px; width: 25%" type="button" class="btn btn-dark">ย้อนกลับ</button>         
              		</a>
              
                </section>
                </form>
            </div> 
        </section>
      
      
   		

		<script src="js/select.js"></script>
	 	<!-- script link -->
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" ></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js"  ></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" ></script>
	
		<script src="js/scripts.js"></script>
        <script src="js/jquery.min.js"></script>
        <script src="js/popper.js"></script>
        <script src="js/bootstrap.min.js"></script>
         
    	<script src="js/main.js"></script>
        <!-- Bootstrap core JS-->
        
        <!-- Core theme JS-->
        
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <!-- * *                               SB Forms JS                               * *-->
        <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    </body>
</html>
