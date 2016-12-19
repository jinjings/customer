package com.lefu.letou.controller;

import java.io.File;
import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.lefu.letou.service.CoreService;
import com.lefu.letou.util.JsonUtil;
import com.lefu.letou.util.LogoUploadRequestExecutor;

import me.chanjar.weixin.common.bean.WxCardApiSignature;
import me.chanjar.weixin.common.bean.WxJsapiSignature;
import me.chanjar.weixin.common.bean.result.WxMediaUploadResult;
import me.chanjar.weixin.common.exception.WxErrorException;
import me.chanjar.weixin.common.util.http.SimplePostRequestExecutor;
import me.chanjar.weixin.mp.api.WxMpCardService;
import me.chanjar.weixin.mp.api.WxMpConfigStorage;
import me.chanjar.weixin.mp.api.WxMpService;

@Controller
@RequestMapping(value = "wxCard")
public class CardController extends GenericController {

	// 企业向个人转账微信API路径
	private static final String CREATE_CARD_URL = "https://api.weixin.qq.com/card/create?access_token=";

	private static final String IMG_URL = "https://api.weixin.qq.com/cgi-bin/media/uploadimg?access_token=";

	private static final String LIST_CARD_URL = "https://api.weixin.qq.com/card/batchget?access_token=";

	private static final String CARD_DETAIL_URL = "https://api.weixin.qq.com/card/get?access_token=";

	private static final String CARD_DELETE_URL = "https://api.weixin.qq.com/card/delete?access_token=";
	@Autowired
	protected WxMpConfigStorage configStorage;
	@Autowired
	protected WxMpService wxMpService;
	@Autowired
	protected CoreService coreService;
	@Autowired
	protected RedisTemplate<Serializable, Serializable> redisTemplate;

