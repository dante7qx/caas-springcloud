package com.haihangyun.caas.client;

import java.util.List;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haihangyun.caas.vo.TechnologVO;

@FeignClient(name = "caas-provider", fallback = AppFeignClientFallback.class)
public interface AppFeignClient {

	@RequestMapping(value = "/msg", method = RequestMethod.GET)
	public String getApp();

	
	@RequestMapping(value = "/info", method = RequestMethod.GET)
	public List<TechnologVO> getTechnolog();
	
}
