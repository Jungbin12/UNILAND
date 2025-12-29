package com.elon.boot.domain.user.model.vo;

import java.sql.Timestamp;
import java.sql.Date;

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
public class User {
    private String userId;          // 사용자 ID
    private String userPassword;    // 비밀번호
    private String userName;        // 이름
    private Date birthDate;         // 생년월일
    private Integer userAge;        // 나이
    private String userGender;      // 성별 (M/F)
    private String userPhone;       // 전화번호
    private String userEmail;       // 이메일
    private String userRegion;      // 지역
    private String userSchool;      // 학교
    private String adminYn;         // 관리자 여부 (Y/N)
    private String deleteYn;        // 탈퇴 여부 (Y/N)
    private Timestamp createdAt;    // 가입일시
    private Timestamp updatedAt;    // 수정일시
}
