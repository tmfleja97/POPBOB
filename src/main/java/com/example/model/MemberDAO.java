package com.example.model;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.example.config.MemberMapperInter;

@Repository
@MapperScan(basePackages = { "com.example.config" })
public class MemberDAO {

	@Autowired
	private MemberMapperInter mapper;
	
	// 회원가입
	public int signupOk(MemberTO to) {

		int flag = 1;

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodePassword = encoder.encode(to.getPassword());
		to.setPassword(encodePassword);

		int result = mapper.signupOK(to);

		if (result == 1) {
			flag = 0;
		}

		return flag;
	}
	
	// 아이디 중복확인
	public int duplication(String sid) {
		String id = mapper.dup_check(sid);

		int result = 0;
		
		if(id != null) {
			result = 1;
		} else {
			result = 0;
		}

		return result;
	}
	
	// 이메일 중복확인
	public int email_duplication(String CpEmail) {
		String email = mapper.dup_email_check(CpEmail);
		
		int result = 0;
		
		if(email != null) {
			result = 1;
		} else {
			result = 0;
		}
		
		return result;
	}
	
	
	// 로그인
	public boolean login(MemberTO to) {
		
		MemberTO storedTO = mapper.login(to);
		
		if (storedTO != null) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			String storedPasswordHash = storedTO.getPassword(); // 데이터베이스에 저장된 hash 암호
			String enteredPassword = to.getPassword(); // 로그인 시 입력한 암혼
			
			// match 메서드로 두 개의 값이 같은 값인지 확인 가능.
			if (encoder.matches(enteredPassword, storedPasswordHash) ) { 
				// 패스워드 검증 성공
				return true;
			}
		} 

		return false;

	}
	
	
	public String cpName(MemberTO to) {
		MemberTO cpName = mapper.login(to);
		return cpName.getCpName();
	}
	
	public String cpEmail(MemberTO to) {
		MemberTO cpEmail = mapper.login(to);
		return cpEmail.getCpEmail();
	}
	
}
