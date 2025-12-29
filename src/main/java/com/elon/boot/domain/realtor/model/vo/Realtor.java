package com.elon.boot.domain.realtor.model.vo;

import java.sql.Timestamp;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Realtor {
    private String realtorId;          // 중개사 아이디
    private String realtorPassword;    // 비밀번호
    private String officeName;         // 사무실 이름
    private String realtorName;        // 중개사 이름
    private String realtorAddress;     // 주소
    private String realtorPhone;       // 전화번호
    private String realtorEmail;       // 이메일
    private String businessNum;        // 사업자 번호
    private String realtorImage;       // 프로필 이미지 파일명
    private String realtorRegNum;      // 중개사 등록번호
    private Timestamp createdAt;       // 생성일시
    private Timestamp updatedAt;       // 수정일시
    private String deleteYn;           // 삭제 여부 (Y/N)
    private String approvalStatus;     // 승인 상태 (PENDING/APPROVED 등)

    // 🔹 추가 가능: 이메일 또는 전화번호 기반 검색 시 사용
    // (컨트롤러에서 바로 VO의 필드를 사용하므로 별도 필드 추가는 불필요)
}
