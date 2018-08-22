package com.haihangyun.caas.vo;

import java.util.List;

public class MsgVO {
	private String info;
	private String clientIP;
	private String serverIP;
	private List<TechnologVO> technologs;
	
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getClientIP() {
		return clientIP;
	}
	public void setClientIP(String clientIP) {
		this.clientIP = clientIP;
	}
	public String getServerIP() {
		return serverIP;
	}
	public void setServerIP(String serverIP) {
		this.serverIP = serverIP;
	}
	public List<TechnologVO> getTechnologs() {
		return technologs;
	}
	public void setTechnologs(List<TechnologVO> technologs) {
		this.technologs = technologs;
	}
	
}
