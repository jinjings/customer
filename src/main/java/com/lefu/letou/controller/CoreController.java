package com.lefu.letou.controller;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.lefu.letou.service.CoreService;
import com.lefu.letou.util.ReturnModel;

import me.chanjar.weixin.common.api.WxConsts;
import me.chanjar.weixin.common.bean.WxCardApiSignature;
import me.chanjar.weixin.common.bean.WxJsapiSignature;
import me.chanjar.weixin.common.exception.WxErrorException;

import me.chanjar.weixin.mp.api.WxMpCardService;
import me.chanjar.weixin.mp.api.WxMpConfigStorage;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.message.WxMpXmlMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutTextMessage;
//import me.chanjar.weixin.mp.bean.WxMpXmlMessage;
//import me.chanjar.weixin.mp.bean.WxMpXmlOutMessage;
import me.chanjar.weixin.mp.bean.result.WxMpOAuth2AccessToken;
import me.chanjar.weixin.mp.bean.result.WxMpUser;

/**
 * Created by FirenzesEagle on 2016/5/30 0030. Email:liumingbo2008@gmail.com
 */
@Controller
public class CoreController extends GenericController {

	@Autowired
	protected WxMpConfigStorage configStorage;
	@Autowired
	protected WxMpService wxMpService;
	@Autowired
	protected CoreService coreService;
	@Autowired
	protected RedisTemplate<Serializable, Serializable> redisTemplate;
	@RequestMapping(value = "index")
	public ModelAndView index(HttpServletRequest requesturl) {
		ModelAndView model = new ModelAndView("card/index");
		String url = requesturl.getRequestURL().toString();

		String cardId = requesturl.getParameter("cardId");

		try {
			// url += "?cardId="+cardId;
			WxJsapiSignature iSignature = this.wxMpService.createJsapiSignature(url);

			model.addObject("nonceStr", iSignature.getNoncestr());
			model.addObject("timestamp", iSignature.getTimestamp());
			model.addObject("signature", iSignature.getSignature());
			model.addObject("jsapiTicket", this.wxMpService.getJsapiTicket());
			this.wxMpService.getAccessToken();
			// WxMpCardService cardService=this.wxMpService.getCardService();
			//
			// WxCardApiSignature cardApiSignature
			// =cardService.createCardApiSignature("",cardId);
			// //String ticket = cardService.getCardApiTicket();
			// model.addObject("cardId", cardId);
			// model.addObject("cardCode", cardApiSignature.getCode());
			// model.addObject("cardOpenId", cardApiSignature.getOpenId());
			// model.addObject("cardApiTimestamp",
			// cardApiSignature.getTimestamp());
			// model.addObject("cardNonceStr",cardApiSignature.getNonceStr());
			// model.addObject("cardSignature",
			// cardApiSignature.getSignature());
			// model.addObject("cardApiTicket", cardService.getCardApiTicket());

		} catch (WxErrorException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	//

	/**
	 * 微信公众号webservice主服务接口，提供与微信服务器的信息交互
	 *
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "core")
	public void wechatCore(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		response.setStatus(HttpServletResponse.SC_OK);

		String signature = request.getParameter("signature");
		String nonce = request.getParameter("nonce");
		String timestamp = request.getParameter("timestamp");
		// response.getWriter().println(true);
		if (!this.wxMpService.checkSignature(timestamp, nonce, signature)) {
			// 消息签名不正确，说明不是公众平台发过来的消息
			response.getWriter().println("非法请求");
			return;
		}

		String echoStr = request.getParameter("echostr");
		if (StringUtils.isNotBlank(echoStr)) {
			// 说明是一个仅仅用来验证的请求，回显echostr
			String echoStrOut = String.copyValueOf(echoStr.toCharArray());
			response.getWriter().println(echoStrOut);
			return;
		}

		String encryptType = StringUtils.isBlank(request.getParameter("encrypt_type")) ? "raw"
				: request.getParameter("encrypt_type");

		if ("raw".equals(encryptType)) {
			// 明文传输的消息
			final WxMpXmlMessage inMessage = WxMpXmlMessage.fromXml(request.getInputStream());

			if (inMessage.getEvent().equals(WxConsts.EVT_CLICK)) {
				WxMpXmlOutTextMessage outMessage = WxMpXmlOutMessage.TEXT().fromUser(inMessage.getToUser())
						.toUser(inMessage.getFromUser()).content("尊敬的" + inMessage.getEventKey() + "，您好！" + "您点击的事件是：")

						.build();
				System.out.println(outMessage.toXml());
				response.getWriter().write(outMessage.toXml());
			} else if (inMessage.getEvent().equals(WxConsts.EVT_USER_GET_CARD)) {
				
				redisTemplate.execute(new RedisCallback<Object>() {

		            @Override
		            public Object doInRedis(RedisConnection connection) throws DataAccessException {
		                connection.hSet(inMessage.getFromUser().getBytes(), inMessage.getUserCardCode().getBytes(), inMessage.getCardId().getBytes());
		                connection.set((inMessage.getCardId()+"_"+inMessage.getUserCardCode()).getBytes(), "0".getBytes());
		                return null;
		            }
		        });
				
				//System.out.println(outMessage.toXml());
				response.getWriter().write("");
			} else if (inMessage.getEvent().equals(WxConsts.EVT_USER_DEL_CARD)) {
				
				redisTemplate.execute(new RedisCallback<Object>() {

		            @Override
		            public Object doInRedis(RedisConnection connection) throws DataAccessException {
		                connection.hDel(inMessage.getFromUser().getBytes(), inMessage.getUserCardCode().getBytes());
		                return null;
		            }
		        });
				
				
//				WxMpXmlOutTextMessage outMessage = WxMpXmlOutMessage.TEXT().fromUser(inMessage.getToUser())
//						.toUser(inMessage.getFromUser()).content("尊敬的" + inMessage.getEventKey() + "，您好！" + "您点击的事件是：")
//
//						.build();
//				System.out.println(outMessage.toXml());
				response.getWriter().write("");
			}
			else {
				WxMpXmlOutMessage outMessage = this.coreService.route(inMessage);
				if (outMessage != null) {
					System.out.println(outMessage.toXml());
					response.getWriter().write(outMessage.toXml());
				} else {
					outMessage = new WxMpXmlOutTextMessage();
					System.out.println(outMessage.toXml());
					response.getWriter().write(outMessage.toXml());
				}

			}

			return;
		}

		if ("aes".equals(encryptType)) {
			// 是aes加密的消息
			String msgSignature = request.getParameter("msg_signature");
			WxMpXmlMessage inMessage = WxMpXmlMessage.fromEncryptedXml(request.getInputStream(), this.configStorage,
					timestamp, nonce, msgSignature);
			this.logger.debug("\n消息解密后内容为：\n{} ", inMessage.toString());
			WxMpXmlOutMessage outMessage = this.coreService.route(inMessage);
			this.logger.info(response.toString());
			response.getWriter().write(outMessage.toEncryptedXml(this.configStorage));
			return;
		}

		response.getWriter().println("不可识别的加密类型");
		return;
	}

	/**
	 * 通过openid获得基本用户信息 详情请见:
	 * http://mp.weixin.qq.com/wiki/14/bb5031008f1494a59c6f71fa0f319c66.html
	 *
	 * @param response
	 * @param openid
	 *            openid
	 * @param lang
	 *            zh_CN, zh_TW, en
	 */
	@RequestMapping(value = "getUserInfo")
	public WxMpUser getUserInfo(HttpServletResponse response, @RequestParam(value = "openid") String openid,
			@RequestParam(value = "lang") String lang) {
		ReturnModel returnModel = new ReturnModel();
		WxMpUser wxMpUser = null;
		try {
			wxMpUser = this.wxMpService.getUserService().userInfo(openid, lang);
			returnModel.setResult(true);
			returnModel.setDatum(wxMpUser);
			renderString(response, returnModel);
		} catch (WxErrorException e) {
			returnModel.setResult(false);
			returnModel.setReason(e.getError().toString());
			renderString(response, returnModel);
			this.logger.error(e.getError().toString());
		}
		return wxMpUser;
	}

	/**
	 * 通过code获得基本用户信息 详情请见:
	 * http://mp.weixin.qq.com/wiki/14/bb5031008f1494a59c6f71fa0f319c66.html
	 *
	 * @param response
	 * @param code
	 *            code
	 * @param lang
	 *            zh_CN, zh_TW, en
	 */
	@RequestMapping(value = "getOAuth2UserInfo")
	public void getOAuth2UserInfo(HttpServletResponse response, @RequestParam(value = "code") String code,
			@RequestParam(value = "lang") String lang) {
		ReturnModel returnModel = new ReturnModel();
		WxMpOAuth2AccessToken accessToken;
		WxMpUser wxMpUser;
		try {
			accessToken = this.wxMpService.oauth2getAccessToken(code);
			wxMpUser = this.wxMpService.getUserService().userInfo(accessToken.getOpenId(), lang);
			returnModel.setResult(true);
			returnModel.setDatum(wxMpUser);
			renderString(response, returnModel);
		} catch (WxErrorException e) {
			returnModel.setResult(false);
			returnModel.setReason(e.getError().toString());
			renderString(response, returnModel);
			this.logger.error(e.getError().toString());
		}
	}

	/**
	 * 用code换取oauth2的openid 详情请见:
	 * http://mp.weixin.qq.com/wiki/1/8a5ce6257f1d3b2afb20f83e72b72ce9.html
	 *
	 * @param response
	 * @param code
	 *            code
	 */
	@RequestMapping(value = "getOpenid")
	public void getOpenid(HttpServletResponse response, @RequestParam(value = "code") String code) {
		ReturnModel returnModel = new ReturnModel();
		WxMpOAuth2AccessToken accessToken;
		try {
			accessToken = this.wxMpService.oauth2getAccessToken(code);
			returnModel.setResult(true);
			returnModel.setDatum(accessToken.getOpenId());
			renderString(response, returnModel);
		} catch (WxErrorException e) {
			returnModel.setResult(false);
			returnModel.setReason(e.getError().toString());
			renderString(response, returnModel);
			this.logger.error(e.getError().toString());
		}
	}

}
