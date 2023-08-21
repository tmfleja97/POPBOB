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
public class ExhibitionController {

	@Autowired
	private InformationDAO infodao;

	@RequestMapping("/ehbList.do")
	public ModelAndView infoList(HttpServletRequest request) {

		ArrayList<InformationTO> infoList = infodao.infoList();
		ArrayList<InformationTO> ehbList = new ArrayList<>();

		for (InformationTO infoTO : infoList) {

			String category = infoTO.getCategory();

			if (category.equals("exhibition")) {
				ehbList.add(infoTO);
			}
		}
		

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("ehbList");
		modelAndView.addObject("infoList", ehbList);

		return modelAndView;
	}
	

	@RequestMapping("/ehbView.do")
	public ModelAndView infoView(HttpServletRequest request) {

		ArrayList<InformationTO> infoEhbList = infodao.infoEhbView();
		
		InformationTO infoTO = new InformationTO();

		infoTO.setInfoId(request.getParameter("infoId"));


		infoTO = infodao.infoView(infoTO);

		

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("ehbView");
		modelAndView.addObject("infoTO", infoTO);
		modelAndView.addObject("infoEhbList", infoEhbList);

		return modelAndView;
	}
}
