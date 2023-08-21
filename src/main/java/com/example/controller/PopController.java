package com.example.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.model.InformationDAO;
import com.example.model.InformationTO;

@RestController
public class PopController {

	@Autowired
	private InformationDAO infodao;
	
	@RequestMapping("/popList.do")
	public ModelAndView infoList(HttpServletRequest request) {
		
		ArrayList<InformationTO> infoList = infodao.infoList();
	    ArrayList<InformationTO> popList = new ArrayList<>();
			
	    for (InformationTO infoTO : infoList) {

	        String category = infoTO.getCategory();
	        
	        if (category.equals("pop")) {
	        	popList.add(infoTO);
	        }
	    }	
		
	    		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("popList");
		modelAndView.addObject("infoList", popList);
		
		return modelAndView;
	}	
	
	
	@RequestMapping("/popView.do")
	public ModelAndView infoView(HttpServletRequest request) {

		ArrayList<InformationTO> infoPopList = infodao.infoPopView();
		
		InformationTO infoTO = new InformationTO();

		infoTO.setInfoId(request.getParameter("infoId"));


		infoTO = infodao.infoView(infoTO);

		

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("popView");
		modelAndView.addObject("infoTO", infoTO);
		modelAndView.addObject("infoPopList", infoPopList);

		return modelAndView;
	}
	
	
	@RequestMapping("/")
	public ModelAndView index(HttpServletRequest request) {
		

		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("index");		
		return modelAndView;
	}
}
