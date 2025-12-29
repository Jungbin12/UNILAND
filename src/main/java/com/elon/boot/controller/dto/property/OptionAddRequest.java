package com.elon.boot.controller.dto.property;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
public class OptionAddRequest {
    @JsonIgnore
    private Long propertyOptionNo;
    @JsonIgnore
    private Long propertyNo;

    private String airConditioner;
    private String heater;

    private String refrigerator;
    private String microwave;
    private String induction;
    private String gasStove;

    private String washer;
    private String dryer;
    private String bed;
    private String desk;
    private String wardrobe;
    private String shoeRack;
    private String tv;

    private String parking;
    private String elevator;
    private String security;
    private String petAllowed;
}
