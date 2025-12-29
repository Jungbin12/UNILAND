package com.elon.boot.controller.dto.user;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.elon.boot.controller.dto.property.PropertyAddRequest;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
public class UserModRequest {
	private String userId;
	private String userName;
	private int userAge;
	private String userGender;
	private String userPhone;
	private String userEmail;
	private String userRegion;
	private String userSchool;
}
