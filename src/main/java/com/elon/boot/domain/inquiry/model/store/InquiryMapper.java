package com.elon.boot.domain.inquiry.model.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.elon.boot.domain.inquiry.model.vo.Inquiry;

/**
 * 문의 MyBatis Mapper 인터페이스
 */
@Mapper
public interface InquiryMapper {

	List<Inquiry> selectInquiriesByUserId(String userId);

	int insertInquiry(Inquiry inquiry);

	Inquiry selectInquiryById(Integer inquiryId);

	int deleteInquiry(Integer inquiryId);

	List<Inquiry> selectAllInquiriesForAdmin();

	int updateInquiryAnswer(Map<String, Object> params);
	

    // 중개사별 문의 조회 (매물명 포함)
    List<Inquiry> selectInquiriesByRealtorId(String realtorId);
    
    // 중개사 전체 문의 수 조회
    int countRealtorInquiries(String realtorId);
    
    // 중개사 상태별 문의 수 조회
    int countRealtorInquiriesByStatus(@Param("realtorId") String realtorId, 
                                      @Param("status") String status);
    
    // 중개사 오늘 받은 문의 수 조회
    int countRealtorInquiriesToday(String realtorId);
    
    // 문의 읽음 처리
    int updateInquiryReadStatus(Integer inquiryId);

	int markInquiryAsRead(int inquiryId);

	List<Inquiry> selectAdminInquiriesByUserId(String userId);

	List<Inquiry> selectRealtorInquiriesByUserId(String userId);

	int selectUnreadInquiryCount(String userId);
    

    // TODO: 문의 등록
    // int insertInquiry(Inquiry inquiry);

    // TODO: 사용자별 문의 조회
    // List<Inquiry> selectInquiriesByUserId(String userId);

    // TODO: 사용자별 + 타입별 문의 조회
    // List<Inquiry> selectInquiriesByType(@Param("userId") String userId,
    //                                     @Param("inquiryType") String inquiryType);

    // TODO: 문의 상세 조회
    // Inquiry selectInquiryById(int inquiryId);

    // TODO: 문의 답변 등록
    // int updateInquiryAnswer(@Param("inquiryId") int inquiryId,
    //                         @Param("answer") String answer);

    // TODO: 중개사별 문의 조회
    // List<Inquiry> selectInquiriesByRealtorId(String realtorId);

    // TODO: 관리자 문의 전체 조회
    // List<Inquiry> selectAdminInquiries();
}
