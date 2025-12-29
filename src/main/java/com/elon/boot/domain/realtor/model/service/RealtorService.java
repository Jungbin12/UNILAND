package com.elon.boot.domain.realtor.model.service;

import com.elon.boot.domain.realtor.model.vo.Realtor;

public interface RealtorService {
    // 사업자 번호 중복 체크
    boolean isBusinessNumDuplicate(String businessNum);
    
    // 중개사 등록번호 중복 확인
    /**
     * 중개사 등록번호의 중복 여부를 확인합니다.
     * @param realtorRegNum 확인할 중개사 등록번호
     * @return 중복되면 true, 아니면 false
     */
    boolean isRealtorRegNumDuplicate(String realtorRegNum);

    // 중개사 회원가입
    boolean registerRealtor(Realtor realtor);
    
    // 로그인 시 정보 조회 (승인 상태 포함)
    Realtor getRealtorByLogin(String realtorId, String password, String businessNumber);

    // 회원 정보 수정
    /**
     * 중개사 회원 정보를 수정합니다.
     * @param realtor 수정할 정보가 담긴 Realtor VO 객체 (ID 포함)
     * @return 수정 성공 여부 (true/false)
     */
    boolean updateRealtor(Realtor realtor);

    // 회원 탈퇴
    /**
     * 중개사 계정을 탈퇴(삭제 또는 비활성화) 처리합니다.
     * @param realtorId 탈퇴할 중개사의 ID
     * @return 탈퇴 성공 여부 (true/false)
     */
    boolean deleteRealtor(String realtorId);
    
    // ID 기준 회원 정보 조회
    /**
     * 중개사 ID로 전체 회원 정보를 조회합니다.
     * @param realtorId 조회할 중개사의 ID
     * @return 해당 ID의 Realtor 객체
     */
    Realtor getRealtorById(String realtorId); 
    
    // 프로필 이미지 업데이트
    /**
     * 중개사의 프로필 이미지 파일명을 업데이트합니다.
     * @param realtorId 중개사 ID
     * @param savedFileName 서버에 저장된 새 파일명
     * @return 업데이트 성공 여부 (true/false)
     */
    boolean updateRealtorImage(String realtorId, String savedFileName);

    // ⭐ 이메일로 중개사 조회 (비밀번호 찾기용)
    /**
     * 이메일로 가입된 중개사 조회
     * @param email 조회할 이메일
     * @return 이메일과 일치하는 Realtor 객체 또는 null
     */
    default Realtor getRealtorByEmail(String email) {
        // 구현체에서 실제 DB 조회 로직 필요
        return null;
    }

    // ⭐ 전화번호로 중개사 조회 (비밀번호 찾기용)
    /**
     * 전화번호로 가입된 중개사 조회
     * @param phone 조회할 전화번호
     * @return 전화번호와 일치하는 Realtor 객체 또는 null
     */
    default Realtor getRealtorByPhone(String phone) {
        // 구현체에서 실제 DB 조회 로직 필요
        return null;
    }
}
