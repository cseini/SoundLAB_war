package com.soundlab.web.page;

import java.util.Map;

import lombok.Data;

@Data
public class PageProxy implements Proxy {
	private Pagination pagination;
	
	public void carryOut(Map<?,?> map) {
		this.pagination = new Pagination();
		pagination.carryOut(map);
	}
}
