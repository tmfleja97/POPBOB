package com.example.model;

import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Repository;

import com.example.config.InfoMaperInter;

@Repository
@MapperScan( basePackages = { "com.example.controller", "com.example.model", "com.example.config", "com.example.domain", "com.example.dto", "com.example.service" } )
public class InformationDAO {
	
	@Autowired
	private InfoMaperInter mapper;
	
	public ArrayList<InformationTO> infoList() {
		
		
		ArrayList<InformationTO> infoList = (ArrayList<InformationTO>) mapper.infoList();
			   
		return infoList;
	}
	
	public InformationTO infoView(InformationTO to) {
		
		to = mapper.infoView(to);
		
		return to;
	}
	
	public ArrayList<InformationTO> infoPopView() {
	    ArrayList<InformationTO> infoPopList = (ArrayList<InformationTO>) mapper.infoPopView();

	    return infoPopList;
	}
	
	public ArrayList<InformationTO> infoEhbView() {
		
	    ArrayList<InformationTO> infoEhbList = (ArrayList<InformationTO>) mapper.infoEhbView(); 
	    // 다른 category에 대한 처리를 추가로 구현해주세요.

	    return infoEhbList;
	}
}