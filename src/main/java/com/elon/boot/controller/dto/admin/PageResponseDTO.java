package com.elon.boot.controller.dto.admin;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

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
public class PageResponseDTO <T> {

	@JsonProperty("content")
    private List<T> content;        // 현재 페이지 데이터
    
    @JsonProperty("currentPage")
    private int currentPage;        // 현재 페이지 번호
    
    @JsonProperty("totalPages")
    private int totalPages;         // 전체 페이지 수
    
    @JsonProperty("totalElements")
    private long totalElements;     // 전체 데이터 개수
    
    @JsonProperty("size")
    private int size;               // 페이지당 항목 수
    
    // boolean 필드는 is 접두어 제거 (Jackson 직렬화 문제 해결)
    private boolean first;          // 첫 페이지 여부
    
    private boolean last;           // 마지막 페이지 여부
    
    private boolean hasNext;        // 다음 페이지 존재 여부
    
    private boolean hasPrevious;    // 이전 페이지 존재 여부
    
    @JsonProperty("pageNumbers")
    private List<Integer> pageNumbers;  // 페이지 번호 리스트 (페이지 네비게이션용)
    
    // 생성자 - 페이징 정보 자동 계산
    public static <T> PageResponseDTO<T> of(List<T> content, int currentPage, int size, long totalElements) {
        int totalPages = (int) Math.ceil((double) totalElements / size);
        
           if (totalPages == 0) {
        	       totalPages = 1;                 // 페이지바 표시를 위한 최소 1페이지
        	       currentPage = 1;
        	   }
        
        PageResponseDTO<T> response = new PageResponseDTO<>();
        response.setContent(content);
        response.setCurrentPage(currentPage);
        response.setTotalPages(totalPages);
        response.setTotalElements(totalElements);
        response.setSize(size);
        response.setFirst(currentPage == 1);
        response.setLast(currentPage >= totalPages);
        response.setHasNext(currentPage < totalPages);
        response.setHasPrevious(currentPage > 1);
        
        // 페이지 번호 리스트 생성 (현재 페이지 기준 ±5)
        response.setPageNumbers(calculatePageNumbers(currentPage, totalPages));
        
        return response;
    }
    
    // 페이지 번호 리스트 계산
    private static List<Integer> calculatePageNumbers(int currentPage, int totalPages) {
        int startPage = Math.max(1, currentPage - 5);
        int endPage = Math.min(totalPages, currentPage + 5);
        
        return java.util.stream.IntStream.rangeClosed(startPage, endPage)
                .boxed()
                .collect(java.util.stream.Collectors.toList());
    }
    
    // Jackson이 올바르게 인식하도록 명시적 getter 추가
    @JsonProperty("first")
    public boolean isFirst() {
        return first;
    }
    
    @JsonProperty("last")
    public boolean isLast() {
        return last;
    }
    
    @JsonProperty("hasNext")
    public boolean isHasNext() {
        return hasNext;
    }
    
    @JsonProperty("hasPrevious")
    public boolean isHasPrevious() {
        return hasPrevious;
    }
}
