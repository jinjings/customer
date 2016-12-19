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
	 $('#file-logo').fileinput({
        language: 'zh',
        uploadUrl: '${ctx}/wxCard/uplaodImg',
        allowedFileExtensions : ['jpg', 'png']
    }).on("fileuploaded", function(event, data) {
    	
        if(data.response)
        {
            $("#logoUrl").val((data.response["url"]));
        }
    });
	 
	 
	 
	 function formatState (state) {
		  if (!state.id) { return state.text; }
		  var $state = $(
		    //'<span><img src="vendor/images/flags/' + state.element.value.toLowerCase() + '.png" class="img-flag" /> ' + state.text + '</span>'
		    '<div style="background:'+state.text+';width:30px;height:10px"></div>'
		  );
		  return $state;
		};

		$("#bc").select2({
		  templateResult: formatState
		});
		
	    $('#begin_timestamp').datepicker({format:"yyyy-mm-dd",language: 'zh-CN'});
		$('#end_timestamp').datepicker({format:"yyyy-mm-dd",language: 'zh-CN'});
		  
		$("#fixed_term_div").hide();		
		$("#fixed_begin_term_div").hide();
		
		
		$("#deal_detail_div").hide();		
		$("#least_cost_div").hide();
		$("#reduce_cost_div").hide();		
		$("#discount_div").hide();		
		$("#gift_div").hide();		
		$("#default_detail_div").hide();

 });

	function showTimeRange(t){
		if(t.value=="DATE_TYPE_FIX_TERM"){
			$("#fixed_term_div").show();		
			$("#fixed_begin_term_div").show();
			
			$("#begin_timestamp_div").hide();
		}else{
			$("#fixed_term_div").hide();		
			$("#fixed_begin_term_div").hide();
			
			$("#begin_timestamp_div").show();
		}
		
	}
	
	function cardTypeChange(t){
		if(t.value=="GROUPON"){
			$("#deal_detail_div").show();
			
			$("#least_cost_div").hide();
			$("#reduce_cost_div").hide();
			
			$("#discount_div").hide();
			
			$("#gift_div").hide();
			
			$("#default_detail_div").hide();
			
		}else if(t.value=="CASH"){
			$("#deal_detail_div").hide();
			
			$("#least_cost_div").show();
			$("#reduce_cost_div").show();
			
			$("#discount_div").hide();
			
			$("#gift_div").hide();
			
			$("#default_detail_div").hide();
			
		}else if(t.value=="DISCOUNT"){
			
			$("#deal_detail_div").hide();
			
			$("#least_cost_div").hide();
			$("#reduce_cost_div").hide();
			
			$("#discount_div").show();
			
			$("#gift_div").hide();
			
			$("#default_detail_div").hide();
			
		}else if(t.value=="GIFT"){
			$("#deal_detail_div").hide();
			
			$("#least_cost_div").hide();
			$("#reduce_cost_div").hide();
			
			$("#discount_div").hide();
			
			$("#gift_div").show();
			
			$("#default_detail_div").hide();
			
		}else if(t.value=="GENERAL_COUPON"){
			$("#deal_detail_div").hide();
			
			$("#least_cost_div").hide();
			$("#reduce_cost_div").hide();
			
			$("#discount_div").hide();
			
			$("#gift_div").hide();
			
			$("#default_detail_div").show();
			
		}else{
			$("#deal_detail_div").hide();
			
			$("#least_cost_div").hide();
			$("#reduce_cost_div").hide();
			
			$("#discount_div").hide();
			
			$("#gift_div").hide();
			
			$("#default_detail_div").hide();
		}
		
	}
