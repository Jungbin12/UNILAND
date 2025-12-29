package com.elon.boot.domain.inquiry.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 문의 VO
 * - 중개사 문의 (INQUIRY_TYPE = 'REALTOR')
 * - 관리자 문의 (INQUIRY_TYPE = 'ADMIN')
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Inquiry {
	
    private int inquiryId;              // 문의 ID (PK)
    private String userId;              // 문의자 ID
    private String inquiryType;         // 문의 타입: 'REALTOR' 또는 'ADMIN'
    private String category;            // 문의 카테고리 (ADMIN: '일반문의', '건의사항', '허위매물신고', '기타' / REALTOR: 'VISIT', 'PRICE', 'CONTRACT', 'ETC')
    private Integer propertyId;         // 매물 ID (중개사 문의 또는 허위매물 신고 시 필수)
    private String realtorId;           // 중개사 ID (중개사 문의 시 필수)
    private String title;               // 문의 제목
    private String content;             // 문의 내용
    private String status;              // 문의 상태: 'PENDING', 'ANSWERED', 'CLOSED'
    private String answer;              // 답변 내용
    private Date createdAt;             // 문의 작성일
    private Date answeredAt;            // 답변 작성일
    private String userName;            // 문의자 이름
    private String deleteYn;            // 삭제 여부 (Y/N)
    private String userPhone;           // 문의자 휴대폰 번호 (수정: usersPhone → userPhone)
    
    // ========================================
    // 추가 필드 (DB 컬럼 추가)
    // ========================================
    private String readYn;              // 읽음 여부 (Y/N)
    private Date readAt;                // 읽은 날짜
    
    // ========================================
    // 조인용 추가 필드 (선택사항)
    // ========================================
    private String propertyName;        // 매물명 (PROPERTY_TBL 조인)
    private String realtorName;         // 중개사명 (REALTOR_TBL 조인)
    private String userType;  			// 추가: USER 또는 REALTOR
}
