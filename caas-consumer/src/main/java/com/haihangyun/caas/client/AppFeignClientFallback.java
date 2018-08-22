package com.haihangyun.caas.client;

import java.util.List;

import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.haihangyun.caas.vo.TechnologVO;

@Component
public class AppFeignClientFallback implements AppFeignClient {

	@Override
	public String getApp() {
		return "Error. 服务提供者出错了，可返回缓存数据";
	}

	@Override
	public List<TechnologVO> getTechnolog() {
		return Lists.newArrayList();
	}

}
