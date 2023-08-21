package com.example.config;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.example.model.MemberTO;

public interface MemberMapperInter {
	
	// 회원가입시 사용하는 insert문
	@Insert("insert into member values(0, #{UserId}, #{Password}, #{CpName}, #{CpEmail})")
	public int signupOK(MemberTO to);
	
	// 아이디 중복확인용  select문
	@Select("select UserId from member where UserId=#{UserId}")
	public String dup_check(String UserId);
	
	// 이메일 중복확인용 select문
	@Select("select CpEmail from member where CpEmail=#{CpEmail}")
	public String dup_email_check(String CpEmail);
	
	// 로그인시 필요한 select문 / CpName과 CpEmail은 정보를 가져오기위하여 사용
	@Select("select UserId, Password, CpName, CpEmail from member where UserId=#{UserId}")
	public MemberTO login(MemberTO to);

}
