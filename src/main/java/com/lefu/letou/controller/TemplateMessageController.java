package com.lefu.letou.controller;

import java.io.Serializable;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import me.chanjar.weixin.common.exception.WxErrorException;
import me.chanjar.weixin.mp.api.WxMpConfigStorage;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.template.WxMpTemplate;
import me.chanjar.weixin.mp.bean.template.WxMpTemplateData;
import me.chanjar.weixin.mp.bean.template.WxMpTemplateMessage;

/**
 * 模板消息Controller
 * <p>
 * Created by FirenzesEagle on 2016/7/11 0011. Email:liumingbo2008@gmail.com
 */
@Controller
@RequestMapping(value = "templateMessage")
public class TemplateMessageController extends GenericController {

	// 模板消息字体颜色
	private static final String TEMPLATE_FRONT_COLOR = "#32CD32";
	@Autowired
	protected WxMpConfigStorage configStorage;
	@Autowired
	protected WxMpService wxMpService;
	@Autowired
	protected RedisTemplate<Serializable, Serializable> redisTemplate;

	@RequestMapping(value = "gotoList")
	public ModelAndView gotoList(HttpServletResponse response, HttpServletRequest request) {
		ModelAndView view = new ModelAndView("templateMessage/list");

		try {
			List<WxMpTemplate> list = wxMpService.getTemplateMsgService().getAllPrivateTemplate();
			view.addObject("templateList", list);
		} catch (WxErrorException e) {
			logger.error(e.getMessage().toString());
		}
		return view;
	}

	@RequestMapping(value = "gotoCreate")
	public ModelAndView gotoCreate(HttpServletResponse response, HttpServletRequest request) {
		ModelAndView view = new ModelAndView("templateMessage/create");
		
		return view;
	}

	@RequestMapping(value = "createTemplate")
	@ResponseBody
	public void create(HttpServletResponse response, HttpServletRequest request) {
		WxMpTemplateMessage orderPaySuccessTemplate = new WxMpTemplateMessage();
		orderPaySuccessTemplate.setToUser("ohhZqw2gI8Hdprsma0OoEG4wWMRU");
		orderPaySuccessTemplate.setTemplateId("OK_qmKXhF-kHL4miDBP2b7Z8CsI2fs6LgN3ZACjvTfk");
		orderPaySuccessTemplate.setUrl("http://www.baidu.com");
		orderPaySuccessTemplate.setTopColor(TEMPLATE_FRONT_COLOR);
		WxMpTemplateData firstData = new WxMpTemplateData("result", "订单支付成功", TEMPLATE_FRONT_COLOR);

		orderPaySuccessTemplate.addWxMpTemplateData(firstData);

		try {
			wxMpService.getTemplateMsgService().sendTemplateMsg(orderPaySuccessTemplate);
		} catch (WxErrorException e) {
			logger.error(e.getMessage().toString());
		}
	}
	@RequestMapping(value = "deleteTemplate")
	@ResponseBody
	public void deleteTemplate(HttpServletResponse response, HttpServletRequest request) {
		String templateId = request.getParameter("templateId");

		try {
			wxMpService.getTemplateMsgService().delPrivateTemplate(templateId);
		} catch (WxErrorException e) {
			logger.error(e.getMessage().toString());
		}
	}
	@RequestMapping(value = "notifyOrderPaySuccessTemplate")
	public void notifyOrderPaySuccessTemplate(HttpServletResponse response, HttpServletRequest request) {
		WxMpTemplateMessage orderPaySuccessTemplate = new WxMpTemplateMessage();
		orderPaySuccessTemplate.setToUser(request.getParameter("openid"));
		orderPaySuccessTemplate.setTemplateId("ENp7UwpOtlhvieebUvDm0mK4n0hTvbH0Me83HdBUvC0");
		orderPaySuccessTemplate.setUrl(request.getParameter("url"));
		orderPaySuccessTemplate.setTopColor(TEMPLATE_FRONT_COLOR);
		WxMpTemplateData firstData = new WxMpTemplateData("first", "订单支付成功", TEMPLATE_FRONT_COLOR);
		WxMpTemplateData orderMoneySumData = new WxMpTemplateData("orderMoneySum",
				request.getParameter("orderMoneySum"), TEMPLATE_FRONT_COLOR);
		WxMpTemplateData orderProductNameData = new WxMpTemplateData("orderProductName",
				request.getParameter("orderProductName"), TEMPLATE_FRONT_COLOR);
		WxMpTemplateData remarkData = new WxMpTemplateData("Remark", request.getParameter("remark"),
				TEMPLATE_FRONT_COLOR);
		orderPaySuccessTemplate.addWxMpTemplateData(firstData);
		orderPaySuccessTemplate.addWxMpTemplateData(orderMoneySumData);
		orderPaySuccessTemplate.addWxMpTemplateData(orderProductNameData);
		orderPaySuccessTemplate.addWxMpTemplateData(remarkData);
		try {
			wxMpService.getTemplateMsgService().sendTemplateMsg(orderPaySuccessTemplate);
		} catch (WxErrorException e) {
			logger.error(e.getMessage().toString());
		}
	}

