package com.elon.boot.domain.property.model.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class PropertyImg {
	private int 	imgNo;
	private Long 	propertyNo;
	private String 	imgPath;
	private String 	imgRename;
	private String 	imgOriginalName;
	private int 	imgOrder;
	
	private MultipartFile imgeFile;
}