</script>	
	
	 <div class="row">
        <div class="col-md-12">
          <div class="box box-info">
            <div class="box-header">
              <h3 class="box-title">添加卡券
            
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
            <div class="box-body pad">
              <form action="${ctx}/wxCard/createCard" method="post" >
                   <div class="form-group">
                  	<label for="file-logo">logo</label>
                    <input id="file-logo" name="logo" type="file" class="form-control"/>
                    <input name="logo_url" type="text" id="logoUrl" value="http://mmbiz.qpic.cn/mmbiz_png/6q0UOILW9zzdgJTqlffibPN4I5ZG6cmQVyvft04x1yicB4odMHkKoliceCd7I0V3dUTg1l74q0oIpnUQxH4KndUSw/0"/>
               	   </div>
               	   <div class="form-group">
               	     <label for="bc">背景颜色</label>
               	     <select id="bc" name="color" class="form-control">
               	    	<option></option>
               	    	<option value="Color010">#63b359</option>
               	    	<option value="Color020">#2c9f67</option>
               	    	<option value="Color030">#509fc9</option>
               	    	<option value="Color040">#5885cf</option>
               	    	<option value="Color050">#9062c0</option>
               	    	<option value="Color060">#d09a45</option>
               	    	<option value="Color070">#e4b138</option>
               	    	<option value="Color080">#ee903c</option>
               	    	<option value="Color081">#f08500</option>
               	    	<option value="Color082">#a9d92d</option>
               	    	<option value="Color090">#dd6549</option>
               	    	<option value="Color100">#cc463d</option>
               	    	<option value="Color101">#cf3e36</option>
               	    	<option value="Color102">#5E6671</option>
               	    	
               	    </select>
               	  </div>
               	  
               	   <div class="form-group">
               	     <label for="card_type">类型</label>
               	     <select id="card_type" name="card_type" class="form-control" onchange="cardTypeChange(this)">
               	     	<option></option>
               	    	<option value="GROUPON">团购券</option>
               	    	<option value="CASH">代金券</option>
               	    	<option value="DISCOUNT">折扣券</option>
               	    	<option value="GIFT">兑换券</option>
               	    	<option value="GENERAL_COUPON">优惠券</option>
               	    </select>
               	  </div>
               	  <div class="form-group" id="deal_detail_div">
               	     <label for="deal_detail">团购详情</label>
               	     <input type="text" name="deal_detail" id="deal_detail" class="form-control" placeholder="Enter ...">               	  
               	  </div>
               	  
               	  <div class="form-group" id="least_cost_div">
               	     <label for="title">起用金额</label>
               	     <input type="text" name="least_cost" id="least_cost" class="form-control" placeholder="Enter ...">              	  
               	  </div>
               	   <div class="form-group" id="reduce_cost_div">
               	     <label for="reduce_cost">减免金额</label>
               	     <input type="text" name="reduce_cost" id="reduce_cost" class="form-control" placeholder="Enter ...">               	  
               	  </div>
               	  
               	   <div class="form-group" id="discount_div">
               	     <label for="discount">打折额度</label>
               	     <input type="text" name="discount" id="discount" class="form-control" placeholder="Enter ...">              	  
               	  </div>
               	  
               	  <div class="form-group" id="gift_div">
               	     <label for="gift">兑换内容</label>
               	     <input type="text" name="gift" id="gift" class="form-control" placeholder="Enter ...">              	  
               	  </div>
               	  
               	   <div class="form-group" id="default_detail_div">
               	     <label for="default_detail">优惠详情</label>
               	     <input type="text" name="default_detail" id="default_detail" class="form-control" placeholder="Enter ...">              	  
               	  </div>
               	  
               	  
               	  
               	  
               	  <div class="form-group">
               	     <label for="brand_name">商户名称</label>
               	     <input type="text" name="brand_name" id="brand_name" class="form-control" placeholder="Enter ...">              	  
               	  </div>
               	   <div class="form-group">
               	     <label for="service_phone">客服电话</label>
               	     <input type="text" name="service_phone" id="service_phone" class="form-control" placeholder="Enter ...">              	  
               	  </div>
               	  <div class="form-group">
               	     <label for="code_type">码型</label>
	               	   <select id="code_type" name="code_type" class="form-control">
	               	     
	               	    	<option value="CODE_TYPE_TEXT">文本</option>
	               	    	<option value="CODE_TYPE_BARCODE">一维码</option>
	               	    	<option value="CODE_TYPE_QRCODE">二维码</option>
	               	    	<option value="CODE_TYPE_ONLY_QRCODE">二维码无code显示</option>
	               	    	<option value="CODE_TYPE_ONLY_BARCODE">一维码无code显示</option>
	               	    	<option value="CODE_TYPE_NONE">不显示code和条形码类型</option>
	               	    </select>
               	  
               	  </div>
               	  <div class="form-group">
               	     <label for="title">卡券名称</label>
               	     <input type="text" name="title" id="title" class="form-control" placeholder="Enter ...">
               	  
               	  </div>
               	  <div class="form-group">
               	     <label for="businessnoticeName">使用提醒</label>
               	     <input type="text" name="notice" id="notice" class="form-control" placeholder="Enter ...">
               	  
               	  </div>
               	   <div class="form-group">
               	     <label for="description">使用说明</label>
               	     <input type="text" name="description" id="description" class="form-control" placeholder="Enter ...">
               	  
               	  </div>
             
               	  <div class="form-group">
               	     <label for="quantity">库存数量</label>
               	     <input type="text" name="quantity" id="quantity" class="form-control" placeholder="Enter ...">
               	  
               	  </div>
               	  
               	  
               	    <div class="form-group">
               	     <label for="code_type">有效期类型</label>
	               	   <select id="type" name="type" class="form-control" onchange="showTimeRange(this)">
	               	     
	               	    	<option value="DATE_TYPE_FIX_TIME_RANGE">固定日期区间</option>
	               	    	<option value="DATE_TYPE_FIX_TERM">固定时长</option>
	               	    
	               	    </select>
               	  
               	  </div>
               	  
               	  <div class="form-group" id="begin_timestamp_div" >
               	     <label for="begin_timestamp">开始时间</label>
               	     <input type="text" name="begin_timestamp" id="begin_timestamp" class="form-control pull-right" placeholder="Enter ...">
               	  
               	  </div>
               	 
               	  <div class="form-group"  id="fixed_term_div">
               	     <label for="fixed_term">有效天数</label>
               	     <input type="text" name="fixed_term" id="fixed_term" class="form-control" placeholder="Enter ...">
               	  
               	  </div>
               	  
               	   <div class="form-group" id="fixed_begin_term_div">
               	     <label for="fixed_begin_term">生效天数</label>
               	     <input type="text" name="fixed_begin_term" id="fixed_begin_term" class="form-control" placeholder="Enter ...">
               	  
               	  </div>
               	  
               	   <div class="form-group">
               	     <label for="end_timestamp">结束时间</label>
               	     <input type="text" name="end_timestamp" id="end_timestamp" class="form-control pull-right" placeholder="Enter ...">
               	  
               	  </div>
               	  <div class="form-group" >
               	     <label for="source">第三方来源名</label>
               	     <input type="text" name="source" id="source" class="form-control" placeholder="Enter ...">
               	  
               	  </div>
               	 
               	  <div class="form-group" >
               	     <label for="center_title">卡券顶部居中的按钮</label>
               	     <input type="text" name="center_title" id="center_title" class="form-control" placeholder="Enter ...">              	  
               	  </div>
               	  <div class="form-group" >
               	     <label for="center_sub_title">显示在入口下方的提示语</label>
               	     <input type="text" name="center_sub_title" id="center_sub_title" class="form-control" placeholder="Enter ...">              	  
               	  </div>
               	   <div class="form-group" >
               	     <label for="center_url">顶部居中的url</label>
               	     <input type="text" name="center_url" id="center_url" class="form-control" placeholder="Enter ...">              	  
               	  </div> 
               	  
               	    <div class="form-group"  >
               	     <label for="custom_url_name">跳转外链的入口名字</label>
               	     <input type="text" name="custom_url_name" id="custom_url_name" class="form-control" placeholder="Enter ...">
               	  
               	  </div>
               	  <div class="form-group" >
               	     <label for="custom_url">自定义跳转的URL</label>
               	     <input type="text" name="custom_url" id="custom_url" class="form-control" placeholder="Enter ...">              	  
               	  </div> 
               	  <div class="form-group" >
               	     <label for="custom_url_sub_title">显示在入口右侧的提示语</label>
               	     <input type="text" name="custom_url_sub_title" id="custom_url_sub_title" class="form-control" placeholder="Enter ...">              	  
               	  </div> 
               	  <div class="form-group" >
               	     <label for="promotion_url_name">营销场景的自定义入口名称</label>
               	     <input type="text" name="promotion_url_name" id="promotion_url_name" class="form-control" placeholder="Enter ...">              	  
               	  </div> 
               	  <div class="form-group" >
               	     <label for="promotion_url">入口跳转外链的地址链接</label>
               	     <input type="text" name="promotion_url" id="promotion_url" class="form-control" placeholder="Enter ...">              	  
               	  </div> 
               	   <div class="form-group" >
               	     <label for="promotion_url_sub_title">显示在营销入口右侧的提示语</label>
               	     <input type="text" name="promotion_url_sub_title" id="promotion_url_sub_title" class="form-control" placeholder="Enter ...">              	  
               	  </div> 
               	   <div class="form-group" >
               	     <label for="get_limit">每人可领券的数量限制,不填写默认为50</label>
               	     <input type="text" name="get_limit" id="get_limit" class="form-control" placeholder="Enter ...">              	  
               	  </div> 
               	  <div class="form-group" >
               	     <label for="can_share">卡券领取页面是否可分享</label>
               	   	 <select id="can_share" name="can_share" class="form-control">
	               	     	<option value="true">是</option>
	               	    	<option value="false">否</option>	               	  	               	    	
	               	    </select>  	  
               	  </div> 
               	    <div class="form-group" >
               	     <label for="can_give_friend">卡券是否可转赠</label>
               	     <select id="can_give_friend" name="can_give_friend" class="form-control">
	               	     	<option value="true">是</option>
	               	    	<option value="false">否</option>	               	  	               	    	
	               	    </select>  	  
               	  </div> 
               	  
               	  
               	   <div class="box-footer">
              
	                <button type="submit" id="saveCard" class="btn btn-primary">保存</button>
	                
	              </div>
               	  
              </form>
            </div>
          </div>
         </div>
	 </div>

</body>

</html>