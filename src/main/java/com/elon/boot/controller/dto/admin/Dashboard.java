package com.elon.boot.controller.dto.admin;

import java.util.List;

import com.elon.boot.domain.community.notice.model.vo.Notice;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import com.elon.boot.domain.user.model.vo.User;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Dashboard {
	private int totalUsers;           // 총 일반 회원 수
	private int totalRealtors;		  // 총 중개사 회원 수
    private int totalProperties;      // 등록 매물 수
    private int pendingInquiries;     // 미처리 문의 수
    private List<Integer> dailyUserData;  // 일별 신규 회원 데이터
    private List<String> dailyLabels;     // 일별 라벨
    private List<Notice> recentNotices;   // 최근 공지사항
}
