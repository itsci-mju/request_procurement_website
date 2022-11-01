<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.*,util.*,java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%


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
<html>
<head>
<title>ระบบแจ้งความประสงค์ขอให้จัดซื้อจัดจ้างพัสดุ</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

  	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
   
    
     <!-- link css -->
     <link rel="stylesheet" type="text/css" href="css/layout.css">
     <link rel="stylesheet" type="text/css" href="css/login.css">
     <link rel="stylesheet" type="text/css" href="css/footer.css">
 
    
    <link href='https://css.gg/lock.css' rel='stylesheet'>
    <link href='https://css.gg/mail.css' rel='stylesheet'>
    <link href='https://css.gg/chevron-right.css' rel='stylesheet'>
    <link href='https://css.gg/mail-reply.css' rel='stylesheet'>
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
  	<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-pic js-tilt" data-tilt>
					<img src="images/mju.png" alt="IMG" >
				</div>

				<form class="login100-form validate-form" name="frm" action="login" method="post">
					<span class="login100-form-title">
						ระบบแจ้งความประสงค์ขอให้จัดซื้อจัดจ้างพัสดุ
					</span>

					<div class="wrap-input100 validate-input" data-validate = "Valid email is required:">
						<input class="input100" type="text" name="uname" placeholder="ชื่อผู้ใช้ (MJU)">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<i   class="gg-mail" aria-hidden="true"></i> 
						</span>
					</div>

					<div class="wrap-input100 validate-input" data-validate = "Password is required">
						<input class="input100" type="password" name="pwd" placeholder="รหัสผ่าน">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="gg-lock" aria-hidden="true"></i>
						</span>
					</div>
					
					<div class="container-login100-form-btn">
						<button class="login100-form-btn" Onclick="return check(frm)">เข้าสู่ระบบ</button>
					</div>

				

				
				</form>
			</div>
		</div>

<br>
    
   
  
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div>
  <!-- Footer -->
 <jsp:include page="common/footer.jsp"/>
        </div>

<script type="text/javascript">

function check(frm) {
	var un1 = /^[A-Za-z0-9]{4,30}$/; 
	var password1 = /^[A-Za-z0-9@_]{4,15}$/; 
	//ชื่อผู้ใช้
	if(frm.uname.value == "") {
		alert("กรุณากรอกชื่อผู้ใช้");
		frm.uname.focus();
		return false;
	}
	if(!frm.uname.value.match(un1)){
		alert("กรุณากรอกชื่อผู้ใช้เป็นภาษาอังกฤษและตัวเลข มีตัวอักษร 6-30 เท่านั้น");		
		frm.uname.focus();
		return false;
	}
	
	//รหัส
	if(frm.pwd.value == "") {
		alert("กรุณากรอกรหัสผ่าน");
		frm.pwd.focus();
		return false;
	}
	if(!frm.pwd.value.match(password1)){
		alert("กรุณากรอกรหัสผ่านเป็นภาษาอังกฤษตัวเลขอารบิก และอักขระพิเศษ@_ 4-15ตัว เท่านั้น");
		 frm.pwd.focus();
		return false;
	} 
}
</script> 

<!-- JAVASCRIPTS -->
 	<script src="js/jquery.min.js"></script>
  	<script src="js/jquery.backtotop.js"></script>
  	<script src="js/jquery.mobilemenu.js"></script>

</body>
</html>