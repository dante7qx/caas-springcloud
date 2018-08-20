package com.haihangyun.caas.client;

import org.springframework.stereotype.Component;

@Component
public class AppFeignClientFallback implements AppFeignClient {

	@Override
	public String getApp() {
		return "Error. 服务提供者出错了，可返回缓存数据";
	}

}
