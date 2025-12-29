package com.elon.boot.domain.community.notice.model.service;

import java.util.List;

import com.elon.boot.controller.dto.notice.NoticeInsertRequest;
import com.elon.boot.controller.dto.notice.NoticeUpdateRequest;
import com.elon.boot.domain.community.notice.model.vo.Notice;

public interface NoticeService {
	
	// 홈페이지용 최근 공지사항 조회
	List<Notice> getRecentNotices(int limit);

	// 전체 공지사항 조회
    List<Notice> getAllNotices();
    
    // 중요 공지사항만 조회
    List<Notice> getImportantNotices();
    
    // 공지사항 상세 조회
    Notice getNoticeById(Integer noticeNo);
    
    // 공지사항 등록
    int createNotice(Notice notice);
    
    // 공지사항 수정
    int updateNotice(Notice notice);
    
    // 공지사항 삭제
    int deleteNotice(Integer noticeNo);

    
}
