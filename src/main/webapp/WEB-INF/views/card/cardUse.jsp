<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>优惠券使用</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0">
  	<script type="text/javascript" src="${ctx }/adminLTE/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script type="text/javascript">
	
	$(function (){
		/*
		$.ajax({
		  type: "get",
		  url: "http://5065e28.nat123.net/mgr/getOpenid?code=${code}",
		  success: function(msg){
			 alert(msg.datum);
		  }
		
		});
		*/
	})
	
	 $(function () {
	 		
			$("#addCard").click(function (e) {	
				$.ajax({
     		  type: "get",
     		  url: "${ctx}/wxCard/CardUse?code=${code}&cardId=${cardId}",
     		  success: function(msg){
     			  alert(msg);
    		  }
     		
     		});
	 		});
		 });
	</script>
</head>
<body >
<div class="wxapi_container">
   
    <div class="lbox_close wxapi_form">
    
      <h3 id="menu-card">使用详情</h3>
      <span class="desc">确认使用卡券吗？</span>
      <button class="btn btn_primary" id="addCard">addCard</button>

    </div>
  </div>
</body>



</html>