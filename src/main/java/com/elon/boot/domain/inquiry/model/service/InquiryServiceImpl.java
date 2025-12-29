package com.elon.boot.domain.inquiry.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.elon.boot.domain.inquiry.model.store.InquiryMapper;
import com.elon.boot.domain.inquiry.model.vo.Inquiry;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * 문의 서비스 구현
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class InquiryServiceImpl implements InquiryService {

    private final InquiryMapper inquiryMapper;
    
    @Override
    public List<Inquiry> getMyInquiries(String userId) {
        return inquiryMapper.selectInquiriesByUserId(userId);
    }

	@Override
	@Transactional
	public int createInquiry(Inquiry inquiry) {
		return inquiryMapper.insertInquiry(inquiry);
	}

	@Override
	public Inquiry getInquiryById(Integer inquiryId) {
		return inquiryMapper.selectInquiryById(inquiryId);
	}

	@Override
    @Transactional
    public int deleteInquiry(Integer inquiryId) {
        return inquiryMapper.deleteInquiry(inquiryId);
    }

//	관리자 문의 리스트
	@Override
    public List<Inquiry> getAllInquiries() {
        return inquiryMapper.selectAllInquiriesForAdmin();
    }
	
	@Override
    @Transactional
    public int answerInquiry(Integer inquiryId, String answer) {
        Map<String, Object> params = new HashMap<>();
        params.put("inquiryId", inquiryId);
        params.put("answer", answer);
        
        return inquiryMapper.updateInquiryAnswer(params);
    }

	@Override
	public List<Inquiry> getInquiriesByUserId(String userId) {
		return inquiryMapper.selectInquiriesByUserId(userId);
	}
	
	@Override
    public List<Inquiry> getRealtorInquiries(String realtorId) {
        return inquiryMapper.selectInquiriesByRealtorId(realtorId);
    }
    
    @Override
    public Map<String, Integer> getRealtorInquiryStats(String realtorId) {
        Map<String, Integer> stats = new HashMap<>();
        
        // 전체 문의 수
        int totalCount = inquiryMapper.countRealtorInquiries(realtorId);
        
        // 미답변 문의 수
        int pendingCount = inquiryMapper.countRealtorInquiriesByStatus(realtorId, "PENDING");
        
        // 답변완료 문의 수
        int answeredCount = inquiryMapper.countRealtorInquiriesByStatus(realtorId, "ANSWERED");
        
        // 오늘 받은 문의 수
        int todayCount = inquiryMapper.countRealtorInquiriesToday(realtorId);
        
        stats.put("totalCount", totalCount);
        stats.put("pendingCount", pendingCount);
        stats.put("answeredCount", answeredCount);
        stats.put("todayCount", todayCount);
        
        return stats;
    }
    
    @Override
    @Transactional
    public int answerRealtorInquiry(Integer inquiryId, String answer) {
        Map<String, Object> params = new HashMap<>();
        params.put("inquiryId", inquiryId);
        params.put("answer", answer);
        
        return inquiryMapper.updateInquiryAnswer(params);
    }
    
    @Override
    @Transactional
    public int markAsRead(Integer inquiryId) {
        return inquiryMapper.updateInquiryReadStatus(inquiryId);
    }

	@Override
	public int insertInquiry(Inquiry inquiry) {
		log.info("문의 등록: {}", inquiry.getTitle());
        return inquiryMapper.insertInquiry(inquiry);
	}

	@Override
	public int markInquiryAsRead(int inquiryId) {
		log.info("문의 읽음 처리: inquiryId={}", inquiryId);
        return inquiryMapper.markInquiryAsRead(inquiryId);
	}

	@Override
    @Transactional(readOnly = true)
    public List<Inquiry> getAdminInquiriesByUserId(String userId) {
        log.info("사용자별 관리자 문의 조회: userId={}", userId);
        return inquiryMapper.selectAdminInquiriesByUserId(userId);
    }

	@Override
    @Transactional(readOnly = true)
    public List<Inquiry> getRealtorInquiriesByUserId(String userId) {
        log.info("사용자별 중개사 문의 조회: userId={}", userId);
        return inquiryMapper.selectRealtorInquiriesByUserId(userId);
    }

	@Override
    @Transactional(readOnly = true)
    public int getUnreadInquiryCount(String userId) {
        log.info("미읽음 문의 개수 조회: userId={}", userId);
        return inquiryMapper.selectUnreadInquiryCount(userId);
    }
    
    
}
