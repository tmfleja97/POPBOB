package com.example.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.example.model.KakaoProfile;
import com.example.model.OAuthToken;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class KakaoController {

	@GetMapping("/kakao/callback")
	public String kakaoCallback(@RequestParam("code") String code, HttpServletRequest request) {

		// POST방식으로 key - value 타입의 데이터를 요청해야함(카카오쪽으로)

		// RestTemplate : POST방식으로 요청할때 필요한 라이브러리( http 요청을 편리하게할 수 있음, HttpUrlConnection같은 것(보다 좋음) )
		RestTemplate rt = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8"); // body 데이터가 key - value 데이터 형태라고 알려주는 것

		// body데이터를 담을 오프젝트
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "710c05591e20857f80a25972c13bbefe");
		params.add("redirect_uri", "http://localhost:8080/kakao/callback");
		params.add("code", code); // code값은 동적으로 받기때문에 code를 넣어줌

		// HttpEntity<>(params,headers) 이렇게 해줌으로써 params와 headers의 값을 가지고있는 Entity가 된다.
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers); // HttpEntiry : HTTP 메시지를 편하게 조회할 수 있게 해준다

		// Http 요청 - POST방식으로 - 그리고 response 변수의 응답 받음.
		ResponseEntity<String> response = rt.exchange( // exchange라는 함수가 HttpEntity라는 오브젝트를 넣게 되어있음. 그래서 사용
				"https://kauth.kakao.com/oauth/token", HttpMethod.POST, kakaoTokenRequest, String.class);

		// Gson, Json Simple, ObjectMapper
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken oauthToken = null;
		try {
			oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("카카오 엑세스 토큰 : " + oauthToken.getAccess_token());
		
		// 사용자 정보 요청
		RestTemplate rt2 = new RestTemplate();

		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer " + oauthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8"); 
																						
		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest2 = new HttpEntity<>(headers2);
																											
		// Http 요청 - POST방식으로 - 그리고 response 변수의 응답 받음.
		ResponseEntity<String> response2 = rt2.exchange( // exchange라는 함수가 HttpEntity라는 오브젝트를 넣게 되어있음. 그래서 사용
				"https://kapi.kakao.com/v2/user/me", HttpMethod.POST, kakaoProfileRequest2, String.class);
		
		ObjectMapper objectMapper2 = new ObjectMapper();
		KakaoProfile kakaoProfile = null;
		try {
			kakaoProfile = objectMapper2.readValue(response2.getBody(), KakaoProfile.class);
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("카카오 아이디(번호) : " + kakaoProfile.getId());
		System.out.println("카카오 이메일 : " + kakaoProfile.getKakao_account().getEmail());
        System.out.println("카카오 닉네임 : " + kakaoProfile.getProperties().getNickname());
		
		Long kakaoId = kakaoProfile.getId();
		String kakaoEmail = kakaoProfile.getKakao_account().getEmail();
		String kakaoNickname = kakaoProfile.getProperties().getNickname();
		
		if (kakaoId != null || kakaoEmail != null ) {
	        HttpSession session = request.getSession();
	        session.setAttribute("kakaoId", kakaoId);
	        session.setAttribute("kakaoEmail", kakaoEmail);
	        session.setAttribute("kakaoNickname", kakaoNickname);
	        session.setAttribute("kakaoAccessToken", oauthToken.getAccess_token());
	        session.setAttribute("loginSession", "true"); 
	        
	        session.setMaxInactiveInterval(60 * 60);
	        
	        return "redirect:/resList.do";
	    }

	    return "redirect:/login.do"; 

	}

}
