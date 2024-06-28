package com.uys2j.pinance.Interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.lang.Nullable;
import org.springframework.ui.Model;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;

public class LoginCheckInterceptor implements HandlerInterceptor {
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		if(request.getSession().getAttribute("loginUser") == null) {

			//Interceptor에서 RedirectAttributes 사용하고자 할 경우
			FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
			
			FlashMap flashMap = new FlashMap();
			/* 나중에 alert사용하는거 정해지면 사용
			flashMap.put("alertTitle", "비정상적인 접근");
			flashMap.put("alertMsg", "로그인 후 접근 가능한 페이지입니다.");
			*/
			flashMapManager.saveOutputFlashMap(flashMap, request, response);
			
			response.sendRedirect(request.getContextPath()+"/member/login.page"); // 로그인페이지 요청
			return false;
		} else {
			return true;			
		}
		
	}
	
	/*
	public void postHandle(HttpServletRequest request
						 , HttpServletResponse response
						 , Object handler
						 , @Nullable ModelAndView modelAndView) throws Exception { 
		//modelAndView.getModel() => Model 객체 받을 수 있음 Model model = (Model)modelAndView.getModel(); 
		//model.get("키") => "밸류" }
	}
	*/
}
