package com.elon.boot.domain.realtor.model.vo;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class Pagination {

    private int currentPage;  // 현재 페이지 번호
    private int listCount;    // 전체 게시글(매물) 수
    private int pageLimit;    // 한 페이지 그룹에 표시될 페이지 번호의 개수 (JSP 기준: 10)
    private int boardLimit;   // 한 페이지에 표시될 게시글(매물) 수 (JSP 기준: 9)

    private int maxPage;      // 가장 마지막 페이지 번호
    private int startPage;    // 페이지 목록의 시작 번호
    private int endPage;      // 페이지 목록의 끝 번호
    
    // MyBatis/DB 조회를 위한 필드
    private int startRow;     // 현재 페이지에서 시작될 행 번호 (OFFSET)

    /**
     * 페이징 정보를 계산하고 초기화하는 생성자입니다.
     * * @param currentPage 현재 페이지
     * @param listCount 전체 게시글 수
     * @param pageLimit 페이지 목록에 표시될 번호 개수 (예: 10)
     * @param boardLimit 한 페이지에 표시될 게시글 수 (예: 9)
     */
    public Pagination(int currentPage, int listCount, int pageLimit, int boardLimit) {
        this.currentPage = currentPage;
        this.listCount = listCount;
        this.pageLimit = pageLimit;
        this.boardLimit = boardLimit;
        
        // 모든 필드 계산
        calcPagination();
    }
    
    /**
     * 모든 페이징 관련 값을 계산하는 내부 메소드
     */
    private void calcPagination() {
        // 1. maxPage: 전체 페이지 중 가장 마지막 페이지
        // 공식: (전체 글 수 + 한 페이지에 보여줄 글 수 - 1) / 한 페이지에 보여줄 글 수
        // 또는 Math.ceil((double)listCount / boardLimit)
        this.maxPage = (int) Math.ceil((double)listCount / boardLimit);
        
        // 2. startPage: 페이지 목록의 시작 번호
        // 공식: (currentPage - 1) / pageLimit * pageLimit + 1
        this.startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
        
        // 3. endPage: 페이지 목록의 끝 번호
        // 공식: startPage + pageLimit - 1
        this.endPage = startPage + pageLimit - 1;

        // 4. endPage가 maxPage를 초과할 경우, maxPage로 조정
        if (endPage > maxPage) {
            endPage = maxPage;
        }
        
        // 5. startRow: DB LIMIT/OFFSET에 사용될 시작 행 번호
        // 공식: (currentPage - 1) * boardLimit
        this.startRow = (currentPage - 1) * boardLimit;
        
        // listCount가 0일 경우, 모든 값을 0으로 설정
        if (listCount == 0) {
            this.maxPage = 1; // 0이 아닌 1로 설정하여 JSP에서 오류가 나지 않도록 함
            this.currentPage = 1;
            this.startPage = 1;
            this.endPage = 1;
            this.startRow = 0;
        }
    }
}