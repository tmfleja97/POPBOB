package com.example.controller;

import java.util.ArrayList;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.model.CheckTO;
import com.example.model.ReservationDAO;
import com.example.model.ReservationTO;

@RestController
public class ReservationController {

	@Autowired
	private ReservationDAO resdao;

	@RequestMapping("/resList.do")
	public ModelAndView resList(HttpServletRequest request) {

		ArrayList<ReservationTO> resList = resdao.resList();

		// 쿠키 받기
		String userId = null;
		Cookie[] cookies = request.getCookies(); // 현재 요청에 포함된 모든 쿠키를 가져옴
		if (cookies != null) { // 가져온 쿠키들이 null이 아닌 경우, 반복문을 통해 각 쿠키를 확인
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("UserId")) {
					userId = cookie.getValue();
					break;
				}
			}
		}

		request.setAttribute("userId", userId);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("resList");
		modelAndView.addObject("resList", resList);
		modelAndView.addObject("userId", userId);

		return modelAndView;
	}

	@RequestMapping("/resView.do")
	public ModelAndView resView(HttpServletRequest request) {

		ReservationTO resTO = new ReservationTO();

		resTO.setResId(request.getParameter("resId"));

		resTO = resdao.resView(resTO);

		// 쿠기 받기
		String userId = null;
		Cookie[] cookies = request.getCookies(); // 현재 요청에 포함된 모든 쿠키를 가져옴
		if (cookies != null) { // 가져온 쿠키들이 null이 아닌 경우, 반복문을 통해 각 쿠키를 확인
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("UserId")) {
					userId = cookie.getValue();
					break;
				}
			}
		}

		request.setAttribute("userId", userId);

		HttpSession session = request.getSession();
		String cpName = (String) session.getAttribute("CpName");
		String cpEmail = (String) session.getAttribute("CpEmail");
		Long kakaoId = (Long) session.getAttribute("kakaoId");
		String kakaoEmail = (String) session.getAttribute("kakaoEmail");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("resView");
		modelAndView.addObject("resTO", resTO);
		modelAndView.addObject("userId", userId);
		modelAndView.addObject("cpName", cpName);
		modelAndView.addObject("cpEmail", cpEmail);
		modelAndView.addObject("kakaoId", kakaoId);
		modelAndView.addObject("kakaoEmail", kakaoEmail);

		return modelAndView;
	}

	@RequestMapping("/resWriteOk.do")
	public ModelAndView resWriteOk(HttpServletRequest request) {

		CheckTO checkTO = new CheckTO();

		checkTO.setCheckId(request.getParameter("checkId"));
		checkTO.setTitle(request.getParameter("title"));
		checkTO.setCpName(request.getParameter("cpName"));
		checkTO.setNumber(request.getParameter("number"));
		checkTO.setEmail(request.getParameter("email"));
		checkTO.setStartDate(request.getParameter("startDate"));
		checkTO.setEndDate(request.getParameter("endDate"));

		int flag = resdao.resWriteOk(checkTO);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("resWrite_ok");
		modelAndView.addObject("flag", flag);

		return modelAndView;
	}

	@RequestMapping("/calendar.do")
	public ModelAndView calendar(HttpServletRequest request) {

		ArrayList<CheckTO> cal = resdao.calendar();

		// 쿠기 받기
		String userId = null;
		Cookie[] cookies = request.getCookies(); // 현재 요청에 포함된 모든 쿠키를 가져옴
		if (cookies != null) { // 가져온 쿠키들이 null이 아닌 경우, 반복문을 통해 각 쿠키를 확인
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("UserId")) {
					userId = cookie.getValue();
					break;
				}
			}
		}

		request.setAttribute("userId", userId);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("calendar");
		modelAndView.addObject("cal", cal);
		modelAndView.addObject("userId", userId);
		
		return modelAndView;
	}
}
