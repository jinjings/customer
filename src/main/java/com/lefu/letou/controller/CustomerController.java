package com.lefu.letou.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import me.chanjar.weixin.common.exception.WxErrorException;
import me.chanjar.weixin.mp.api.WxMpConfigStorage;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.store.WxMpStoreBaseInfo;
import me.chanjar.weixin.mp.bean.store.WxMpStoreInfo;
import me.chanjar.weixin.mp.bean.template.WxMpTemplate;
import me.chanjar.weixin.mp.bean.template.WxMpTemplateData;
import me.chanjar.weixin.mp.bean.template.WxMpTemplateMessage;

@Controller
@RequestMapping(value = "wxCustomer")
public class CustomerController extends GenericController {

	@Autowired
	protected WxMpConfigStorage configStorage;
	@Autowired
	protected WxMpService wxMpService;

	@RequestMapping(value = "gotoList")
	public ModelAndView gotoList(HttpServletResponse response, HttpServletRequest request) {
		ModelAndView view = new ModelAndView("customer/list");

		try {
			List<WxMpStoreInfo> list = wxMpService.getStoreService().listAll();
			view.addObject("customerList", list);
		} catch (WxErrorException e) {
			logger.error(e.getMessage().toString());
		}
		return view;
	}

	@RequestMapping(value = "gotoCreate")
	public ModelAndView gotoCreate(HttpServletResponse response, HttpServletRequest request) {
		ModelAndView view = new ModelAndView("customer/create");

		return view;
	}

	@RequestMapping(value = "createCustomer")
	public String create(HttpServletResponse response, HttpServletRequest request, WxMpStoreBaseInfo cust) {

		try {

			wxMpService.getStoreService().add(cust);
		} catch (WxErrorException e) {
			logger.error(e.getMessage().toString());
		}
		
		return "redirect:/gotoList";
	}
}
