package com.elon.boot.domain.property.model.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class PropertyOption {
    private Long propertyOptionNo;
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