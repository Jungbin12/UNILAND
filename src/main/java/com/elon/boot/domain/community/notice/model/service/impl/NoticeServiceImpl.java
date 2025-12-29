package com.elon.boot.domain.community.notice.model.service.impl;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.elon.boot.controller.dto.notice.NoticeInsertRequest;
import com.elon.boot.controller.dto.notice.NoticeUpdateRequest;
import com.elon.boot.domain.community.notice.model.service.NoticeService;
import com.elon.boot.domain.community.notice.model.store.NoticeMapper;
import com.elon.boot.domain.community.notice.model.vo.Notice;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class NoticeServiceImpl implements NoticeService {
	
private final NoticeMapper noticeMapper;
    
    @Override
	public List<Notice> getRecentNotices(int limit) {
    	return noticeMapper.selectRecentNotices(limit);
	}

	@Override
    public List<Notice> getAllNotices() {
        try {
            List<Notice> noticeList = noticeMapper.selectAllNotices();
            log.debug("공지사항 조회 성공: {} 건", noticeList != null ? noticeList.size() : 0);
            return noticeList;
        } catch (Exception e) {
            log.error("공지사항 조회 실패: ", e);
            throw e;
        }
    }
    
    @Override
    public List<Notice> getImportantNotices() {
        try {
            return noticeMapper.selectImportantNotices();
        } catch (Exception e) {
            log.error("중요 공지사항 조회 실패: ", e);
            throw e;
        }
    }
    
    @Override
    public Notice getNoticeById(Integer noticeNo) {
        try {
            // 조회수 증가
            noticeMapper.increaseViewCount(noticeNo);
            
            Notice notice = noticeMapper.selectNoticeById(noticeNo);
            log.debug("공지사항 상세 조회: {}", notice);
            return notice;
        } catch (Exception e) {
            log.error("공지사항 상세 조회 실패: ", e);
            throw e;
        }
    }
    
    @Override
    public int createNotice(Notice notice) {
        try {
            // 기본값 설정
            if (notice.getNoticeImportant() == null) {
                notice.setNoticeImportant("N");
            }
            if (notice.getNoticeIsnew() == null) {
                notice.setNoticeIsnew("N");
            }
            
            int result = noticeMapper.insertNotice(notice);
            log.debug("공지사항 등록 결과: {}", result);
            return result;
        } catch (Exception e) {
            log.error("공지사항 등록 실패: ", e);
            throw e;
        }
    }
    
    @Override
    public int updateNotice(Notice notice) {
        try {
            int result = noticeMapper.updateNotice(notice);
            log.debug("공지사항 수정 결과: {}", result);
            return result;
        } catch (Exception e) {
            log.error("공지사항 수정 실패: ", e);
            throw e;
        }
    }
    
    @Override
    public int deleteNotice(Integer noticeNo) {
        try {
            int result = noticeMapper.deleteNotice(noticeNo);
            log.debug("공지사항 삭제 결과: {}", result);
            return result;
        } catch (Exception e) {
            log.error("공지사항 삭제 실패: ", e);
            throw e;
        }
    }
}
