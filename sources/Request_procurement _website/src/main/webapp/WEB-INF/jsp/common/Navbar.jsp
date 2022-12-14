<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.*,util.*,java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
Login l = (Login) session.getAttribute("login");
String username = (String) session.getAttribute("username"); 
String mjName = (String) session.getAttribute("majorName");  
String staffname = (String) session.getAttribute("staffname");  
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
       
        <link rel="stylesheet" href="css/navbar.css">
        
        <link rel="stylesheet" href="js/scripts.js">
        <link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
        
    
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
   
   		<link href='https://css.gg/user-remove.css' rel='stylesheet'>
   		<link href='https://css.gg/user.css' rel='stylesheet'>
   		<link href='https://css.gg/phone.css' rel='stylesheet'>
   		
    </head>
   
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Kanit:wght@200&display=swap');

a{text-decoration:none;}
</style>
<body> 
        <!-- Navigation-->
    
<div class="wrapper row0" style="width: 100%;max-width:100%;height:auto;">
  <div id="topbar" class="hoc clear" > 
    <!-- ################################################################################################ -->
    <table style="width: 100%;max-width:100%;height:auto;">
        <tbody>
           <tr>
            <td style=" width: 90px ;max-width:100%;height:auto;" >
              <img src="images/mju.png" alt="IMG" style=" height:80px ; width: 90px ; margin-left: 50px;">
            
            </td>
            <td style="vertical-align: middle;padding-left: 0.75rem;max-width:100%;height:auto;">
              <div style="width:auto">
                <span  style="color: #017f3f; font-size: 2rem; font-weight: 700; margin-left: 50px;"> 
                  ?????????????????????????????????????????? ???????????????????????????????????????????????????
                </span>
               </div>

               <div style="width:auto;max-width:100%;height:auto;">
                <span style="    font-size: 1.2rem;
                color: rgba(0,0,0,0.7); font-weight: 700; margin-left: 50px;">Faculty of Science, Maejo University</span>
               </div>
            </td>
            <%
			if (l != null) {%>
			<% if(mjName.equals("?????????????????????????????????")){ %>
			<td style="width:350px">
			<h3 class="" style="font-size: 1.2rem; ;font-weight: 700;color: #017f3f; ">?????????????????? : <%= staffname %>  &nbsp; ????????????????????? : <%= mjName %> </h3>
			</td>
				<%}else {%>
				<td style="width:350px">
			<h3 class="" style="font-size: 1.2rem; ;font-weight: 700;color: #017f3f; ">?????????????????? : <%= staffname %>  &nbsp; ???????????? : <%= mjName %> </h3>
			</td>
			<%}%>
			<%}%>
            <td ><%	if (l != null) {%>
			 <a href="logout"><h3 class="login-hover" style="width:200px;font-size: 1.2rem; background-color: #017f3f;font-weight: 700; ">?????????????????????????????? &nbsp;<i class="gg-user-remove"></i></h3></a>  	
             <%
			} else {
			%>
              <a href="loadlogin"><h3 class="login-hover" style="width:200px;font-size: 1.2rem;background-color: #017f3f; font-weight: 700; ">????????????????????????????????? &nbsp;<i class="gg-user"></i></h3></a>
            </td>
		<%}%>
           </tr>
        </tbody>
   
    </table>  
     <!--    <li><a href="index.html"><i class="fa fa-lg fa-home"></i></a></li>
     
      <li><a href="#" title="Login"><i class="fa fa-lg fa-sign-in"></i></a></li>
      <li><a href="#" title="Sign Up"><i class="fa fa-lg fa-edit"></i></a></li>
      ################################################################################################ -->
  </div>
</div> 
	
	<div class="wrapper row1">
  <header id="header" class="hoc clear">
  
    <nav id="mainav" style="margin-top: -50px"> 
      <!-- ################################################################################################ -->
      <ul class="clear" style="text-align: left; margin-left:80px">
      <%if (l != null) {%>
		
        <li class="active"><a href="loadpagelistorder">?????????????????????</a></li>
      
      
        <li><a class="" href="loadpagelistrequestHistory">????????????????????????????????????????????????????????????????????????</a>
        
        <%}%>
        <li><a  class="" href="http://www.science.mju.ac.th/role/role.html">?????????????????? </a>
        </li>
        
      </ul>
      <!-- ################################################################################################ -->
    </nav>
  </header>
</div>
	
  
</body>
</html>