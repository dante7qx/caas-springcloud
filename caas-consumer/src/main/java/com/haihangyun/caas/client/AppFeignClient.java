package com.haihangyun.caas.client;

import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@FeignClient(name = "caas-provider", fallback = AppFeignClientFallback.class)
public interface AppFeignClient {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String getApp();

}
