package com.lefu.letou.util;

public enum BrowserEnum {

	UC_BROWSER("UCBrowser"),MQQ_BROWSER("MQQBrowser"),QQ_BROWSER("QQBrowser"),WX_BROWSER("MicroMessenger");
	
	//浏览器名称
    private String name;
    
    private BrowserEnum(String name){
    	this.name =name;
    }

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public static void main(String[] args){
		System.out.println(	BrowserEnum.UC_BROWSER.getName());

	}

}
