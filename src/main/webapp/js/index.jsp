<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<meta charset="utf-8">

	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0">
	<link rel="stylesheet" href="http://demo.open.weixin.qq.com/jssdk/css/style.css?ts=1420774989">
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>

	<script  type="text/javascript">
	wx.config({
		debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		appId: 'wxb60f3a76da39dfc1', // 必填，公众号的唯一标识
		timestamp:'${cardApiTimestamp}',// 必填，生成签名的时间戳
		nonceStr: '${cardNonceStr}', // 必填，生成签名的随机串
		signature: '${cardSignature}',// 必填，签名，见附录1
		jsApiList: [
			'menuItem:share:appMessage',
			'menuItem:share:timeline'
		] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});
	wx.checkJsApi({
		jsApiList: ['chooseImage'], // 需要检测的JS接口列表，所有JS接口列表见附录2,
		success: function(res) {
			// 以键值对的形式返回，可用的api值true，不可用为false
			// 如：{"checkResult":{"chooseImage":true},"errMsg":"checkJsApi:ok"}
		}
	});
	wx.ready(function(){

		// config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，
		// config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，
		// 则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，
		// 则可以直接调用，不需要放在ready函数中。
		wx.onMenuShareAppMessage({
			title:'的卡萨卡斯空间打开降落伞', // 分享标题
			desc: 'dasjdjalsdklalsdjas', // 分享描述
			link: 'https://www.baidu.com', // 分享链接
			imgUrl:'weixin-java-tools-springmvc/src/main/webapp/img/logo.png', // 分享图标
//			type: '', // 分享类型,music、video或link，不填默认为link
//			dataUrl: 'https://www.baidu.com', // 如果type是music或video，则要提供数据链接，默认为空
			success: function () {
				// 用户确认分享后执行的回调函数
				alert(666);
			},
			cancel: function () {
				// 用户取消分享后执行的回调函数
				alert(777);
			}
		});

		wx.onMenuShareTimeline({
			title: '555', // 分享标题
			link: '444', // 分享链接
			imgUrl: '', // 分享图标
			success: function () {
				// 用户确认分享后执行的回调函数
				alert(555);
			},
			cancel: function () {
				// 用户取消分享后执行的回调函数
				alert(444);
			}
		});
	});

	wx.error(function(res){

		// config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。

	});

</script>
</head>
<body>
	Welcome to Wechat Service System !
<div id="01">测试数据</div>
<img src="/img/logo.png" id="02">
</body>
</html>