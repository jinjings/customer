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
  <title>领取卡券</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0">
  <link rel="stylesheet" href="http://demo.open.weixin.qq.com/jssdk/css/style.css?ts=1420774989">
</head>
<body >
<div class="wxapi_container">
   
    <div class="lbox_close wxapi_form">
    
      <h3 id="menu-card">微信卡券接口</h3>
      <span class="desc">批量添加卡券接口</span>
      <button class="btn btn_primary" id="addCard">addCard</button>
      <span class="desc">调起适用于门店的卡券列表并获取用户选择列表</span>
      <button class="btn btn_primary" id="chooseCard">chooseCard</button>
      <span class="desc">查看微信卡包中的卡券接口</span>
      <button class="btn btn_primary" id="openCard">openCard</button>
	  
	 <button class="btn btn_primary" id="showOptionMenu">显示菜单</button>
    </div>
  </div>
</body>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"> </script>
<script type="text/javascript" src="http://5065e28.nat123.net/mgr/adminLTE/plugins/jQuery/jquery-2.2.3.min.js"></script>

<script>
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

  wx.config({
      debug: false,
      appId: 'wx7fa6bf82610ab2f1',
      timestamp: ${timestamp},
      nonceStr: '${nonceStr}',
      signature: '${signature}',
      jsApiList: [
        'checkJsApi',
        'onMenuShareTimeline',
        'onMenuShareAppMessage',
        'onMenuShareQQ',
        'onMenuShareWeibo',
        'addCard',
        'chooseCard',
        'scanQRCode',
        'openCard',
        'showOptionMenu'
      ]
  });
</script>
<script> 

wx.ready(function () {
	 
	  var apit= "${cardApiTicket}";
	  // 12 微信卡券接口
	  // 12.1 添加卡券
	  document.querySelector('#addCard').onclick = function () {
		
	    wx.addCard({
	      cardList: [
	        {
	          cardId: '${cardId}',
	         //cardId: 'phhZqw-ShmmhuGBbGzJf8tNteNLA',
	          //cardExt: '{"timestamp": "${cardApiTimestamp}","nonce_str":"${cardSignature}", "signature":"${cardApiTicket}"}'
	          
	          cardExt: '{"timestamp": ${cardApiTimestamp},"nonce_str":"${cardNonceStr}" ,"signature":"${cardSignature}"}'
	        }
	      ],
	      success: function (res) {
	        //alert('已添加卡券：' + JSON.stringify(res.cardList));
	    	$.ajax({
    		  type: "get",
    		  url: "http://5065e28.nat123.net/mgr/wxCard/getCard?t=${t}&cardId="+res.cardList[0]["cardId"],
    		  success: function(msg){
    			  wx.closeWindow();
    		  }
    		
    		});
	      },
	    fail: function (res) {
	        alert(JSON.stringify(res));
	      }
	    });
	  };

	  // 12.2 选择卡券
	  document.querySelector('#chooseCard').onclick = function () {
	    wx.chooseCard({
	      cardSign: '97e9c5e58aab3bdf6fd6150e599d7e5806e5cb91',
	      timestamp: 1417504553,
	      nonceStr: 'k0hGdSXKZEj3Min5',
	      success: function (res) {
	        alert('已选择卡券：' + JSON.stringify(res.cardList));
	      }
	    });
	  };

	  // 12.3 查看卡券
	  document.querySelector('#openCard').onclick = function () {
	    alert('您没有该公众号的卡券无法打开卡券。');
	    wx.openCard({
	      cardList: [
	      ]
	    });
	  };
		
	  // 8.2 显示右上角菜单
	  document.querySelector('#showOptionMenu').onclick = function () {
	    wx.showOptionMenu();
	  };
	  
	});

	wx.error(function (res) {
	  alert(res.errMsg);
	});
</script>
</html>