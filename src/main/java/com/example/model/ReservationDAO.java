package com.example.model;

import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.config.ResMapperInter;

@Repository
@MapperScan( basePackages = { "com.example.controller", "com.example.model", "com.example.config", "com.example.domain", "com.example.dto", "com.example.service" } )
public class ReservationDAO {
	
	@Autowired
	private ResMapperInter mapper;
	
	public ArrayList<ReservationTO> resList() {
		
		
		ArrayList<ReservationTO> resList = (ArrayList<ReservationTO>) mapper.resList();
			   
		return resList;
	}
	
	public ReservationTO resView(ReservationTO to) {
		
		to = mapper.resView(to);
		
		return to;
	}
	
	
	// 예약 시 insert될 정보
	public int resWriteOk(CheckTO to) {
	
	int flag = 1;

	int result = mapper.resWriteOk(to);

	if (result == 1) {
		flag = 0;
	}
	
	return flag;
	}
	
	
	public ArrayList<CheckTO> calendar() {
		
		
		ArrayList<CheckTO> cal = (ArrayList<CheckTO>) mapper.calendar();
			   
		return cal;
	}
	
}