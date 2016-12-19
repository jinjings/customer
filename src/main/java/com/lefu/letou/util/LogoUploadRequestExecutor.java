package com.lefu.letou.util;

import java.io.File;
import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;

import me.chanjar.weixin.common.bean.result.WxError;
import me.chanjar.weixin.common.bean.result.WxMediaUploadResult;
import me.chanjar.weixin.common.exception.WxErrorException;
import me.chanjar.weixin.common.util.http.RequestExecutor;
import me.chanjar.weixin.common.util.http.Utf8ResponseHandler;

public class LogoUploadRequestExecutor implements RequestExecutor<WxMediaUploadResult, File> {
	@Override
	public WxMediaUploadResult execute(CloseableHttpClient httpclient, HttpHost httpProxy, String uri, File file)
			throws WxErrorException, IOException {
		HttpPost httpPost = new HttpPost(uri);
		if (httpProxy != null) {
			RequestConfig config = RequestConfig.custom().setProxy(httpProxy).build();
			httpPost.setConfig(config);
		}
		if (file != null) {
			HttpEntity entity = MultipartEntityBuilder.create().addBinaryBody("media", file)
					.setMode(HttpMultipartMode.RFC6532).build();
			httpPost.setEntity(entity);
			httpPost.setHeader("Content-Type", ContentType.MULTIPART_FORM_DATA.toString());
		}
		try (CloseableHttpResponse response = httpclient.execute(httpPost)) {
			String responseContent = Utf8ResponseHandler.INSTANCE.handleResponse(response);
			WxError error = WxError.fromJson(responseContent);
			if (error.getErrorCode() != 0) {
				throw new WxErrorException(error);
			}
			WxMediaUploadResult result = new WxMediaUploadResult();
			result.setThumbMediaId(responseContent);
			return result;
			// return WxMediaUploadResult.fromJson(responseContent);
		} finally {
			httpPost.releaseConnection();
		}
	}

}
