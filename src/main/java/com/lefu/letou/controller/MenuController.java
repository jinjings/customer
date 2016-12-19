package com.lefu.letou.controller;

import java.net.URLDecoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lefu.letou.service.CoreService;

import me.chanjar.weixin.common.exception.WxErrorException;
import me.chanjar.weixin.common.util.http.SimpleGetRequestExecutor;
import me.chanjar.weixin.common.util.http.SimplePostRequestExecutor;
import me.chanjar.weixin.mp.api.WxMpConfigStorage;
import me.chanjar.weixin.mp.api.WxMpService;

@Controller
@RequestMapping(value = "wxMenu")
public class MenuController {

	@Autowired
	protected WxMpConfigStorage configStorage;
	@Autowired
	protected WxMpService wxMpService;
	@Autowired
	protected CoreService coreService;

	private static final String CREATE_MENU_URL = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=";
	private static final String GET_MENU_URL = "https://api.weixin.qq.com/cgi-bin/menu/get?access_token=";
	private static final String DELETE_MENU_URL = "https://api.weixin.qq.com/cgi-bin/menu/delete?access_token=";

	@RequestMapping(value = "gotoCreateMenu")
	public ModelAndView gotoCreateMenu(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView view = new ModelAndView("menu/menu");
		// 菜单
		String menuJsonStr = getMenu();
		// @SuppressWarnings("rawtypes")
		// Map map = (Map)JSONObject.parse(menuJsonStr);
		// view.addObject("menuJsonStr",JSONArray.toJSONString(((Map)map.get("menu")).get("button")));
		view.addObject("menuJsonStr",
				menuJsonStr.replaceAll("\"name\"", "\"text\"").replaceAll("\"sub_button\"", "\"nodes\""));
		return view;
	}

	private String getMenu() {
		String result = "[]";
		try {
			String accessToken = wxMpService.getAccessToken();
			CloseableHttpClient httpClient = HttpClients.createDefault();

			SimpleGetRequestExecutor e = new SimpleGetRequestExecutor();
			result = e.execute(httpClient, null, GET_MENU_URL + accessToken, "");
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		return result;
	}
	/**
	 * 添加
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "createMenu")
	@ResponseBody
	public String createMenu(HttpServletRequest request, HttpServletResponse response) {
		String result = "";
		try {
			String q = request.getParameter("q");
			q = URLDecoder.decode(q);
			String menuJson = q.replaceAll("\"text\"", "\"name\"").replaceAll( "\"nodes\"","\"sub_button\"");
			JSONObject menu = new JSONObject();
			menu.put("button", JSONArray.parse(menuJson));
			
			String accessToken = wxMpService.getAccessToken();
			CloseableHttpClient httpClient = HttpClients.createDefault();
			//删除
			SimplePostRequestExecutor e = new SimplePostRequestExecutor();
			result = e.execute(httpClient, null, DELETE_MENU_URL + accessToken, "");
			
			//添加
			result = e.execute(httpClient, null, CREATE_MENU_URL + accessToken,JSONObject.toJSONString(menu));

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}
	/**
	 * 删除
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "deleteMenu")
	@ResponseBody
	public String deleteMenu(HttpServletRequest request, HttpServletResponse response) {
		String result = "";
		try {

			String accessToken = wxMpService.getAccessToken();
			CloseableHttpClient httpClient = HttpClients.createDefault();

			SimplePostRequestExecutor e = new SimplePostRequestExecutor();
			result = e.execute(httpClient, null, DELETE_MENU_URL + accessToken, "");

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

	
}
