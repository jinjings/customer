package com.lefu.letou.util;

import java.util.Iterator;

import com.alibaba.fastjson.JSONObject;

public class JsonUtil {
	/**
	 * 
	 * @param json
	 * @param resutlJson
	 */
	public static void decodeJSONObject(JSONObject json, JSONObject resutlJson) {
		Iterator<String> keys = json.keySet().iterator();

		while (keys.hasNext()) {
			String key = keys.next();
			Object value = json.get(key);
			if (value instanceof JSONObject) {
				JSONObject jo = (JSONObject) value;
				if (jo.keySet().size() > 0) {
					decodeJSONObject(jo, resutlJson);
				} else {
					resutlJson.put(key, value);
					// System.out.println(key);
				}
			} else {
				resutlJson.put(key, value);
			}
		}
	}
}
