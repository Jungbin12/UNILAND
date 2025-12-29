package com.elon.boot.controller.dto.admin;

import java.sql.Timestamp;

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
public class PropertyAdminDTO {
	private Long propertyNo;
    private String propertyName;
    private String propertyType;
    private String priceDisplay;        // 가격 표시용
    private Integer deposit;
    private Integer monthlyRent;
    private String location;            // 위치 (도로명 주소)
    private String ownerName;           // 등록자명
    private String ownerType;           // 등록자 구분 (중개사/일반)
    private String ownerContact;        // 연락처
    private String status;              // 상태 (ACTIVE/RESERVED/COMPLETED/DELETED)
    private Timestamp createdAt;        // 등록일
    
    // 추가 정보
    private String realtorId;
    private String userId;
    private String roadAddress;
    private String province;
    private String district;
    
    private Integer currentPage;
    private Integer currentPageSize;
    private String currentSearchCategory;
    private String currentSearchKeyword;
    private Integer totalPages;
}
