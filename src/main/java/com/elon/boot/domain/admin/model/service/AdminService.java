package com.elon.boot.domain.admin.model.service;

import java.util.List;

import com.elon.boot.controller.dto.admin.Dashboard;
import com.elon.boot.controller.dto.admin.PageRequestDTO;
import com.elon.boot.controller.dto.admin.PageResponseDTO;
import com.elon.boot.controller.dto.admin.PropertyAdminDTO;
import com.elon.boot.controller.dto.admin.RealtorApproval;
import com.elon.boot.controller.dto.admin.UserManagement;
import com.elon.boot.domain.community.notice.model.vo.Notice;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.realtor.model.vo.Realtor;

public interface AdminService {

	List<Notice> getAllNotices();

	int deleteUser(String userId);

	UserManagement getUserManagementData();

	int deleteRealtor(String realtorId);

	Dashboard getDashboardData();

	RealtorApproval getRealtorApprovalData();

	int approveRealtor(String realtorId);

	int rejectRealtor(String realtorId);

	int cancelApproval(String realtorId);

	/**
     * 관리자 매물 목록 조회
     */
    List<PropertyAdminDTO> getPropertyListForAdmin();
    
    /**
     * 페이징 처리된 매물 목록 조회
     */
    PageResponseDTO<PropertyAdminDTO> getPropertyListWithPaging(PageRequestDTO pageRequest);
    
    /**
     * 검색 조건에 따른 매물 목록 조회 (기존 호환성 유지)
     */
    List<PropertyAdminDTO> searchPropertyListForAdmin(String searchCategory, String searchKeyword);
    
    /**
     * 매물 상태 변경
     */
    boolean updatePropertyStatus(Long propertyNo, String status);
    
    /**
     * 매물 상세 조회
     */
    Property getPropertyByNo(Long propertyNo);
	Realtor getRealtorById(String realtorId);

}
