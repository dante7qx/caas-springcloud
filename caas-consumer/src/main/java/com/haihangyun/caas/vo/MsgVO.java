package com.haihangyun.caas.vo;

import java.util.List;

public class MsgVO {
	private String info;
	private List<TechnologVO> technologs;
	
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public List<TechnologVO> getTechnologs() {
		return technologs;
	}
	public void setTechnologs(List<TechnologVO> technologs) {
		this.technologs = technologs;
	}
	
}
