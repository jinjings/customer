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
  <title>菜单</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0">
 	
</head>
<body>	
		<script type="text/javascript">
		 $(function () {
	 		$("#messageTable").DataTable({
	 			 "paging": false,
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
	 			window.location.href="${ctx}/templateMessage/gotoCreate";
	 		});
			$("#delBtn").click(function (e) {	
				$.ajax({
        		  type: "get",
        		  url: "${ctx}/templateMessage/deleteTemplate?templateId=",
        		  success: function(msg){
        			 menu=[];
       			    // alert( "Data Saved: " + msg );

                	 $('#tree').treeview({
                         data: menu,         // data is not optional          
                         levels: 2
                      
                     });
       			   }
        		
        		});
	 		});
		 });
	    </script>	
	    
	 <div class="row">
		
  
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">消息模板列表</h3>
               <div class="box-tools">
                <div class="input-group input-group-sm" style="width: 150px;">
               		 <button type="button" id="addBtn" class="btn btn-default">新增</button>
               		  <button type="button" id="delBtn"  class="btn btn-default">删除</button>
                </div>
              </div>
              
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="messageTable" class="table table-bordered table-hover">
                <thead>
                <tr>
                  <th>模板ID</th>
                  <th>模板标题</th>
                  <th>模板所属行业的一级行业</th>
                  <th>模板所属行业的二级行业</th>
                  <th>模板内容</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="tl" items="${templateList}">
                   <tr>
	                  <td>${tl.templateId }</td>
	                  <td>${tl.title }</td>
	                  <td>${tl.primaryIndustry }</td>
	                  <td> ${tl.deputyIndustry }</td>
	                  <td>${tl.content }</td>
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