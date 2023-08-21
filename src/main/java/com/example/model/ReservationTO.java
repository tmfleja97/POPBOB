package com.example.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReservationTO {
	private String resId;
	private String image;
	private String title;
	private String location;
	private String xLoc;
	private String yLoc;
	private String price;
	private String startRes;
	private String endRes;
	private String contact;
	private String contactNum;
	private String site;
	private String detailLoc;
}
