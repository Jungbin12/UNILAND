package com.elon.boot.controller.dto.property;

import lombok.*;
import java.util.List;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class PropertyFilterRequest {
    // 지역 필터
    private List<String> regions;

    // 학교 필터
    private List<SchoolLocation> schoolLocations;
    private Double schoolRadius; // km 단위

    @Getter
    @Setter
    @ToString
    @NoArgsConstructor
    @AllArgsConstructor
    public static class SchoolLocation {
        private String name;
        private Double latitude;
        private Double longitude;
    }

    // 가격 필터
    private Integer depositMin;
    private Integer depositMax;
    private Integer rentMin;
    private Integer rentMax;

    // 매물 유형 필터
    private List<String> propertyTypes;

    // 학생 특화 필터
    private Boolean studentPref;
    private Boolean shortCont;

    // 옵션 필터
    private Boolean airConditioner;
    private Boolean heater;
    private Boolean refrigerator;
    private Boolean microwave;
    private Boolean induction;
    private Boolean gasStove;
    private Boolean washer;
    private Boolean dryer;
    private Boolean bed;
    private Boolean desk;
    private Boolean wardrobe;
    private Boolean shoeRack;
    private Boolean tv;
    private Boolean parking;
    private Boolean elevator;
    private Boolean security;
    private Boolean petAllowed;
}
