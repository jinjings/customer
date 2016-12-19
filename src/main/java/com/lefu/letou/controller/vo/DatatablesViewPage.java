package com.lefu.letou.controller.vo;

import java.util.List;

public class DatatablesViewPage<T>  {

	private List<T> listData; // aaData 与datatales 加载的“dataSrc"对应
	public List<T> getListData() {
		return listData;
	}

	public void setListData(List<T> listData) {
		this.listData = listData;
	}

	public int getiTotalDisplayRecords() {
		return iTotalDisplayRecords;
	}

	public void setiTotalDisplayRecords(int iTotalDisplayRecords) {
		this.iTotalDisplayRecords = iTotalDisplayRecords;
	}

	public int getiTotalRecords() {
		return iTotalRecords;
	}

	public void setiTotalRecords(int iTotalRecords) {
		this.iTotalRecords = iTotalRecords;
	}

	private int iTotalDisplayRecords;
	private int iTotalRecords;

	public DatatablesViewPage() {

	}
}
