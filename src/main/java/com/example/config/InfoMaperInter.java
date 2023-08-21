package com.example.config;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Select;

import com.example.model.InformationTO;

public interface InfoMaperInter {
	
	// list
	@Select( "select infoId, category, title, period, image1 from information order by infoId desc" )
	public ArrayList<InformationTO> infoList();
	
	// view
	@Select( "select infoId, category, title, content, price, period, time, location, xLoc, yLoc, image2, image3, image4 from information where infoId=#{infoId}" )
	public InformationTO infoView(InformationTO to);
	
	// extra view list (pop)
	@Select( "select infoId, category, title, period, image1 from information where category = 'pop' order by infoId desc limit 0,4" )
	public ArrayList<InformationTO> infoPopView();
	
	// extra view list (exhibition)
	@Select( "select infoId, category, title, period, image1 from information where category = 'exhibition' order by infoId desc limit 0,4" )
	public ArrayList<InformationTO> infoEhbView();
}
