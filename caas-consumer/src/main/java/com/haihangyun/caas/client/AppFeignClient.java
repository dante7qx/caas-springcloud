package com.haihangyun.caas.client;

import java.util.List;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.context.annotation.Profile;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haihangyun.caas.vo.TechnologVO;

@Profile("prd")
@Qualifier("appFeignClient")
@FeignClient(name="${consumer.provider}", url = "http://${consumer.provider_path}", fallback = AppFeignClientFallback.class)
public interface AppFeignClient {

	@RequestMapping(value = "/msg", method = RequestMethod.GET)
	public String getApp();

	
	@RequestMapping(value = "/info", method = RequestMethod.GET)
	public List<TechnologVO> getTechnolog();
	
}