	@RequestMapping(value = "gotoList")
	public ModelAndView gotoList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView view = new ModelAndView("card/list");
		try {
			String accessToken = wxMpService.getAccessToken();
			CloseableHttpClient httpClient = HttpClients.createDefault();
			SimplePostRequestExecutor executor = new SimplePostRequestExecutor();
			String r = executor.execute(httpClient, null, LIST_CARD_URL + accessToken, "{\"offset\": 0,\"count\": 49}");
			Map cardMap = (Map) JSONObject.parse(r);
			if (0 == (int) cardMap.get("errcode")) {

				view.addObject("cardList", cardMap.get("card_id_list"));
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return view;
	}

	@RequestMapping(value = "gotoCardDetail")
	public ModelAndView gotoCardDetail(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView view = new ModelAndView("card/cardDetail");

		String cardId = request.getParameter("cardId");
		try {
			String cardDetailJson = wxMpService.getCardService().getCardDetail(cardId);
			JSONObject card = (JSONObject) JSONObject.parse(cardDetailJson);
			JSONObject result = new JSONObject();

			JsonUtil.decodeJSONObject(card, result);
			// JSONObject card = (JSONObject)JSONObject.parse(cardDetailJson);
			// //卡券详情的json对象
			// JSONObject cardDetail =card.getJSONObject("card");
			// //卡券类型
			// String cardType = cardDetail.getString("card_type");
			// //卡券类型的详情
			// JSONObject cardTypeJson =
			// cardDetail.getJSONObject(cardType.toLowerCase());

			view.addObject("card", result);
		} catch (WxErrorException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return view;
	}

	@RequestMapping(value = "deleteCard")
	public String deleteCard(HttpServletRequest request, HttpServletResponse response) {
		String cardId = request.getParameter("cardId");
		try {

			String accessToken = wxMpService.getAccessToken();
			CloseableHttpClient httpClient = HttpClients.createDefault();
			SimplePostRequestExecutor e = new SimplePostRequestExecutor();
			String r = e.execute(httpClient, null, CARD_DELETE_URL + accessToken, "{\"card_id\":\"" + cardId + "\" }");

			System.out.println(r);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "redirect:/wxCard/gotoList";
	}

	@RequestMapping(value = "gotoUploadimg")
	public ModelAndView gotoUploadimg(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = new ModelAndView("uploadImg");
		try {
			String accessToken = wxMpService.getAccessToken();
			CloseableHttpClient httpClient = HttpClients.createDefault();
			modelAndView.addObject("accessToken", accessToken);
		} catch (WxErrorException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return modelAndView;
	}

	@RequestMapping(value = "uplaodImg")
	@ResponseBody
	public String uploadimg(@RequestParam("logo") MultipartFile logoFile, HttpServletRequest request,
			HttpServletResponse response) {
		try {
			String accessToken = wxMpService.getAccessToken();

			CloseableHttpClient httpClient = HttpClients.createDefault();
			// HttpPost httpPost = new HttpPost(IMG_URL+accessToken);
			File file = new File("E:\\d\\" + logoFile.getOriginalFilename());
			logoFile.transferTo(file);

			LogoUploadRequestExecutor m = new LogoUploadRequestExecutor();
			WxMediaUploadResult result = m.execute(httpClient, null, IMG_URL + accessToken, file);

			return result.getThumbMediaId();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "{}";
	}

	@RequestMapping(value = "gotoCreate")
	public ModelAndView gotoCreate(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView view = new ModelAndView("card/create");
		return view;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "createCard")
	public String createCard(HttpServletRequest request, HttpServletResponse response) {
		Map cardMap = new HashMap();
		Map resultMap = new HashMap();

		Map grouponMap = new HashMap();
		Map map = getMapByRequest(request);
		map.remove("logo");
		String card_type = (String) map.get("card_type");
		resultMap.put("card_type", card_type);
		map.remove("card_type");

		if ("GROUPON".equals(card_type)) {
			String deal_detail = (String) map.get("deal_detail");
			grouponMap.put("deal_detail", deal_detail);
			removeCardType(map);
		} else if ("CASH".equals(card_type)) {
			String least_cost = (String) map.get("least_cost");
			String reduce_cost = (String) map.get("reduce_cost");

			grouponMap.put("least_cost", least_cost);
			grouponMap.put("reduce_cost", reduce_cost);

			removeCardType(map);
		} else if ("DISCOUNT".equals(card_type)) {
			String discount = (String) map.get("discount");
			grouponMap.put("discount", discount);
			removeCardType(map);
		} else if ("GIFT".equals(card_type)) {
			String gift = (String) map.get("gift");
			grouponMap.put("gift", gift);
			removeCardType(map);
		} else if ("GENERAL_COUPON".equals(card_type)) {
			String default_detail = (String) map.get("default_detail");
			grouponMap.put("default_detail", default_detail);
			removeCardType(map);
		}

		// 类型
		String type = (String) map.get("type");

		if ("DATE_TYPE_FIX_TIME_RANGE".equals(type)) {
			@SuppressWarnings("rawtypes")
			Map dmap = new HashMap();
			// 开始时间
			String begin_timestamp = (String) map.get("begin_timestamp");
			// 结束时间
			String end_timestamp = (String) map.get("end_timestamp");

			map.remove("begin_timestamp");
			map.remove("end_timestamp");
			map.remove("fixed_term");
			map.remove("fixed_begin_term");
			map.remove("type");
			dmap.put("type", type);
			dmap.put("begin_timestamp", getDateLong(begin_timestamp + " 00:00:00"));
			dmap.put("end_timestamp", getDateLong(end_timestamp + " 23:59:59"));
			map.put("date_info", dmap);
		} else {
			@SuppressWarnings("rawtypes")
			Map dmap = new HashMap();
			// 有效天数
			String fixed_term = (String) map.get("fixed_term");
			// 开始天数
			String fixed_begin_term = (String) map.get("fixed_begin_term");
			// 结束时间
			String end_timestamp = (String) map.get("end_timestamp");

			map.remove("begin_timestamp");
			map.remove("end_timestamp");
			map.remove("fixed_term");
			map.remove("fixed_begin_term");
			map.remove("type");

			dmap.put("type", type);
			dmap.put("fixed_term", fixed_term);
			dmap.put("fixed_begin_term", fixed_begin_term);
			dmap.put("end_timestamp", getDateLong(end_timestamp + " 23:59:59"));

			map.put("date_info", dmap);
		}
		map.put("can_share", Boolean.parseBoolean((String) map.get("can_share")));
		map.put("can_give_friend", Boolean.parseBoolean((String) map.get("can_give_friend")));

		String quantity = (String) map.get("quantity");
		Map qmap = new HashMap();
		qmap.put("quantity", quantity);
		map.put("sku", qmap);
		map.remove("quantity");
		grouponMap.put("base_info", map);
		/// resultMap.put("groupon", grouponMap);
		resultMap.put(card_type.toLowerCase(), grouponMap);

		cardMap.put("card", resultMap);
		String jsonStr = JSONObject.toJSONString(cardMap);

		try {
			String accessToken = wxMpService.getAccessToken();
			CloseableHttpClient httpClient = HttpClients.createDefault();

			SimplePostRequestExecutor e = new SimplePostRequestExecutor();
			String r = e.execute(httpClient, null, CREATE_CARD_URL + accessToken, jsonStr);
			System.out.println(r);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "redirect:/wxCard/gotoList";
	}

	private void removeCardType(Map map) {
		map.remove("deal_detail");
		map.remove("least_cost");
		map.remove("reduce_cost");
		map.remove("discount");
		map.remove("gift");
		map.remove("default_detail");

	}

	private Map getMapByRequest(HttpServletRequest request) {
		Map resultMap = new HashMap();
		Enumeration<String> enumeration = request.getParameterNames();
		while (enumeration.hasMoreElements()) {
			String key = enumeration.nextElement();

			resultMap.put(key, request.getParameter(key));
		}

		return resultMap;
	}

	@RequestMapping(value = "gotoGetCard")
	public ModelAndView gotoGetCard(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView view = new ModelAndView();
		final String t = request.getParameter("t");
		String status = "";
		if (t != null && !"".equals(t)) {
			
			status = (String) redisTemplate.execute(new RedisCallback<Object>() {

				@Override
				public Object doInRedis(RedisConnection connection) throws DataAccessException {
					byte[] r = connection.get(t.getBytes());
					return new String(r);
				}
			});
		}
		if ("0".equals(status)) {
			view.setViewName("card/getCard");
			view.addObject("t", t);
			String url = request.getRequestURL().toString();
			String q = request.getQueryString();
			if (!"".equals(q) && q != null) {
				url = url + "?" + q;
			}

			String cardId = "phhZqwwRRa9YWWNAepFU9XAbS0Ak";

			view.addObject("code", request.getParameter("code"));
			try {

				// url += "?cardId=" + cardId;
				WxJsapiSignature iSignature = this.wxMpService.createJsapiSignature(url);

				view.addObject("nonceStr", iSignature.getNoncestr());
				view.addObject("timestamp", iSignature.getTimestamp());
				view.addObject("signature", iSignature.getSignature());
				view.addObject("jsapiTicket", this.wxMpService.getJsapiTicket());
				this.wxMpService.getAccessToken();
				WxMpCardService cardService = this.wxMpService.getCardService();

				WxCardApiSignature cardApiSignature = cardService.createCardApiSignature("", cardId);
				// String ticket = cardService.getCardApiTicket();
				view.addObject("cardId", cardId);
				view.addObject("cardCode", cardApiSignature.getCode());
				view.addObject("cardOpenId", cardApiSignature.getOpenId());
				view.addObject("cardApiTimestamp", cardApiSignature.getTimestamp());
				view.addObject("cardNonceStr", cardApiSignature.getNonceStr());
				view.addObject("cardSignature", cardApiSignature.getSignature());
				view.addObject("cardApiTicket", cardService.getCardApiTicket());

			} catch (WxErrorException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			view.setViewName("card/cardUsed");
		}

		return view;
	}

	@RequestMapping(value = "getCard")
	@ResponseBody
	public String getCard(HttpServletRequest request, HttpServletResponse response) {

		final String t = request.getParameter("t");
		final String cardId = request.getParameter("cardId");
		String result = "";
		redisTemplate.execute(new RedisCallback<Object>() {

            @Override
            public Object doInRedis(RedisConnection connection) throws DataAccessException {
                connection.set(t.getBytes(),cardId.getBytes());
                return null;
            }
        });
		return result;
	}

	@RequestMapping(value = "gotoCardUse")
	public ModelAndView gotoCardUse(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView view = new ModelAndView("card/cardUse");

		String code = request.getParameter("encrypt_code");
		request.getParameter("code");
		try {
			code = wxMpService.getCardService().decryptCardCode(code);
		} catch (WxErrorException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String cardId = request.getParameter("card_id");

		view.addObject("code", code);
		view.addObject("cardId", cardId);
		return view;
	}

	@RequestMapping(value = "CardUse")
	@ResponseBody
	public String CardUse(HttpServletRequest request, HttpServletResponse response) {

		final String code = request.getParameter("code");
		final String cardId = request.getParameter("cardId");
		String result = "";
		try {
			result = this.wxMpService.getCardService().consumeCardCode(code, cardId);
			redisTemplate.execute(new RedisCallback<Object>() {

	            @Override
	            public Object doInRedis(RedisConnection connection) throws DataAccessException {
	                
	                connection.set((cardId+"_"+code).getBytes(), "1".getBytes());
	                return null;
	            }
	        });
			
		} catch (WxErrorException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

	private static long getDateLong(String dateStr) {
		// DateTimeFormatter formatter= DateTimeFormatter.ofPattern("yyyy-MM-dd
		// HH:mm:ss");
		// LocalDateTime tiem = LocalDateTime.parse(date, formatter);
		//
		// return tiem.getLong(ChronoField.);
		long longDate = 0;
		// 先把字符串转成Date类型
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		// 此处会抛异常

		try {
			Date date = sdf.parse(dateStr);
			// 获取毫秒数
			longDate = date.getTime() / 1000;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return longDate;
	}

	// public static void main(String[] args) {
	// System.out.println(getDateLong("2016-12-06 00:00:00"));
	// }
	//
	@RequestMapping(value = "createCardTest")
	public String createCardTest(HttpServletRequest request, HttpServletResponse response) {
		StringBuffer sb = new StringBuffer();
		sb.append("{\"card\": {");
		sb.append("\"card_type\": \"GROUPON\",");
		sb.append("\"groupon\": {");
		sb.append("\"base_info\": {");
		sb.append(
				"\"logo_url\":\"http://mmbiz.qpic.cn/mmbiz_jpg/6q0UOILW9zy3Urq1um2WicHicTUpAOSZCEBWctCuwt9tMz8pKFyJBWEf3ibNXNIWqS58VKm9JB1soARfTOaY09wAQ/0\",");
		sb.append("\"brand_name\": \"微信餐厅\",");
		sb.append("\"code_type\": \"CODE_TYPE_TEXT\",");
		sb.append("\"title\": \"132元双人火锅套餐\",");
		sb.append("\"color\": \"Color010\",");
		sb.append("\"notice\": \"使用时向服务员出示此券\",");
		sb.append("\"service_phone\": \"020-88888888\",");
		sb.append("\"description\": \"不可与其他优惠同享\n如需团购券发票，请在消费时向商户提出\n店内均可使用，仅限堂食\",");
		sb.append("\"date_info\": {");
		sb.append("\"type\": \"DATE_TYPE_FIX_TIME_RANGE\",");
		Date d = new Date();

		sb.append("\"begin_timestamp\": " + d.getTime() / 1000 + ",");
		sb.append("\"end_timestamp\": " + (d.getTime() / 1000 + 60000) + "},");
		sb.append("\"sku\": {");
		sb.append("\"quantity\": 500000");
		sb.append("},");
		sb.append("\"get_limit\": 3,");
		sb.append("\"use_custom_code\": false,");
		sb.append("\"bind_openid\": false,");
		sb.append("\"can_share\": true,");
		sb.append("\"can_give_friend\": true,");
		sb.append("\"location_id_list\": [");
		sb.append("123,");
		sb.append("12321,");
		sb.append("345345],");
		sb.append("\"center_title\": \"顶部居中按钮\",");
		sb.append("\"center_sub_title\": \"按钮下方的wording\",");
		sb.append("\"center_url\": \"www.qq.com\",");
		sb.append("\"custom_url_name\": \"立即使用\",");
		sb.append("\"custom_url\": \"http://www.qq.com\",");
		sb.append("\"custom_url_sub_title\": \"6个汉字tips\",");
		sb.append("\"promotion_url_name\": \"更多优惠\",");
		sb.append("\"promotion_url\": \"http://www.qq.com\",");
		sb.append("\"source\": \"大众点评\"},");
		sb.append("\"advanced_info\":{");
		sb.append("\"use_condition\":{");
		sb.append("\"accept_category\":\"鞋类\",");
		sb.append("\"reject_category\":\"阿迪达斯\",");
		sb.append("\"can_use_with_other_discount\":true},");
		sb.append("\"abstract\":{");
		sb.append("\"abstract\":\"微信餐厅推出多种新季菜品，期待您的光临\",");
		sb.append("\"icon_url_list\":[");
		sb.append(
				"\"http://mmbiz.qpic.cn/mmbiz/p98FjXy8LacgHxp3sJ3vn97bGLz0ib0Sfz1bjiaoOYA027iasqSG0sjpiby4vce3AtaPu6cIhBHkt6IjlkY9YnDsfw/0\"");
		sb.append("]");
		sb.append("},");
		sb.append("\"text_image_list\":[");
		sb.append("{");
		sb.append(
				"\"image_url\":\"http://mmbiz.qpic.cn/mmbiz/p98FjXy8LacgHxp3sJ3vn97bGLz0ib0Sfz1bjiaoOYA027iasqSG0sjpiby4vce3AtaPu6cIhBHkt6IjlkY9YnDsfw/0\",");
		sb.append("\"text\":\"此菜品精选食材，以独特的烹饪方法，最大程度地刺激食客的味蕾\"");
		sb.append("},");
		sb.append("{");
		sb.append(
				"\"image_url\":\"http://mmbiz.qpic.cn/mmbiz/p98FjXy8LacgHxp3sJ3vn97bGLz0ib0Sfz1bjiaoOYA027iasqSG0sjpiby4vce3AtaPu6cIhBHkt6IjlkY9YnDsfw/0\",");
		sb.append("\"text\":\"此菜品迎合大众口味，老少皆宜，营养均衡\"");
		sb.append("}");
		sb.append("],");
		sb.append("\"time_limit\":[");
		sb.append("{");
		sb.append("\"type\":\"MONDAY\",");
		sb.append("\"begin_hour\":0,");
		sb.append("\"end_hour\":10,");
		sb.append("\"begin_minute\":10,");
		sb.append("\"end_minute\":59");
		sb.append("},{");
		sb.append("\"type\":\"HOLIDAY\"");
		sb.append("}],");
		sb.append("\"business_service\":[");
		sb.append("\"BIZ_SERVICE_FREE_WIFI\",");
		sb.append("\"BIZ_SERVICE_WITH_PET\",");
		sb.append("\"BIZ_SERVICE_FREE_PARK\",");
		sb.append("\"BIZ_SERVICE_DELIVER\"");
		sb.append("]},");
		sb.append("\"deal_detail\":\"以下锅底2选1（有菌王锅、麻辣锅、大骨锅、番茄锅、清补凉锅、酸菜鱼锅可选）：\n大锅1份12元\n小锅2份16元\"");
		sb.append("}}}");

		// JsonObject jsonA = new JsonObject();

		// jsonA.getAsJsonObject(sb.toString());

		try {
			String accessToken = wxMpService.getAccessToken();
			CloseableHttpClient httpClient = HttpClients.createDefault();

			SimplePostRequestExecutor e = new SimplePostRequestExecutor();
			String r = e.execute(httpClient, null, CREATE_CARD_URL + accessToken, sb.toString());
			System.out.println(r);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "";
	}

	@RequestMapping(value = "testwhitelist")
	public String testwhitelist(HttpServletRequest request, HttpServletResponse response) {
		String url = "https://api.weixin.qq.com/card/testwhitelist/set?access_token=";
		StringBuffer sb = new StringBuffer();
		sb.append("{\"openid\":[\"ohhZqw2gI8Hdprsma0OoEG4wWMRU\"]}");

		try {
			String accessToken = wxMpService.getAccessToken();
			CloseableHttpClient httpClient = HttpClients.createDefault();

			SimplePostRequestExecutor e = new SimplePostRequestExecutor();
			String r = e.execute(httpClient, null, url + accessToken, sb.toString());
			System.out.println(r);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		return "";

	}

	@RequestMapping(value = "updateCardTest")
	public String updateCardTest(HttpServletRequest request, HttpServletResponse response) {
		String url = "https://api.weixin.qq.com/card/update?access_token=TOKEN";
		StringBuffer sb = new StringBuffer();
		sb.append("");
		sb.append("");
		sb.append("");
		sb.append("");

		try {
			String accessToken = wxMpService.getAccessToken();
			CloseableHttpClient httpClient = HttpClients.createDefault();

			SimplePostRequestExecutor e = new SimplePostRequestExecutor();
			String r = e.execute(httpClient, null, url + accessToken, sb.toString());
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		return "";

	}
}
