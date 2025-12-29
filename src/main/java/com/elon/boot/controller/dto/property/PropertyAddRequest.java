package com.elon.boot.controller.dto.property;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
public class PropertyAddRequest {
	
    @JsonIgnore        // 요청 시 무시, selectKey에서 채워짐
    private Long propertyNo;
    
    // 로그인 세션 주입
    private String realtorId;

    @JsonIgnore        // 요청 시 무시, selectKey에서 채워짐
    private String userId;
    
    // 기본/가격/주소/상세
    private String propertyName;
    private String propertyType;   // oneRoom/twoRoom/threeRoom/officetel
    
    private Integer room;
    private Integer bathroom;
    private Integer floor;
    private Integer totalFloor;
    private String studentPref;     // "Y" or null
    private String shortCont;       // "Y" or null
    private String constructionYear;
    private String availableDate;
    
    private String priceType;      // monthlyRent/rent/sale
    private Integer deposit;
    private Integer monthlyRent;
    private Integer maintenanceFee;
    private String  maintenanceIncl; // "Y"/"N" (hidden)

    private String roadAddress;
    private String parcelAddress;
    private String addressDetail;
    private String province;
    private String district;
    
    private Double latitude;
    private Double longitude;

    private Double contractArea;

    private String description;
    
//    @JsonIgnore
//    private String contractStatus;
//    @JsonIgnore
//    private Timestamp contractAt;
//    @JsonIgnore
//    private String status;
//    @JsonIgnore
//    private Timestamp createdAt;
//    @JsonIgnore
//    private Timestamp updatedAt;
//    @JsonIgnore
//    private Timestamp deletedAt;

    // 이미지
//    private List<MultipartFile> images;

    // ===== 옵션(체크박스) - 체크시 "Y", 미체크 null =====
//    private String optAc;
//    private String optHeater;
//
//    private String optFridge;
//    private String optMicrowave;
//    private String optInduction;
//    private String optGasRange;
//
//    private String optWasher;
//    private String optDryer;
//    private String optBed;
//    private String optDesk;
//    private String optWardrobe;
//    private String optShoecloset;
//    private String optTv;
//
//    private String facParking;
//    private String facElevator;
//    private String facSecurity;
//    private String facPet;
}