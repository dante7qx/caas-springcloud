package com.haihangyun.caas;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.netflix.feign.EnableFeignClients;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.haihangyun.caas.client.AppFeignClient;
import com.netflix.hystrix.contrib.javanica.annotation.HystrixCommand;

@SpringBootApplication
@EnableEurekaClient
@EnableFeignClients
@RestController
@RefreshScope
public class ConsumerApplication {
	
	public static void main(String[] args) {
		SpringApplication.run(ConsumerApplication.class, args);
	}
	
	@Autowired
	private AppFeignClient appFeignClient;
	
	@Value("${consumer.info}")
	private String info;
	
	@GetMapping("/")
	@HystrixCommand
	public String test() {
		String x = "";
		try {
			x = appFeignClient.getApp();
		} catch (Exception e) {
			x = "Error";
		}
		return info + " -- " + x + "<br/>";
	}
	
}

