package com.elon.boot.domain.admin.model.service.impl;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.elon.boot.controller.dto.admin.Dashboard;
import com.elon.boot.controller.dto.admin.PageRequestDTO;
import com.elon.boot.controller.dto.admin.PageResponseDTO;
import com.elon.boot.controller.dto.admin.PropertyAdminDTO;
import com.elon.boot.controller.dto.admin.RealtorApproval;
import com.elon.boot.controller.dto.admin.UserManagement;
import com.elon.boot.domain.admin.model.service.AdminService;
import com.elon.boot.domain.admin.model.store.AdminMapper;
import com.elon.boot.domain.community.notice.model.service.impl.NoticeServiceImpl;
import com.elon.boot.domain.community.notice.model.store.NoticeMapper;
import com.elon.boot.domain.community.notice.model.vo.Notice;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import com.elon.boot.domain.user.model.vo.User;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class AdminServiceImpl implements AdminService {
	
	private final AdminMapper adminMapper;


	@Override
	public List<Notice> getAllNotices() {
		try {
            List<Notice> noticeList = adminMapper.selectAllNotices();
            log.debug("공지사항 조회 성공: {} 건", noticeList != null ? noticeList.size() : 0);
            return noticeList;
        } catch (Exception e) {
            log.error("공지사항 조회 실패: ", e);
            throw e;
        }
	}

	@Override
	public UserManagement getUserManagementData() {
		List<User> userList = adminMapper.selectAllUsers();
        List<Realtor> realtorList = adminMapper.selectAllRealtors();
        
        log.debug("회원 목록 조회: {} 건", userList.size());
        log.debug("중개사 목록 조회: {} 건", realtorList.size());
        
        return new UserManagement(userList, realtorList);
	}

	@Override
	public int deleteUser(String userId) {
		return adminMapper.deleteUser(userId);
	}

	@Override
	public int deleteRealtor(String realtorId) {
		return adminMapper.deleteRealtor(realtorId);
	}

	@Override
	public Dashboard getDashboardData() {
		Dashboard dashboard = new Dashboard();
        
        try {
            // 총 일반 회원 수
        	dashboard.setTotalUsers(adminMapper.countTotalUsers());
        	
        	// 총 중개사 회원 수
        	dashboard.setTotalRealtors(adminMapper.countTotalRealtors());
            
            // 총 매물 수 (PROPERTY_TBL이 없으면 0으로 설정)
            try {
                dashboard.setTotalProperties(adminMapper.countTotalProperties());
            } catch (Exception e) {
                log.warn("매물 테이블이 존재하지 않습니다: {}", e.getMessage());
                dashboard.setTotalProperties(0);
            }
            
            // 미처리 문의 수 (INQUIRY_TBL이 없으면 0으로 설정)
            try {
                dashboard.setPendingInquiries(adminMapper.countPendingInquiries());
            } catch (Exception e) {
                log.warn("문의 테이블이 존재하지 않습니다: {}", e.getMessage());
                dashboard.setPendingInquiries(0);
            }
            
            // 일별 신규 회원 통계 (최근 한 달)
            List<Map<String, Object>> dailyStats = adminMapper.selectDailyUserStats(30);
            List<String> labels = new ArrayList<>();
            List<Integer> data = new ArrayList<>();
            
            for (Map<String, Object> stat : dailyStats) {
                labels.add((String) stat.get("DATE"));
                data.add(((Number) stat.get("COUNT")).intValue());
            }
            
            dashboard.setDailyLabels(labels);
            dashboard.setDailyUserData(data);
            
            // 최근 공지사항 5개
            dashboard.setRecentNotices(adminMapper.selectRecentNotices(5));
            
            log.debug("대시보드 데이터 조회 완료");
            
        } catch (Exception e) {
            log.error("대시보드 데이터 조회 실패: ", e);
        }
        
        return dashboard;
    }

	@Override
	public RealtorApproval getRealtorApprovalData() {
		List<Realtor> pendingRealtors = adminMapper.selectRealtorsByStatus("PENDING");
        List<Realtor> approvedRealtors = adminMapper.selectRealtorsByStatus("APPROVAL");
        List<Realtor> rejectedRealtors = adminMapper.selectRealtorsByStatus("REJECTED");
        
        log.debug("중개사 승인 데이터 조회: 대기 {} 건, 승인 {} 건, 거부 {} 건",
            pendingRealtors.size(), approvedRealtors.size(), rejectedRealtors.size());
        
        return new RealtorApproval(pendingRealtors, approvedRealtors, rejectedRealtors);
	}

	@Override
	public int approveRealtor(String realtorId) {
		Map<String, Object> params = new HashMap<>();
        params.put("realtorId", realtorId);
        params.put("approvalStatus", "APPROVAL");
        params.put("status", "ACTIVE");
        
        log.debug("중개사 승인 처리: {}", realtorId);
        return adminMapper.updateRealtorApprovalStatus(params);
	}

	@Override
	public int rejectRealtor(String realtorId) {
		Map<String, Object> params = new HashMap<>();
        params.put("realtorId", realtorId);
        params.put("approvalStatus", "REJECTED");
        params.put("status", "INACTIVE");
        
        log.debug("중개사 거부 처리: {}", realtorId);
        return adminMapper.updateRealtorApprovalStatus(params);
	}

	@Override
	public int cancelApproval(String realtorId) {
		Map<String, Object> params = new HashMap<>();
        params.put("realtorId", realtorId);
        params.put("approvalStatus", "PENDING");
        params.put("status", "INACTIVE");
        
        log.debug("중개사 승인 취소: {}", realtorId);
        return adminMapper.updateRealtorApprovalStatus(params);
	}

	@Override
    public List<PropertyAdminDTO> getPropertyListForAdmin() {
        log.info("관리자 매물 목록 조회 시작");
        List<PropertyAdminDTO> list = adminMapper.selectPropertyListForAdmin();
        
        // 가격 표시 형식 설정
        list.forEach(this::setPriceDisplay);
        
        log.info("관리자 매물 목록 조회 완료: {} 건", list.size());
        return list;
    }
    
    @Override
    public PageResponseDTO<PropertyAdminDTO> getPropertyListWithPaging(PageRequestDTO pageRequest) {
        log.info("페이징 처리된 매물 목록 조회 시작 - 페이지: {}, 크기: {}, 카테고리: {}, 키워드: {}", 
            pageRequest.getPage(), pageRequest.getSize(), pageRequest.getSearchCategory(), pageRequest.getSearchKeyword());
        
        // 유효성 검증
        pageRequest.validate();
        
        // 전체 개수 조회
        long totalElements = adminMapper.countProperties(
            pageRequest.getSearchCategory(),
            pageRequest.getSearchKeyword()
        );
        
        log.info("전체 매물 개수: {}", totalElements);
        
        // 페이징 처리된 목록 조회
        List<PropertyAdminDTO> list = adminMapper.selectPropertyListWithPaging(
            pageRequest.getOffset(),
            pageRequest.getSize(),
            pageRequest.getSearchCategory(),
            pageRequest.getSearchKeyword()
        );
        
        log.info("조회된 매물 개수: {}", list.size());
        
        // 가격 표시 형식 설정
        list.forEach(this::setPriceDisplay);
        
        // PageResponseDTO 생성
        PageResponseDTO<PropertyAdminDTO> response = PageResponseDTO.of(
            list,
            pageRequest.getPage(),
            pageRequest.getSize(),
            totalElements
        );
        
        log.info("페이징 정보 - 현재: {}/{}, 첫페이지: {}, 마지막: {}, 다음: {}, 이전: {}", 
            response.getCurrentPage(), response.getTotalPages(), 
            response.isFirst(), response.isLast(), 
            response.isHasNext(), response.isHasPrevious());
        
        return response;
    }
    
    @Override
    public List<PropertyAdminDTO> searchPropertyListForAdmin(String searchCategory, String searchKeyword) {
        log.info("매물 검색 시작 - 카테고리: {}, 키워드: {}", searchCategory, searchKeyword);
        
        // 페이징 요청 객체 생성
        PageRequestDTO pageRequest = PageRequestDTO.builder()
            .page(1)
            .size(1000) // 검색 시 전체 조회
            .searchCategory(searchCategory)
            .searchKeyword(searchKeyword)
            .build();
        
        PageResponseDTO<PropertyAdminDTO> response = getPropertyListWithPaging(pageRequest);
        
        log.info("매물 검색 완료: {} 건", response.getContent().size());
        return response.getContent();
    }
    
    @Override
    @Transactional
    public boolean updatePropertyStatus(Long propertyNo, String status) {
        log.info("매물 상태 변경 시작 - 매물번호: {}, 변경할 상태: {}", propertyNo, status);
        
        // 상태값 검증
        if (!isValidStatus(status)) {
            log.error("유효하지 않은 상태값: {}", status);
            return false;
        }
        
        int result = adminMapper.updatePropertyStatus(propertyNo, status);
        
        if (result > 0) {
            log.info("매물 상태 변경 성공 - 매물번호: {}", propertyNo);
            return true;
        } else {
            log.error("매물 상태 변경 실패 - 매물번호: {}", propertyNo);
            return false;
        }
    }
    
    @Override
    public Property getPropertyByNo(Long propertyNo) {
        log.info("매물 상세 조회 - 매물번호: {}", propertyNo);
        return adminMapper.selectPropertyByNo(propertyNo);
    }
    
    /**
     * 가격 표시 형식 설정 (만원 단위)
     */
    private void setPriceDisplay(PropertyAdminDTO dto) {
        if (dto.getDeposit() != null && dto.getMonthlyRent() != null) {
            if (dto.getMonthlyRent() == 0) {
                // 전세
                dto.setPriceDisplay(formatPrice(dto.getDeposit()));
            } else {
                // 월세
                dto.setPriceDisplay(
                    formatPrice(dto.getDeposit()) + " / " + 
                    formatPrice(dto.getMonthlyRent())
                );
            }
        } else if (dto.getDeposit() != null) {
            dto.setPriceDisplay(formatPrice(dto.getDeposit()));
        } else {
            dto.setPriceDisplay("가격 미정");
        }
        
        // 위치 정보 설정
        if (dto.getRoadAddress() != null && !dto.getRoadAddress().isEmpty()) {
            dto.setLocation(dto.getRoadAddress());
        } else if (dto.getProvince() != null && dto.getDistrict() != null) {
            dto.setLocation(dto.getProvince() + " " + dto.getDistrict());
        } else {
            dto.setLocation("위치 미정");
        }
    }
    
    /**
     * 상태값 유효성 검증
     */
    private boolean isValidStatus(String status) {
        return "ACTIVE".equals(status) || 
               "RESERVED".equals(status) || 
               "COMPLETED".equals(status) || 
               "DELETED".equals(status);
    }
    
    /**
     * 가격 포맷 (만원 단위)
     */
    private String formatPrice(Integer price) {
        if (price == null || price == 0) {
            return "0만원";
        }
        return String.format("%,d만원", price);
    }
	public Realtor getRealtorById(String realtorId) {
		return adminMapper.selectRealtorById(realtorId);
	}

}