	@RequestMapping(value = "notifyOrderStatusUpdateTemplate")
	public void notifyOrderStatusUpdateTemplate(HttpServletResponse response, HttpServletRequest request) {
		WxMpTemplateMessage orderPaySuccessTemplate = new WxMpTemplateMessage();
		orderPaySuccessTemplate.setToUser(request.getParameter("openid"));
		orderPaySuccessTemplate.setTemplateId("X8ccwRF4EAx7VHFQGzi78Gl0C3GcpGpYgWk-HFFOWA0");
		orderPaySuccessTemplate.setUrl(request.getParameter("url"));
		orderPaySuccessTemplate.setTopColor(TEMPLATE_FRONT_COLOR);
		WxMpTemplateData firstData = new WxMpTemplateData("first", "订单状态更新", TEMPLATE_FRONT_COLOR);
		WxMpTemplateData orderMoneySumData = new WxMpTemplateData("OrderSn", request.getParameter("OrderSn"),
				TEMPLATE_FRONT_COLOR);
		WxMpTemplateData orderProductNameData = new WxMpTemplateData("OrderStatus", request.getParameter("OrderStatus"),
				TEMPLATE_FRONT_COLOR);
		WxMpTemplateData remarkData = new WxMpTemplateData("remark", request.getParameter("remark"),
				TEMPLATE_FRONT_COLOR);
		orderPaySuccessTemplate.addWxMpTemplateData(firstData);
		orderPaySuccessTemplate.addWxMpTemplateData(orderMoneySumData);
		orderPaySuccessTemplate.addWxMpTemplateData(orderProductNameData);
		orderPaySuccessTemplate.addWxMpTemplateData(remarkData);
		try {
			wxMpService.getTemplateMsgService().sendTemplateMsg(orderPaySuccessTemplate);
		} catch (WxErrorException e) {
			logger.error(e.getMessage().toString());
		}
	}

	@SuppressWarnings("deprecation")
	@RequestMapping(value = "testTemplate")
	public void testTemplate(HttpServletResponse response, HttpServletRequest request) {
		WxMpTemplateMessage orderTestTemplate = new WxMpTemplateMessage();
		
		final String code = UUID.randomUUID().toString();
		
		orderTestTemplate.setToUser("ohhZqw2gI8Hdprsma0OoEG4wWMRU");
		orderTestTemplate.setTemplateId("BjYaM8jHVCzQAxO2bViSpPvrf3wJlHf9eoqaH4fmduA");
		String redirect_uri ="http://5065e28.nat123.net/mgr/wxCard/gotoGetCard?t="+code;
		orderTestTemplate.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx7fa6bf82610ab2f1&redirect_uri="+URLEncoder.encode(redirect_uri)+"&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect");
		orderTestTemplate.setTopColor(TEMPLATE_FRONT_COLOR);
		WxMpTemplateData userNameData = new WxMpTemplateData("userName", "尊敬的金先生", TEMPLATE_FRONT_COLOR);
		WxMpTemplateData keyword1 = new WxMpTemplateData("keyword1", "这是个测试详情", TEMPLATE_FRONT_COLOR);

		orderTestTemplate.addWxMpTemplateData(userNameData);
		orderTestTemplate.addWxMpTemplateData(keyword1);
		try {
			wxMpService.getTemplateMsgService().sendTemplateMsg(orderTestTemplate);
			
			redisTemplate.execute(new RedisCallback<Object>() {

	            @Override
	            public Object doInRedis(RedisConnection connection) throws DataAccessException {
	                connection.set(code.getBytes(),"0".getBytes());
	                return null;
	            }
	        });
		} catch (WxErrorException e) {
			logger.error(e.getMessage().toString());
		}
	}

}
