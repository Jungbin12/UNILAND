package com.elon.boot.domain.admin.model.store;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.elon.boot.controller.dto.admin.PropertyAdminDTO;
import com.elon.boot.domain.community.notice.model.vo.Notice;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import com.elon.boot.domain.user.model.vo.User;

@Mapper
public interface AdminMapper {

	List<Notice> selectAllNotices();

	List<User> selectAllUsers();

	List<Realtor> selectAllRealtors();

	int deleteUser(String userId);

	int deleteRealtor(String realtorId);

	int countTotalUsers();

	int countTotalProperties();

	List<Map<String, Object>> selectDailyUserStats(int i);

	int countPendingInquiries();

	List<Notice> selectRecentNotices(int i);

	int countTotalRealtors();

	List<Realtor> selectRealtorsByStatus(String string);

	int updateRealtorApprovalStatus(Map<String, Object> params);

	/**
     * 관리자 매물 목록 조회 (DELETED 제외)
     */
    List<PropertyAdminDTO> selectPropertyListForAdmin();
    
    /**
     * 페이징 처리된 매물 목록 조회
     */
    List<PropertyAdminDTO> selectPropertyListWithPaging(
        @Param("offset") int offset,
        @Param("size") int size,
        @Param("searchCategory") String searchCategory,
        @Param("searchKeyword") String searchKeyword
    );
    
    /**
     * 전체 매물 개수 조회 (페이징용)
     */
    long countProperties(
        @Param("searchCategory") String searchCategory,
        @Param("searchKeyword") String searchKeyword
    );
    
    /**
     * 매물 상태 변경
     */
    int updatePropertyStatus(
        @Param("propertyNo") Long propertyNo,
        @Param("status") String status
    );
    
    /**
     * 매물 상세 조회
     */
    Property selectPropertyByNo(@Param("propertyNo") Long propertyNo);
	Realtor selectRealtorById(String realtorId);

}
