package com.elon.boot.domain.user.model.store;

import org.apache.ibatis.annotations.Mapper;

import com.elon.boot.controller.dto.user.UserModRequest;
import com.elon.boot.domain.user.model.vo.User;

@Mapper
public interface UserMapper {

    // 로그인 - ID와 비밀번호로 회원 조회
    User selectOneByLogin(User user);

    // ID로 회원 조회 (중복 체크, 상세 조회)
    User selectOneById(String userId);

    // 이메일로 회원 조회 (비밀번호 찾기)
    User selectOneByEmail(String userEmail);

    // 전화번호로 회원 조회 (비밀번호 찾기)
    User selectOneByPhone(String userPhone);

    // 회원가입 - 회원 정보 저장
    int insertUser(User user);

    // 회원정보 수정
    int updateUser(UserModRequest user);

    // 회원 탈퇴 (DELETE_YN = 'Y'로 변경)
    int deleteUser(String userId);
}
