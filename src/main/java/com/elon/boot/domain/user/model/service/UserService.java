package com.elon.boot.domain.user.model.service;

import com.elon.boot.controller.dto.user.UserModRequest;
import com.elon.boot.domain.user.model.vo.User;

import jakarta.servlet.http.HttpSession;

public interface UserService {

    // 로그인
    User login(String userId, String userPassword);

    // ID로 회원 조회
    User getUserById(String userId);

    // 이메일로 회원 조회 (비밀번호 찾기)
    User getUserByEmail(String userEmail);

    // 전화번호로 회원 조회 (비밀번호 찾기)
    User getUserByPhone(String userPhone);

    // 회원가입
    int signUp(User user);

    // 회원정보 수정
    int updateUser(UserModRequest userModiReq);

    // 회원 탈퇴
    int deleteUser(String userId);

    // ID 중복 체크
    boolean checkDuplicateId(String userId);


}
