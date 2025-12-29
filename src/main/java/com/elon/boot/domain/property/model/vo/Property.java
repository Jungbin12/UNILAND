package com.elon.boot.domain.property.model.vo;

import lombok.*;
import java.sql.Timestamp;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Property {
    private Long propertyNo;
    private String realtorId;
    private String userId;

    private String propertyName;
    private String propertyType;

    private Integer room;
    private Integer bathroom;
    private Integer floor;
    private Integer totalFloor;
    private String studentPref;      // Y/N
    private String shortCont;        // Y/N
    private String constructionYear;
    private String availableDate;
    
    private String priceType;
    private Integer deposit;
    private Integer monthlyRent;
    private Integer maintenanceFee;
    private String maintenanceIncl; // Y/N

    private String roadAddress;
    private String parcelAddress;
    private String addressDetail;
    private String province;
    private String district;

    private Double latitude;
    private Double longitude;

    private Double contractArea;

    private String description;
    private String contractStatus;
    private Timestamp contractAt;

    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private Timestamp deletedAt;
    
    private String water;
    private String elect;
    private String gas;
    private String internet;

    // =========================================================================
    // ⭐ JSP 및 목록 조회를 위한 추가 필드 (DB 컬럼 아님, 조회/가공 후 설정)
    // =========================================================================
    
    // JSP: 조회수, 좋아요 수
    private Integer views;
    private Integer likes;
    
    // JSP: 매물 유형 아이콘 (예: 🏠, 🏢) 및 카드 내 대표 아이콘
    private String icon;        // 카드 대표 이미지 자리에 들어갈 아이콘/텍스트
    private String typeIcon;    // 카드 정보 목록에 들어갈 작은 아이콘
    
    // 지도/목록용 썸네일 이미지 경로 (DB 컬럼 아님, 조회 후 설정)
    private String thumbnailPath;

    // 매물 옵션 정보 (DB 컬럼 아님, 조회 후 설정)
    private PropertyOption propertyOption;
}