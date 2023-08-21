package com.example.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.model.MemberDAO;
import com.example.model.MemberTO;

@Configuration
@RestController
public class PopbobLogInController {
	
	@Autowired
	private MemberDAO dao;

	@RequestMapping("/signup.do")
	public ModelAndView signup() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("signup");
		return modelAndView;
	}

	@RequestMapping("/signup_ok.do")
	public ModelAndView signup_ok(HttpServletRequest request) {
		MemberTO signupTO = new MemberTO();

		signupTO.setUserId(request.getParameter("UserId"));
		signupTO.setPassword(request.getParameter("Password"));
		signupTO.setCpName(request.getParameter("CpName"));
		signupTO.setCpEmail(request.getParameter("CpEmail"));

		int flag = dao.signupOk(signupTO);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("signup_ok");
		modelAndView.addObject("flag", flag);

		return modelAndView;
	}

	// 아이디 중복확인
	@RequestMapping("/id_check")
	public int id_check(HttpServletRequest request) {
		String sid = request.getParameter("id");

		int result = dao.duplication(sid);

		return result;
	}

	// 이메일 중복확인
	@RequestMapping("/email_check")
	public int email_check(HttpServletRequest request) {
		String email = request.getParameter("email");

		int result = dao.email_duplication(email);

		return result;
	}

	@RequestMapping("/login.do")
	public ModelAndView login() {
		return new ModelAndView("login");
	}

	@RequestMapping("/login_ok.do")
	public ModelAndView login_ok(HttpServletRequest request, HttpServletResponse response) {
		MemberTO loginTO = new MemberTO();
		loginTO.setUserId(request.getParameter("UserId"));
		loginTO.setPassword(request.getParameter("Password"));

		Boolean flag = dao.login(loginTO);

		System.out.println("flag : " + flag);

		// 해당 로그인 정보와 같은 CpName가져오기
		String cpName = dao.cpName(loginTO);
		System.out.println("CpName : " + cpName);

		String cpEmail = dao.cpEmail(loginTO);
		System.out.println("CpEmail : " + cpEmail);

		// 세션에 아이디값 주기
		if (flag) {
			HttpSession session = request.getSession();
			session.setAttribute("loginSession", loginTO.getUserId());

			session.setMaxInactiveInterval(60 * 60);
		}

		// 아이디를 쿠키에 저장하여 클라이언트에게 전달
		Cookie userIdCookie = new Cookie("UserId", loginTO.getUserId());
		userIdCookie.setMaxAge(60 * 60); // 쿠키의 유효 기간 설정
		response.addCookie(userIdCookie);

		// 회사명 세션 가져오기
		if (cpName != null) {
			HttpSession session = request.getSession();
			session.setAttribute("CpName", cpName);
		}

		// 회사 이메일 세션 가져오기
		if (cpEmail != null) {
			HttpSession session = request.getSession();
			session.setAttribute("CpEmail", cpEmail);
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("login_ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;
	}

	@RequestMapping("/popbob.do")
	public ModelAndView main(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String loginSession = (String) session.getAttribute("loginSession");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("main");
		modelAndView.addObject("loginSession", loginSession);

		return modelAndView;
	}

	@RequestMapping("/logout.do")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();

		// 세션 무효화
		session.invalidate();

		// 쿠키 삭제
		Cookie[] cookies = request.getCookies(); // 요청에 포함된 모든 쿠키를 가져옴
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("UserId")) { // ()안에 찾을 쿠키의 이름을 넣어줌
					cookie.setValue(""); // 그 쿠키의 값을 ""로 비움
					cookie.setMaxAge(0); // 쿠키의 수명을 0으로 설정 -> 클라이언트 측에서 해당 쿠키 삭제함
					cookie.setPath("/"); // 쿠키의 유효경로 설정, "/"로 모든 경로에서 쿠키를 사용할 수 있게 함
					response.addCookie(cookie); // 변경된 쿠키를 응답에 추가하여 적용시킴
					break;
				}
			}
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("main");
		return modelAndView;
	}
}
