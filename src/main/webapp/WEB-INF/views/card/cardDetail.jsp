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
 var card_type = "${card.card_type}";
 
 var type = "${card.type}";
 $(function () {
	 
	 //按照券的类型显示
	 if(card_type=="GROUPON"){
			$("#deal_detail_div").show();
			
			$("#least_cost_div").hide();
			$("#reduce_cost_div").hide();
			
			$("#discount_div").hide();
			
			$("#gift_div").hide();
			
			$("#default_detail_div").hide();
			
			$("card_type").val("团购券");
			
		}else if(card_type=="CASH"){
			$("#deal_detail_div").hide();
			
			$("#least_cost_div").show();
			$("#reduce_cost_div").show();
			
			$("#discount_div").hide();
			
			$("#gift_div").hide();
			
			$("#default_detail_div").hide();
			$("card_type").val("代金券");
		}else if(card_type=="DISCOUNT"){
			
			$("#deal_detail_div").hide();
			
			$("#least_cost_div").hide();
			$("#reduce_cost_div").hide();
			
			$("#discount_div").show();
			
			$("#gift_div").hide();
			
			$("#default_detail_div").hide();
			$("card_type").val("折扣券");
		}else if(card_type=="GIFT"){
			$("#deal_detail_div").hide();
			
			$("#least_cost_div").hide();
			$("#reduce_cost_div").hide();
			
			$("#discount_div").hide();
			
			$("#gift_div").show();
			
			$("#default_detail_div").hide();
			$("card_type").val("兑换券");
			
		}else if(card_type=="GENERAL_COUPON"){
			$("#deal_detail_div").hide();
			
			$("#least_cost_div").hide();
			$("#reduce_cost_div").hide();
			
			$("#discount_div").hide();
			
			$("#gift_div").hide();
			
			$("#default_detail_div").show();
			$("card_type").val("优惠券");
		}else{
			$("#deal_detail_div").hide();
			
			$("#least_cost_div").hide();
			$("#reduce_cost_div").hide();
			
			$("#discount_div").hide();
			
			$("#gift_div").hide();
			
			$("#default_detail_div").hide();
			$("card_type").val("");
		}
	 
	 
	  if(type=="DATE_TYPE_FIX_TERM"){
			$("#fixed_term_div").show();		
			$("#fixed_begin_term_div").show();
			
			$("#begin_timestamp_div").hide();
			
			$("#type").val("固定时长,自领取后按天算.");
		}else{
			$("#fixed_term_div").hide();		
			$("#fixed_begin_term_div").hide();
			
			$("#begin_timestamp_div").show();
			
			$("#type").val("固定日期区间");
		}
	 
 })
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
                  		<img src="${card.logo_url }"></img>
                   </div>
               	   <div class="form-group">
               	     <label for="bc">背景颜色</label>
               	     <input type="text" value="${card.color }" class="form-control" readonly="readonly"/>   
               	  </div>
               	  
               	   <div class="form-group">
               	     <label for="card_type">类型</label>
               	     <input type="text" value="${card.card_type }" id="card_type" class="form-control" readonly="readonly"/>  
               	  </div>
               	  <div class="form-group" id="deal_detail_div">
               	     <label for="deal_detail">团购详情</label>
               	     <input type="text" value="${card.deal_detail}"  class="form-control"readonly="readonly"/>               	  
               	  </div>
               	  
               	  <div class="form-group" id="least_cost_div">
               	     <label for="title">起用金额</label>
               	     <input type="text" value="${card.least_cost}"  class="form-control" readonly="readonly"/>              	  
               	  </div>
               	   <div class="form-group" id="reduce_cost_div">
               	     <label for="reduce_cost">减免金额</label>
               	     <input type="text" value="${card.reduce_cost}"  class="form-control" readonly="readonly"/>               	  
               	  </div>
               	  
               	   <div class="form-group" id="discount_div">
               	     <label for="discount">打折额度</label>
               	     <input type="text" value="${card.discount}"  class="form-control" readonly="readonly"/>              	  
               	  </div>
               	  
               	  <div class="form-group" id="gift_div">
               	     <label for="gift">兑换内容</label>
               	     <input type="text" value="${card.gift}"  class="form-control" readonly="readonly" />              	  
               	  </div>
               	  
               	   <div class="form-group" id="default_detail_div">
               	     <label for="default_detail">优惠详情</label>
               	     <input type="text" value="${card.default_detail}" id="default_detail" class="form-control"  readonly="readonly" />              	  
               	  </div>
               	  
               	  
               	  
               	  
               	  <div class="form-group">
               	     <label for="brand_name">商户名称</label>
               	     <input type="text" value="${card.brand_name}"  class="form-control" readonly="readonly" />              	  
               	  </div>
               	   <div class="form-group">
               	     <label for="service_phone">客服电话</label>
               	     <input type="text" value="${card.service_phone}" class="form-control" readonly="readonly" />              	  
               	  </div>
               	  <div class="form-group">
               	     <label for="code_type">码型</label>             	     
               	      <input type="text" value="${card.code_type}" class="form-control" readonly="readonly" />              	  
              	  </div>
               	  <div class="form-group">
               	     <label for="title">卡券名称</label>
               	     <input type="text" value="${card.title}" class="form-control" readonly="readonly" />
               	  
               	  </div>
               	  <div class="form-group">
               	     <label for="businessnoticeName">使用提醒</label>
               	     <input type="text" value="${card.notice}" class="form-control"  readonly="readonly" />
               	  
               	  </div>
               	   <div class="form-group">
               	     <label for="description">使用说明</label>
               	     <input type="text" value="${card.description}"  class="form-control" readonly="readonly"  />
               	  
               	  </div>
             
               	  <div class="form-group">
               	     <label for="quantity">库存数量</label>
               	     <input type="text" value="${card.quantity}" class="form-control" readonly="readonly" />
               	  
               	  </div>
               	  
               	   <div class="form-group">
               	     <label for="total_quantity">库存数量</label>
               	     <input type="text" value="${card.total_quantity}" class="form-control" readonly="readonly" />
               	  
               	  </div>
               	
               	  
               	    <div class="form-group">
               	     <label for="code_type">有效期类型</label>
               	      <input type="text" value="${card.type}" id="type" class="form-control" readonly="readonly" />
	               	 
               	  
               	  </div>
               	  
               	  <div class="form-group" id="begin_timestamp_div" >
               	     <label for="begin_timestamp">开始时间</label>
               	     <input type="text" value="${card.begin_timestamp}"  class="form-control pull-right"  readonly="readonly" />
               	  
               	  </div>
               	 
               	  <div class="form-group"  id="fixed_term_div">
               	     <label for="fixed_term">有效天数</label>
               	     <input type="text" value="${card.fixed_term}"  class="form-control"  readonly="readonly" />
               	  
               	  </div>
               	  
               	   <div class="form-group" id="fixed_begin_term_div">
               	     <label for="fixed_begin_term">生效天数</label>
               	     <input type="text" value="${card.fixed_begin_term}"  class="form-control" readonly="readonly" />
               	  
               	  </div>
               	  
               	   <div class="form-group">
               	     <label for="end_timestamp">结束时间</label>
               	     <input type="text" value="${card.end_timestamp}" class="form-control pull-right" readonly="readonly" />
               	  
               	  </div>
               	  <div class="form-group" >
               	     <label for="source">第三方来源名</label>
               	     <input type="text" value="${card.source}"  class="form-control"  readonly="readonly" />
               	  
               	  </div>
               	   <div class="form-group"  >
               	     <label for="custom_url_name">跳转外链的入口名字</label>
               	     <input type="text" value="${card.custom_url_name}"  class="form-control" readonly="readonly"  />
               	  
               	  </div>
               	  <div class="form-group" >
               	     <label for="center_title">卡券顶部居中的按钮</label>
               	     <input type="text" value="${card.center_title}"  class="form-control" readonly="readonly"  />              	  
               	  </div>
               	  <div class="form-group" >
               	     <label for="center_sub_title">显示在入口下方的提示语</label>
               	     <input type="text" value="${card.center_sub_title}"  class="form-control" readonly="readonly"  />              	  
               	  </div>
               	   <div class="form-group" >
               	     <label for="center_url">顶部居中的url</label>
               	     <input type="text" value="${card.center_url}"  class="form-control" readonly="readonly"  />              	  
               	  </div> 
               	  <div class="form-group" >
               	     <label for="custom_url">自定义跳转的URL</label>
               	     <input type="text" value="${card.custom_url}"  class="form-control" readonly="readonly" />              	  
               	  </div> 
               	  <div class="form-group" >
               	     <label for="custom_url_sub_title">显示在入口右侧的提示语</label>
               	     <input type="text" value="${card.custom_url_sub_title}"  class="form-control" readonly="readonly"  />              	  
               	  </div> 
               	  <div class="form-group" >
               	     <label for="promotion_url_name">营销场景的自定义入口名称</label>
               	     <input type="text" value="${card.promotion_url_name}"  class="form-control"  readonly="readonly" >              	  
               	  </div> 
               	  <div class="form-group" >
               	     <label for="promotion_url">入口跳转外链的地址链接</label>
               	     <input type="text" value="${card.promotion_url}"  class="form-control"  readonly="readonly" >              	  
               	  </div> 
               	   <div class="form-group" >
               	     <label for="promotion_url_sub_title">显示在营销入口右侧的提示语</label>
               	     <input type="text" value="${card.promotion_url_sub_title}"  class="form-control"  readonly="readonly" />              	  
               	  </div> 
               	   <div class="form-group" >
               	     <label for="get_limit">每人可领券的数量限制,不填写默认为50</label>
               	     <input type="text" value="${card.get_limit}"  class="form-control" readonly="readonly" />              	  
               	  </div> 
               	  <div class="form-group" >
               	     <label for="can_share">卡券领取页面是否可分享</label>
               	      <input type="text" value="${card.can_share?"是":"否"}"  class="form-control" readonly="readonly" />         
               	   	
               	  </div> 
               	    <div class="form-group" >
               	     <label for="can_give_friend">卡券是否可转赠</label>
               	     <input type="text" value="${card.can_give_friend?"是":"否"}"  class="form-control" readonly="readonly" />     
               	  </div> 
               	  
               	  
               	 
              </form>
            </div>
          </div>
         </div>
	 </div>

</body>

</html>