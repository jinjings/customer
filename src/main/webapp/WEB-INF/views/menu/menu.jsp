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

	 <div class="row">
	  <div class="col-md-3">
		<div id="tree"></div>
	  </div>
	  <!-- left column -->
        <div class="col-md-9">
          <!-- general form elements -->
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">添加菜单</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form role="form">
              <div class="box-body">
             	
                <div class="form-group">
                  <label for="name">名称</label>
                  <input type="text" name="name"  class="form-control" id="name" placeholder="输入名称">
                </div>
             
                <div class="form-group">
                  <label for="url">url</label>
                  <input type="text" name="url" class="form-control" id="url" placeholder="输入类型">
                </div>
                
                 <div class="form-group">
                  <label for="type">事件</label>
                  <select class="form-control" name="type" id="type">
                    <option value="click">click</option>
                    <option value="view">view</option>
                    <option value="scancode_push">scancode_push</option>
                    <option value="scancode_waitmsg">scancode_waitmsg</option>
                    <option value="pic_photo_or_album">pic_photo_or_album</option>
                    <option value="pic_weixin">pic_weixin</option>
                    <option value="pic_sysphoto">pic_sysphoto</option>
                    <option value="location_select">location_select</option>                    
                    <option value="media_id">media_id</option>  
                    <option value="view_limited">view_limited</option>  
                  </select>
                </div>
                
                <div class="form-group">
                  <label for="key">key</label>
                  <input type="text" name="key" class="form-control" id="key" placeholder="输入key">
                </div>
                
                 <div class="form-group">
                  <label for="media_id">素材</label>
                  <input type="text" name="media_id" class="form-control" id="media_id" placeholder="输入素材id">
                </div>
              </div>
              
            
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="button" id="addMenuOne" class="btn  btn-primary btn-sm">添加一级菜单</button>
	            <button type="button" id="addMenuTow" class="btn  btn-primary btn-sm">添加二级菜单</button>
	            <button type="button" id="delMenu" class="btn  btn-primary btn-sm">删除</button>
                <button type="button" id="saveMenu" class="btn btn-primary">保存</button>
               
              </div>
            </form>
          </div>
	 	</div>
	 </div>
 <script type="text/javascript">
    var data =jQuery.parseJSON('${menuJsonStr}');
    var menu =[];
    if(data["menu"]){
    	menu =data["menu"]["button"];
    }
    $(function () {
       
        var obj = {};
   
        $('#tree').treeview({
            data: menu,         // data is not optional          
            levels: 2
         
        });
		
        $("#addMenuOne").click(function (e) {
        	
        	var obj = {};
        	obj["text"]=$("#name").val();
        	obj["type"]=$("#type").val();
        	
        	obj["type"]=$("#type").val();
        	if($("#url").val()!=""){
        		obj["url"]=$("#url").val();
        	}
        	
        	obj["nodes"]=[];
        	obj["key"]=$("#key").val();
        	if($("#media_id").val()!=""){
        		obj["media_id"]=$("#media_id").val();
        	}
        	
        	menu[menu.length] = obj;
        	
        	 $('#tree').treeview({
                 data: menu,         // data is not optional          
                 levels: 2
              
             });
        
        })
        
       $("#addMenuTow").click(function (e) {
    		var arr = $('#tree').treeview('getSelected');
    		if(arr && arr[0]){
    			
    			var obj = {};
            	obj["text"]=$("#name").val();
            	obj["type"]=$("#type").val();
            	if($("#url").val()!=""){
            		obj["url"]=$("#url").val();
            	}
            	obj["type"]=$("#type").val();
            	obj["key"]=$("#key").val();
            	if($("#media_id").val()!=""){
            		obj["media_id"]=$("#media_id").val();
            	}
            	
                if(arr[0]["nodes"]){
                	for(var i=0;i<menu.length;i++){
                		if(menu[i]["text"]==arr[0]["text"]){
                			menu[i]["nodes"][menu[i]["nodes"].length] = obj;
                		}
                	
                		
                	}
                	
                }else{
                	arr[0]["nodes"][0] = obj;
                }
                
                $('#tree').treeview({
                    data: menu,         // data is not optional          
                    levels: 2
                 
                });
    			
    		}else{
    			alert("请选择一级菜单");
    		}
        
           
        })
        
      
      $("#saveMenu").click(function (e) {

      	$.ajax({
      		  type: "post",
      		  url: "${ctx}/wxMenu/createMenu",
      		  data:"q="+JSON.stringify(menu),
      		  success: function(msg){    			
   			     alert( "Data Saved: " + msg );  			 
   			   }
      		
      		});
      })
      
      
        $("#delMenu").click(function (e) {

        	$.ajax({
        		  type: "get",
        		  url: "${ctx}/wxMenu/deleteMenu",
        		  success: function(msg){
        			 menu=[];
       			    // alert( "Data Saved: " + msg );

                	 $('#tree').treeview({
                         data: menu,         // data is not optional          
                         levels: 2
                      
                     });
       			   }
        		
        		});
        })
        
        
        

    })
    </script>	
</body>

</html>