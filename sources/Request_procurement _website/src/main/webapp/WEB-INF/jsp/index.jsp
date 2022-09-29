<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.*,util.*,java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%

Login l = (Login) session.getAttribute("login");

String s = (String)session.getAttribute("regisalert");
String err = "";
try {
	err = (String) session.getAttribute("login");
	session.setMaxInactiveInterval(1);
	session.removeAttribute("login");
} catch (Exception e) {
	err = "";
}

int r =0;

try{
 r=(Integer) request.getAttribute("error");
} 
catch(Exception e){
e.printStackTrace();
}
%>
<!DOCTYPE html>

<html lang="">

<head>
<title>ระบบแจ้งความประสงค์ขอให้จัดซื้อจัดจ้างพัสดุ</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

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

<style>
  body,html{
   /* @import url('https://fonts.googleapis.com/css2?family=Kanit:wght@200&display=swap');*/
    src: url(https://fonts.googleapis.com/css2?family=Kanit:wght@200&display=swap);
font-family: 'Kanit', sans-serif;
}
</style>

<body id="top">

 <jsp:include page="common/Navbar.jsp"/>
    
  
<!-- ################################################################################################ -->

<section> 

</section>
    <!-- ################################################################################################ -->
  	<div class="container">
			<div>
                <h1 style="text-align: center;" class="masthead-heading text-uppercase mb-0" >" ยินดีต้อนรับ "</h1>
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

<br><br><br><br><br><br><br>
    
<!-- ################################################################################################ -->

<div>
  <!-- Footer -->
 
  <footer class="footer-02">
    <div class="container">
       
        <div class="row">
            <div class="col-md-4 col-lg-5">
                <div class="row">
                    <div class="col-md-12 col-lg-8 mb-md-0 mb-4" style="margin-top: -25px;">
                      <img  src="https://secretary-science.mju.ac.th/goverment/25570522101243_science_secretary/Doc_25641018111202_626262.png" style="height: 50px; margin: 1rem 0;">
                        <p style="margin-top: -5px; margin-left: 10px; width: 300px; color: #fff;">คณะวิทยาศาสตร์ มหาวิทยาลัยแม่โจ้
                          63 หมู่ 4 ตำบลหนองหาร อำเภอสันทราย จังหวัดเชียงใหม่ 50290
                          โทรศัพท์ : 0 5387 3800, 0 5387 3801 แฟกซ์ : 0 5387 3827</p>
                      
                    </div>
                </div>
            </div>
            <div class="col-md-8 col-lg-7">
                <div class="row">
                    <div class="col-md-3 mb-md-0 mb-4">
                    
                    </div>
                    <div class="col-md-3 mb-md-0 mb-4">
              
                    </div>
                    <div class=" " style="margin-top: -5px; margin-left: 220px; width: 700px; color: #fff;">
                      
                        <ul class="list-unstyled" style="width: 600px;">
              <li>ผู้อำนวยการ โทร 0-5387-3803 </li>
              <li>งานบริหารธุรการ โทร   0-5387-3800,3801</li>
              <li>งานคลังและพัสดุ โทร 0-5387-3815</li>
              <li>งานนโยบายและแผน โทร 0-5387-3817,3818</li>
              <li>งานบริการวิชาการและวิจัย โทร 0-5387-3810,3811</li>
              <li>งานบริการการศึกษาและกิจการนักศึกษา โทร 0-5387-3819,3820</li>
              
            </ul>
                    </div>
                   
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-8">

          <p class="copyright"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This website is made with <i class="ion-ios-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">suphanat</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
        </div>
    </div>
 
 
</footer>



        </div>

<!-- JAVASCRIPTS -->
<script src="layout/scripts/jquery.min.js"></script>
<script src="layout/scripts/jquery.backtotop.js"></script>
<script src="layout/scripts/jquery.mobilemenu.js"></script>
</body>
</html>
