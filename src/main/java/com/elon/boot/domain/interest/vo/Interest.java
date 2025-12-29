package com.elon.boot.domain.interest.vo;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class Interest {
    private Long interestNo;
    private String userId;
    private Long propertyNo;
    private String isFavorite; // 'Y' or 'N'
    private LocalDateTime createdAt;
}