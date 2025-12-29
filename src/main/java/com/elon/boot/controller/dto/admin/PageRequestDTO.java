package com.elon.boot.controller.dto.admin;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PageRequestDTO {
	
	@Builder.Default
    private int page = 1;           // 현재 페이지
    
    @Builder.Default
    private int size = 10;          // 페이지당 항목 수
    
    private String searchCategory;  // 검색 카테고리
    private String searchKeyword;   // 검색 키워드
    
    // MyBatis에서 사용할 OFFSET 계산
    public int getOffset() {
        return (page - 1) * size;
    }
    
    // 유효성 검증
    public void validate() {
        if (page < 1) {
            page = 1;
        }
        if (size < 1 || size > 100) {
            size = 10;
        }
    }
}
