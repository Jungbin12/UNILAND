package com.elon.boot.controller.dto.inquiry;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
public class ContactAdmin {
	private String userId;
	private String userName;
	private String userPhone;
	private String category;
	private String title;
    private String content;
	
	@JsonIgnore        				// 요청 시 무시, selectKey에서 채워짐
	private String realtorId;
	
	@JsonIgnore        				// 요청 시 무시, selectKey에서 채워짐
	private Integer propertyId;
}
