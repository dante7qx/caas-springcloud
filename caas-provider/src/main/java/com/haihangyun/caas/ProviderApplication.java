package com.haihangyun.caas;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.collect.Lists;
import com.haihangyun.caas.vo.TechnologyVO;

@SpringBootApplication
@RestController
public class ProviderApplication {
	public static void main(String[] args) {
		SpringApplication.run(ProviderApplication.class, args);
	}
	
	@GetMapping("/info")
	public List<TechnologyVO> technology() {
		return Lists.newArrayList(
				new TechnologyVO("SpringCloud",
						"Spring Cloud是一系列已有框架的集合。它基于Spring Boot的便利性，简化了分布式系统基础设施的开发。使用Java编写，主要是针对 Java 平台。"),
				new TechnologyVO("Docker",
						"Docker 是一个开源的应用容器引擎，让开发者可以打包他们的应用以及依赖包到一个可移植的容器中，然后发布到任何流行的Linux机器上，也可以实现虚拟化，容器是完全使用沙箱机制，相互之间不会有任何接口。"),
				new TechnologyVO("K8S",
						"Kubernetes(k8s)是Google开源的容器集群管理系统（谷歌内部:Borg）。在Docker技术的基础上，为容器化的应用提供部署运行、资源调度、服务发现和动态伸缩等一系列完整功能，提高了大规模容器集群管理的便捷性。"),
				new TechnologyVO("Istio", "Istios是一个提供统一的连接，安全，管理和监控微服务的解决方案。"));
	}

	@GetMapping("/msg")
	public String msg(HttpServletRequest request) {
		String one = "服务端： " + request.getLocalAddr() + "<br/>";
		String two = "客户端： " + getIpAddr(request) + "<br/>";
		return "服务提供者<br/>" + one + two;
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

