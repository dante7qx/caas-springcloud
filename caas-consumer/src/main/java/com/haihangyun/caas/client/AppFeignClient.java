package com.haihangyun.caas.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@FeignClient(name = "caas-provider", fallback = AppFeignClientFallback.class)
public interface AppFeignClient {

	@RequestMapping(value = "/msg", method = RequestMethod.GET)
	public String getApp();

}
