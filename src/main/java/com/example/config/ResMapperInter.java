package com.example.config;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.example.model.CheckTO;
import com.example.model.ReservationTO;

public interface ResMapperInter {
	
	// ResList 부분
	@Select("select resId, image, title, location, price, startRes, endRes from Reservation order by resId desc")
	public ArrayList<ReservationTO> resList();
	
	//ResView
	@Select( "select resId, image, title, location, xLoc, yLoc, price from Reservation where resId=#{resId}" )
	public ReservationTO resView(ReservationTO to);

	//예약정보
	@Insert("insert into reservation_check values (0, #{title}, #{cpName}, #{number}, #{email}, #{startDate}, #{endDate})")
	public int resWriteOk(CheckTO to);
	
	// 캘린더 정보
	@Select("select title, cpName, startDate, endDate from reservation_check")
	public ArrayList<CheckTO> calendar();
}