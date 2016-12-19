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
	 		$("#mediaTable").DataTable({
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
	 		    	"processing": true, //打开数据加载时的等待效果  
	 		        "serverSide": true,//打开后台分页  
	 		       "ajax": {  
	 		            "url": "${ctx}/wxMedia/getList",   
	 		            "dataSrc": "listData",   
	 		            "data": function ( d ) {  
	 		                var mediaType =$("#mediaType").val();  
	 		                //添加额外的参数传给服务器


	 		                d.mediaType = mediaType;  
	 		            }  
	 		        },
	 		       "columns": [  
		                  { "data": "mediaId" },  
		                  { "data": "name" }, 
		                  { "data": "updateTime" }, 
		                  { "data": "url" }
		              ],
	 		     "autoWidth": false
	 			
	 		});
	 		
	 		$("#addBtn").click(function (e) {	
	 			window.location.href="${ctx}/wxMedia/gotoAddNews";
	 		});
	 		$("#addOtherBtn").click(function (e) {	
	 			window.location.href="${ctx}/wxMedia/gotoUpload";
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
		 
		 
		 function showDetail(id){
			 
			
		 }
	    </script>	
	    
	 <div class="row">
		
  
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">卡券列表</h3>
               <div class="box-tools">
                <div class="input-group input-group-sm">
               		
               		 <button type="button" id="addBtn" class="btn btn-default">新增图文</button>
               		 <button type="button" id="addOtherBtn" class="btn btn-default">新增其他</button>
               		 
                </div>
              </div>
              
            </div>
            <!-- /.box-header -->
            <div class="box-body">
            	<div class="form-group"> 
            	
	            	<label for="starttime" class="col-sm-2 control-label">素材类型</label> 
	            	<div class="col-md-4"> 
						<select name="mediaType" id="mediaType">
							<option value="image">图片</option>
							<option value="video">视频</option>
							<option value="voice">语音</option>
							<option value="thumb">缩略图</option>
							<option value="news">图文</option>
						</select>
	            	</div>	
           		 </div>
              <table id="mediaTable" class="table table-bordered table-hover">
                <thead>
                <tr>
                  <th>卡券ID</th>
                  <th>素材名称</th>
                  <th>床架时间</th>
                  <th>URL</th>
                </tr>
                </thead>
             
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