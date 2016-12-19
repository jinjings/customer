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
        <div class="col-md-12">
          <div class="box box-info">
            <div class="box-header">
              <h3 class="box-title">添加门店
              
              </h3>
              <!-- tools box -->
              <div class="pull-right box-tools">
             	<!-- 
                <button type="button" class="btn btn-info btn-sm" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                  <i class="fa fa-minus"></i></button>
                <button type="button" class="btn btn-info btn-sm" data-widget="remove" data-toggle="tooltip" title="Remove">
                  <i class="fa fa-times"></i></button>
                  -->
              </div>
              <!-- /. tools -->
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <form action="${ctx}/wxCustomer/createCustomer" method="post">
                  <div class="form-group">
                  	<label for="businessName">门店名称</label>
                  	<input type="text" name="businessName"  class="form-control" id="businessName" placeholder="输入门店名称">
               	  </div>
            
                  <div class="form-group">
                  	<label for="branchName">分店名称</label>
                  	<input type="text" name="branchName"  class="form-control" id="branchName" placeholder="输入分店名称">
               	  </div>
               	  <div class="form-group">
                  	<label for="province">省份</label>
                  	<input type="text" name="province"  class="form-control" id="province" placeholder="输入省份">
               	  </div>
               	  <div class="form-group">
                  	<label for="city">城市</label>
                  	<input type="text" name="city"  class="form-control" id="city" placeholder="输入城市">
               	  </div>
               	  <div class="form-group">
                  	<label for="district">地区</label>
                  	<input type="text" name="district"  class="form-control" id="district" placeholder="输入地区">
               	  </div>
               	   <div class="form-group">
                  	<label for="address">详细地址</label>
                  	<input type="text" name="address"  class="form-control" id="address" placeholder="输入详细地址">
               	  </div>
               	  <div class="form-group">
                  	<label for="telephone">电话</label>
                  	<input type="text" name="telephone"  class="form-control" id="telephone" placeholder="输入电话">
               	  </div>
               	  <div class="form-group">
                  	<label for="categories">类型</label>
                  	<input type="text" name="categories"  class="form-control" id="categories" placeholder="输入类型">
               	  </div>
               	  <div class="form-group">
                  	<label for="offsetType">坐标类型</label>
                  	<select  name="offsetType"  class="form-control" id="offsetType" >
                  		<option value="3">百度经纬度</option>
                  		<option value="">火星坐标</option>
                  		<option value="1">sogou经纬度</option>
                  		
                  		<option value="2">mapbar经纬度</option>
                  		<option value="5">GPS坐标</option>
                  		<option value="6">sogou墨卡托坐标</option>
                  	</select>
                  	</div>
                   <div class="form-group">
                  	<label for="longitude">经度</label>
                  	<input type="text" name="longitude"  class="form-control" id="longitude" placeholder="输入类型">
               	  </div>
               	   <div class="form-group">
                  	<label for="latitude">纬度</label>
                  	<input type="text" name="latitude"  class="form-control" id="latitude" placeholder="输入类型">
               	  </div>
               	 
              <div class="box-footer">
              
                <button type="submit" id="saveMenu" class="btn btn-primary">保存</button>
                
              </div>
               	  
              </form>
            </div>
          </div>
         </div>
	 </div>
 <script type="text/javascript">
    
    </script>	
</body>

</html>