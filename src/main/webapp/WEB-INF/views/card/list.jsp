<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

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
  <base href="<%=basePath%>">
  <meta charset="utf-8">
  <title>卡券</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0">
 	
</head>
<body>	
		<script type="text/javascript">
		 $(function () {
	 		$("#cusotmerTable").DataTable({
	 			 "paging": true,
	 		     "lengthChange": false,
	 		     "searching": false,
	 		     "ordering": true,
	 		     "info": true,
	 		     "select": true,
	 		    "oLanguage": {
	 		    	"sLengthMenu": "每页显示 _MENU_ 条记录", ///设置显示语言 默认英文
	 		    	"sInfo": "当前显示 _START_ 到 _END_ 条，共 _TOTAL_ 条记录", ///设置显示语言 默认英文
	 		    	"sZeroRecords": "对不起，查询不到相关数据！", ///设置显示语言 默认英文
	 		    	},
	 		     "autoWidth": false
	 			
	 		});
	 		
	 		$("#addBtn").click(function (e) {	
	 			window.location.href="${ctx}/wxCard/gotoCreate";
	 		});
			$("#delBtn").click(function (e) {	
				$.ajax({
        		  type: "get",
        		  url: "${ctx}/wxCard/deleteCard?cardId=",
        		  success: function(msg){
        			  window.location.href=window.location.href;
       			   }
        		
        		});
	 		});
		 });
		 
		 
		 function showDetail(id){
			 
			
		 }
	    </script>	
	    
	 <div class="row">
		
  
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">卡券列表</h3>
               <div class="box-tools">
                <div class="input-group input-group-sm" style="width: 150px;">
               		 <button type="button" id="addBtn" class="btn btn-default">新增</button>
               		 
                </div>
              </div>
              
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="cusotmerTable" class="table table-bordered table-hover">
                <thead>
                <tr>
                  <th>卡券ID</th>
                  <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="tl" items="${cardList}">
                   <tr>
	                  <td>${tl}</td>
	                 
	                  <td><a href="${ctx}/wxCard/gotoCardDetail?cardId=${tl}" >查看详情</a>|
	                      <a href="${ctx}/wxCard/deleteCard?cardId=${tl}">删除</a>
	                  
	                  </td>
	                </tr>
                </c:forEach>
              
               
                </tbody>
             
              </table>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->


        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->

 
</body>

</html>