package com.example.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CheckTO {
	private String checkId;
	private String title;
	private String cpName;
	private String number;
	private String email;
	private String startDate;
	private String endDate;
}
