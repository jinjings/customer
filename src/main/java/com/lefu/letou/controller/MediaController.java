package com.lefu.letou.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.lefu.letou.controller.vo.DatatablesViewPage;
import com.lefu.letou.service.CoreService;

import me.chanjar.weixin.common.bean.result.WxMediaUploadResult;
import me.chanjar.weixin.common.util.http.MediaUploadRequestExecutor;
import me.chanjar.weixin.mp.api.WxMpConfigStorage;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.material.WxMpMaterial;
import me.chanjar.weixin.mp.bean.material.WxMpMaterialCountResult;
import me.chanjar.weixin.mp.bean.material.WxMpMaterialFileBatchGetResult;
import me.chanjar.weixin.mp.bean.material.WxMpMaterialFileBatchGetResult.WxMaterialFileBatchGetNewsItem;
import me.chanjar.weixin.mp.bean.material.WxMpMaterialNews;
import me.chanjar.weixin.mp.bean.material.WxMpMaterialNews.WxMpMaterialNewsArticle;
import me.chanjar.weixin.mp.bean.material.WxMpMaterialUploadResult;

@Controller
@RequestMapping(value = "wxMedia")
public class MediaController extends GenericController {

	@Autowired
	protected WxMpConfigStorage configStorage;
	@Autowired
	protected WxMpService wxMpService;
	@Autowired
	protected CoreService coreService;

	@RequestMapping(value = "gotoList")
	public ModelAndView gotoList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView view = new ModelAndView("media/list");
		try {
//			 
			WxMpMaterialCountResult countResult = wxMpService.getMaterialService().materialCount();
			view.addObject("imageCount", countResult.getImageCount());
//			view.addObject("videoCount", countResult.getVideoCount());
//			view.addObject("voiceCount", countResult.getVoiceCount());
//			view.addObject("newsCount", countResult.getNewsCount());
//
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return view;
	}

	@RequestMapping(value = "gotoUpload")
	public ModelAndView gotoUpload(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView view = new ModelAndView("media/upload");

		return view;
	}
	@RequestMapping(value = "gotoAddNews")
	public ModelAndView gotoAddNews(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView view = new ModelAndView("media/addNews");

		return view;
	}
	
	@RequestMapping(value = "addNews")
	@ResponseBody
	public WxMpMaterialUploadResult addNews( HttpServletRequest request,HttpServletResponse response , WxMpMaterialNewsArticle  article) {
		try {
			WxMpMaterialNews news= new WxMpMaterialNews();
			news.addArticle(article);
			WxMpMaterialUploadResult result = wxMpService.getMaterialService().materialNewsUpload(news);
			
			return result;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return new WxMpMaterialUploadResult();
	}

	private static final String UPLOAD_URL = "https://api.weixin.qq.com/cgi-bin/material/add_material?access_token=";

	@RequestMapping(value = "uploadMedia")
	@ResponseBody
	public WxMpMaterialUploadResult uploadMedia(@RequestParam("media") MultipartFile logoFile, HttpServletRequest request,
			HttpServletResponse response) {
		try {
			String mediaType = request.getParameter("mediaType");
			File file = new File("E:\\d\\" + logoFile.getOriginalFilename());
			logoFile.transferTo(file);
			WxMpMaterial material = new WxMpMaterial();
			material.setFile(file);
			WxMpMaterialUploadResult result = wxMpService.getMaterialService().materialFileUpload(mediaType, material);

			return result;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return new WxMpMaterialUploadResult();
	}

	@RequestMapping(value = "gotoUploadTemp")
	public ModelAndView gotoUploadTemp(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView view = new ModelAndView("media/uploadTemp");
		try {

			// WxMpMaterialCountResult count =
			// wxMpService.getMaterialService().materialCount();
			// WxMpMaterialFileBatchGetResult result =
			// wxMpService.getMaterialService().materialFileBatchGet("", 1, 1);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return view;
	}

	private static final String TEMP_UPLOAD_URL = "https://api.weixin.qq.com/cgi-bin/media/upload?access_token=";

	@RequestMapping(value = "uploadTmepMedia")
	@ResponseBody
	public WxMediaUploadResult uploadTmepMedia(@RequestParam("media") MultipartFile logoFile,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			String mediaType = request.getParameter("mediaType");
			String accessToken = wxMpService.getAccessToken();

			CloseableHttpClient httpClient = HttpClients.createDefault();
			// HttpPost httpPost = new HttpPost(IMG_URL+accessToken);
			File file = new File("E:\\d\\" + logoFile.getOriginalFilename());
			logoFile.transferTo(file);

			MediaUploadRequestExecutor executor = new MediaUploadRequestExecutor();
			WxMediaUploadResult result = executor.execute(httpClient, null,
					TEMP_UPLOAD_URL + accessToken + "&type=" + mediaType, file);

			return result;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return new WxMediaUploadResult();
	}

	@RequestMapping(value = "getList")
	@ResponseBody
	public DatatablesViewPage getList(HttpServletRequest request, HttpServletResponse response) {
		DatatablesViewPage<WxMaterialFileBatchGetNewsItem> view = new DatatablesViewPage<WxMaterialFileBatchGetNewsItem>();
		try {
			// 获取分页控件的信息
			String start = request.getParameter("start");
			System.out.println(start);
			String length = request.getParameter("length");
			System.out.println(length);
			// 获取前台额外传递过来的查询条件
			String mediaType = request.getParameter("mediaType");
			
//			String imageCount = request.getParameter("imageCount");
//			String videoCount = request.getParameter("videoCount");
//			String voiceCount = request.getParameter("voiceCount");
//			String newsCount = request.getParameter("newsCount");			
//			if("".equals(mediaType)){
//				
//			}else if("".equals(mediaType)){
//				
//			}else if("".equals(mediaType)){
//							
//			}else if("".equals(mediaType)){
//				
//			}
			WxMpMaterialFileBatchGetResult result = wxMpService.getMaterialService().materialFileBatchGet(mediaType,
					Integer.parseInt(start), Integer.parseInt(length));

			view.setiTotalDisplayRecords(result.getTotalCount());
			view.setiTotalRecords(result.getTotalCount());

			view.setListData(result.getItems());
			return view;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return view;
	}
}
