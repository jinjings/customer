<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>微信JS-SDK Demo</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0">
  <link rel="stylesheet" href="http://demo.open.weixin.qq.com/jssdk/css/style.css?ts=1420774989">
</head>
<body ontouchstart="">
<div class="wxapi_container">
   
    <div class="lbox_close wxapi_form">
    
      <h3 id="menu-card">微信卡券接口</h3>
      <span class="desc">批量添加卡券接口</span>
      <button class="btn btn_primary" id="addCard">addCard</button>
      <span class="desc">调起适用于门店的卡券列表并获取用户选择列表</span>
      <button class="btn btn_primary" id="chooseCard">chooseCard</button>
      <span class="desc">查看微信卡包中的卡券接口</span>
      <button class="btn btn_primary" id="openCard">openCard</button>
	  
	    <h3 id="menu-scan">微信扫一扫</h3>
      <span class="desc">调起微信扫一扫接口</span>
      <button class="btn btn_primary" id="scanQRCode0">scanQRCode(微信处理结果)</button>
      <button class="btn btn_primary" id="scanQRCode1">scanQRCode(直接返回结果)</button>
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
        'openCard'
      ]
  });
</script>
<script> 
var t="${t}";
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
	        alert('已添加卡券：' + JSON.stringify(res.cardList));
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
	/*
	  var shareData = {
	    title: '方倍工作室 微信JS-SDK DEMO',
	    desc: '微信JS-SDK,帮助第三方为用户提供更优质的移动web服务',
	    link: 'http://www.cnblogs.com/txw1958/',
	    imgUrl: 'http://mmbiz.qpic.cn/mmbiz/icTdbqWNOwNRt8Qia4lv7k3M9J1SKqKCImxJCt7j9rHYicKDI45jRPBxdzdyREWnk0ia0N5TMnMfth7SdxtzMvVgXg/0'
	  };
	  wx.onMenuShareAppMessage(shareData);
	  wx.onMenuShareTimeline(shareData);
	  */
	});
	// 9 微信原生接口
	// 9.1.1 扫描二维码并返回结果
	document.querySelector('#scanQRCode0').onclick = function () {
	  wx.scanQRCode({
	    desc: 'scanQRCode desc'
	  });
	};
	// 9.1.2 扫描二维码并返回结果
	document.querySelector('#scanQRCode1').onclick = function () {
	  wx.scanQRCode({
	    needResult: 1,
	    desc: 'scanQRCode desc',
	    success: function (res) {
	      alert(JSON.stringify(res));
	    }
	  });
	};
	wx.error(function (res) {
	  alert(res.errMsg);
	});
</script>
</html>