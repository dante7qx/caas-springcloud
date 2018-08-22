package com.haihangyun.caas;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.haihangyun.caas.client.AppFeignClient;
import com.haihangyun.caas.vo.MsgVO;
import com.netflix.hystrix.contrib.javanica.annotation.HystrixCommand;

@SpringBootApplication
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
	public MsgVO technolog() {
		MsgVO msg = new MsgVO();
		msg.setInfo(info);
		msg.setTechnologs(appFeignClient.getTechnolog());
		return msg;
	} 
	
	@GetMapping("/msg")
	@HystrixCommand
	public String msg(HttpServletRequest request) {
		String providerMsg = appFeignClient.getApp();;
		String consumerMsg = "消费者<br/>";
		String one = "服务端： " + request.getLocalAddr() + "<br/>";
		String two = "客户端： " + getIpAddr(request) + "<br/><br/>";
		return consumerMsg.concat(one).concat(two).concat(providerMsg);
	}
	
	private String getIpAddr(HttpServletRequest request) {  
        String ip = request.getHeader("X-Forwarded-For");  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("WL-Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_CLIENT_IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getRemoteAddr();  
        }  
        return ip;  
    } 
	
}

