package com.elon.boot.domain.realtor.model.store;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.elon.boot.domain.inquiry.model.vo.Inquiry;
import com.elon.boot.domain.realtor.model.vo.Realtor;

import java.util.List;
import java.util.Map; // Map 타입을 사용하기 위해 추가
import java.util.Properties;

@Mapper
public interface RealtorMapper {
    int countByBusinessNum(@Param("businessNum") String businessNum);
    
    // ⭐ 중개사 등록번호 중복 확인
    int countByRealtorRegNum(@Param("realtorRegNum") String realtorRegNum);

    int insertRealtor(Realtor realtor);
    
    // 로그인 정보 조회 (APPROVAL_STATUS 포함)
    Realtor findByLoginInfo(@Param("realtorId") String realtorId,
                            @Param("password") String password,
                            @Param("businessNumber") String businessNumber);

    // 중개사 ID로 정보 조회
    Realtor findById(@Param("realtorId") String realtorId);

    // 회원 정보 수정
    int updateRealtor(Realtor realtor);

    // 회원 탈퇴 (삭제 또는 비활성화)
    int deleteRealtor(@Param("realtorId") String realtorId);
    
    // 프로필 이미지 파일명 업데이트
    int updateRealtorImage(Map<String, Object> params);

    // ⭐ 추가: 이메일로 중개사 조회 (비밀번호 찾기용)
    /**
     * 이메일로 가입된 중개사 조회
     * @param email 조회할 이메일
     * @return 이메일과 일치하는 Realtor 객체 또는 null
     */
    Realtor findByEmail(@Param("email") String email);

    // ⭐ 추가: 전화번호로 중개사 조회 (비밀번호 찾기용)
    /**
     * 전화번호로 가입된 중개사 조회
     * @param phone 조회할 전화번호
     * @return 전화번호와 일치하는 Realtor 객체 또는 null
     */
    Realtor findByPhone(@Param("phone") String phone);
    
    int countProperties(String realtorId);
    int countCompletedDeals(String realtorId);
    int countNewInquiries(String realtorId);
    List<Properties> selectRecentProperties(String realtorId);
    List<Inquiry> selectRecentInquiries(String realtorId);
}
