package com.elon.boot.domain.community.notice.model.store;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.elon.boot.controller.dto.notice.NoticeInsertRequest;
import com.elon.boot.controller.dto.notice.NoticeUpdateRequest;
import com.elon.boot.domain.community.notice.model.vo.Notice;

@Mapper
public interface NoticeMapper {
	
	// 홈페이지용 최근 공지사항 조회
	List<Notice> selectRecentNotices(int limit);
    
	// 전체 공지사항 조회
    List<Notice> selectAllNotices();
    
    // 중요 공지사항만 조회
    List<Notice> selectImportantNotices();
    
    // 공지사항 상세 조회
    Notice selectNoticeById(Integer noticeNo);
    
    // 공지사항 등록
    int insertNotice(Notice notice);
    
    // 공지사항 수정
    int updateNotice(Notice notice);
    
    // 공지사항 삭제 (논리 삭제)
    int deleteNotice(Integer noticeNo);
    
    // 조회수 증가
    int increaseViewCount(Integer noticeNo);
}
