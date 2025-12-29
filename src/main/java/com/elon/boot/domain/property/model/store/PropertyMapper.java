package com.elon.boot.domain.property.model.store;

import com.elon.boot.controller.dto.property.PropertyAddRequest;
import com.elon.boot.controller.dto.property.PropertyFilterRequest;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.property.model.vo.PropertyImg;
import com.elon.boot.domain.property.model.vo.PropertyOption;
import com.elon.boot.domain.realtor.model.vo.Realtor;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map; // Map 타입을 사용하기 위해 추가

@Mapper
public interface PropertyMapper {
    int insertProperty(PropertyAddRequest pReq);
    int insertPropertyImages(@Param("list") List<PropertyImg> imgList);
	Property selectOneByNo(Long id);
	List<PropertyImg> selectImagesByPropertyNo(Long id);
	Realtor selectRealtorById(String rId);
	List<Property> selectAllProperties();
	List<Property> selectPropertiesWithFilter(@Param("filter") PropertyFilterRequest filter);

    // =========================================================================
    // ⭐ PropertyService 구현에 맞춰 추가된 매소드
    // =========================================================================

    /**
     * 중개사 ID를 기반으로 매물의 상태별 카운트를 조회합니다.
     * @param realtorId 중개사 ID
     * @return 상태별 카운트가 담긴 Map (예: {ALL_COUNT: 10, ACTIVE_COUNT: 5, ...})
     */
    Map<String, Integer> selectPropertyStatsByRealtorId(String realtorId);

    /**
     * 필터/검색 조건에 맞는 매물의 총 개수를 조회합니다. (페이징 카운트용)
     * @param filterParams 필터/검색 조건 Map (realtorId, STATUS, TYPE, searchKeyword 등 포함)
     * @return 매물 총 개수
     */
    int selectPropertyCount(Map<String, String> filterParams);

    /**
     * 필터/검색 조건과 페이징 정보에 맞는 매물 목록을 조회합니다.
     * @param filterParams 필터/검색 조건 Map (realtorId, startRow, limit 등 포함)
     * @return 매물 목록
     */
    List<Property> selectPropertyList(Map<String, String> filterParams);

    /**
     * 특정 매물의 상태를 업데이트합니다.
     * @param params 매물 번호(propertyNo)와 새로운 상태(newStatus)를 담은 Map
     * @return 업데이트된 행의 수 (성공 시 1)
     */
    int updatePropertyStatus(Map<String, Object> params);

    /**
     * 특정 매물을 'DELETED' 상태로 변경하여 비활성화(Soft Delete)합니다.
     * 중개사 ID를 함께 사용하여 소유권이 일치하는지 확인합니다.
     * @param params 매물 번호(propertyNo)와 중개사 ID(realtorId)를 담은 Map
     * @return 업데이트된 행의 수 (성공 시 1)
     */
    int softDeleteProperty(Map<String, Object> params);

    /**
     * 매물 정보를 수정합니다.
     * @param params 수정할 매물 정보 (propertyNo, status, propertyName, deposit, monthlyRent, maintenanceFee, availableDate, description, realtorId 포함)
     * @return 업데이트된 행의 수 (성공 시 1)
     */
    int updateProperty(Map<String, Object> params);

    /**
     * 계약 완료 처리를 수행합니다.
     * USER_ID, CONTRACT_STATUS, STATUS, CONTRACT_AT를 업데이트합니다.
     * @param params propertyNo, buyerUserId, realtorId를 담은 Map
     * @return 업데이트된 행의 수 (성공 시 1)
     */
    int completeContract(Map<String, Object> params);

    /**
     * 특정 사용자가 계약한 매물 목록을 조회합니다.
     * @param filterParams userId와 CONTRACT_STATUS를 담은 Map
     * @return 계약된 매물 목록
     */
    List<Property> selectContractedPropertiesByUserId(Map<String, String> filterParams);

	List<Property> selectListByNoList(List<Long> propertyNos);
	List<PropertyImg> getImgListByNoList(List<Long> propertyNos);

	/**
	 * 최근 등록된 매물 5개를 조회합니다. (썸네일 이미지 포함)
	 * @return 최근 등록 매물 목록 (최대 5개)
	 */
	List<Property> selectRecentProperties();
}