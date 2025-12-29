package com.elon.boot.domain.property.model.service.impl;

import com.elon.boot.controller.dto.property.OptionAddRequest;
import com.elon.boot.controller.dto.property.PropertyAddRequest;
import com.elon.boot.controller.dto.property.PropertyFilterRequest;
import com.elon.boot.domain.property.model.service.PropertyService;
import com.elon.boot.domain.property.model.store.OptionMapper;
import com.elon.boot.domain.property.model.store.PropertyMapper;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.property.model.vo.PropertyOption;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import com.elon.boot.domain.property.model.vo.PropertyImg;
import com.elon.boot.domain.realtor.model.vo.Pagination; // Pagination 사용을 위해 임포트 (가정)
import com.elon.boot.util.Util;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.*;
import java.util.*;

// Lombok의 @Slf4j를 추가하여 로깅 기능을 사용할 수 있도록 가정합니다.
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j // 로깅 기능 추가
public class PropertyServiceImpl implements PropertyService {

    private final PropertyMapper propertyMapper;
    private final OptionMapper optionMapper;

    @Value("${file.upload-dir}")
    private String uploadRoot; // C:/UploadImage

    private String yn(String v) {
        return (v != null && v.equalsIgnoreCase("Y")) ? "Y" : "N";
    }

    @Transactional
    @Override
    public Long register(PropertyAddRequest pReq,
            OptionAddRequest oReq,
            List<MultipartFile> images,
            String realtorId) {

        // 1) 세션값 주입 후 매물 INSERT (selectKey가 DTO pReq.propertyNo에 꽂힘)
        pReq.setRealtorId(realtorId);
        propertyMapper.insertProperty(pReq);

        // 2) PK는 INSERT "직후" 꺼내고, 메서드 전체에서 쓸 수 있도록 같은 스코프에 선언
        final Long propNo = pReq.getPropertyNo();
        if (propNo == null) {
            log.error("매물 등록 실패: propertyNo가 null입니다. (selectKey 매핑/parameterType 확인)");
            throw new IllegalStateException("propertyNo null (selectKey 매핑/parameterType 확인)");
        }

        // 3) 옵션 INSERT (FK 세팅)
        oReq.setPropertyNo(propNo);
        optionMapper.insertOption(oReq);

        // 4) 이미지 INSERT (FK 세팅 + 파일 저장)
        if (images != null && !images.isEmpty()) {
            if (uploadRoot == null || uploadRoot.trim().isEmpty()) {
               throw new IllegalStateException("file.upload-dir 설정이 없습니다. application.properties를 확인하세요.");
            }

            File uploadDir = new File(uploadRoot, "property");
            if (!uploadDir.exists()) {
               boolean created = uploadDir.mkdirs();
               if (!created) {
                   throw new RuntimeException("업로드 디렉토리 생성 실패: " + uploadDir.getAbsolutePath());
               }
            }

            List<PropertyImg> imgList = new ArrayList<>();
            for (int i = 0; i < images.size(); i++) {
               MultipartFile image = images.get(i);
               if (image == null || image.isEmpty()) continue;

               String original = image.getOriginalFilename();
               String rename   = Util.fileRename(original);

               PropertyImg img = new PropertyImg();
               img.setPropertyNo(propNo);
               img.setImgOrder(i);
               img.setImgOriginalName(original);
               img.setImgRename(rename);
               img.setImgPath("/images/property/" + rename);
               imgList.add(img);

               File target = new File(uploadDir, rename);
               try {
                   image.transferTo(target);
               } catch (IOException | IllegalStateException e) {
                   log.error("이미지 저장 실패: {}", original, e);
                   throw new RuntimeException("이미지 저장 실패: " + original, e);
               }
            }
            if (!imgList.isEmpty()) {
               propertyMapper.insertPropertyImages(imgList);
            }
        }

        log.info("새 매물 등록 완료. PropertyNo: {}", propNo);
        return propNo;
    }

    // =========================================================================
    // ✅ 기존 메소드 - 유지
    // =========================================================================

	@Override
	public Property selectOneByNo(Long id) {
		return propertyMapper.selectOneByNo(id);
	}

	@Override
	public PropertyOption selectOnesOption(Long id) {
		return optionMapper.selectOnesOption(id);
	}

	@Override
	public List<PropertyImg> selectOnesImgs(Long id) {
		return propertyMapper.selectImagesByPropertyNo(id);
	}

	@Override
	public Realtor selectRealtorById(String rId) {
		return propertyMapper.selectRealtorById(rId);
	}

	@Override
	public List<Property> getAllProperties() {
		return propertyMapper.selectAllProperties();
	}

	@Override
	public List<Property> getFilteredProperties(PropertyFilterRequest filter) {
		return propertyMapper.selectPropertiesWithFilter(filter);
	}

    // =========================================================================
    // ⭐ PropertyService 인터페이스에 맞춰 추가된 메소드 구현
    // =========================================================================

    /**
     * 중개사 ID 기준으로 매물 상태별 통계를 조회합니다.
     */
    @Override
    public Map<String, Integer> getPropertyStatsByRealtor(String realtorId) {
        // Mapper에서 Map<String, Integer>를 리턴하는 Mapper 메소드가 있다고 가정하고 호출합니다.
        Map<String, Integer> stats = propertyMapper.selectPropertyStatsByRealtorId(realtorId);

        // 결과가 null이거나 일부 키가 없을 경우를 대비하여 기본값으로 채워 Map을 리턴할 수 있습니다.
        if (stats == null) {
            stats = new HashMap<>();
        }

        // NullPointerException 방지를 위해 기본값을 넣어줍니다.
        stats.putIfAbsent("ALL_COUNT", 0);
        stats.putIfAbsent("ACTIVE_COUNT", 0);
        stats.putIfAbsent("RESERVED_COUNT", 0);
        stats.putIfAbsent("COMPLETED_COUNT", 0);

        return stats;
    }

    /**
     * 중개사의 필터/검색 조건에 맞는 전체 매물 개수를 조회합니다.
     */
    @Override
    public int getPropertyCount(Map<String, String> filterParams) {
        return propertyMapper.selectPropertyCount(filterParams);
    }

    /**
     * 중개사의 필터/검색 조건 및 페이징 정보에 맞는 매물 목록을 조회합니다.
     */
    @Override
    public List<Property> selectPropertyList(Map<String, String> filterParams, Pagination pager) {
        // pager가 null이 아닌 경우에만 페이징 정보 추가
        if (pager != null) {
            filterParams.put("startRow", String.valueOf(pager.getStartRow()));
            filterParams.put("limit", String.valueOf(pager.getBoardLimit()));
        }

        return propertyMapper.selectPropertyList(filterParams);
    }

    /**
     * 특정 매물의 상태를 변경합니다.
     */
    @Transactional
    @Override
    public int updatePropertyStatus(int propertyNo, String newStatus) {
        // 매물 번호와 새로운 상태를 담은 Map을 생성
        Map<String, Object> params = new HashMap<>();
        params.put("propertyNo", propertyNo);
        params.put("newStatus", newStatus);

        return propertyMapper.updatePropertyStatus(params);
    }

    /**
     * 특정 매물을 삭제합니다. (중개사 소유권 확인 로직 포함)
     */
    @Transactional
    @Override
    public int deleteProperty(int propertyNo, String realtorId) {

        // 매물 번호와 중개사 ID를 담은 Map 생성
        Map<String, Object> params = new HashMap<>();
        params.put("propertyNo", propertyNo);
        params.put("realtorId", realtorId);

        // *안전한 방식: 상태만 'DELETED'로 변경 (Soft Delete)*
        int result = propertyMapper.softDeleteProperty(params);

        if (result > 0) {
            log.warn("매물 {}이 중개사 {}에 의해 soft-delete 처리되었습니다.", propertyNo, realtorId);
        } else {
            log.warn("매물 {} soft-delete 실패: 소유권 불일치 또는 매물 없음.", propertyNo);
        }

        return result;
    }

    /**
     * 매물 번호로 특정 매물 정보를 조회합니다.
     */
    @Override
    public Property selectPropertyById(int propertyNo) {
        return propertyMapper.selectOneByNo(Long.valueOf(propertyNo));
    }

    /**
     * 매물 번호로 해당 매물의 옵션 목록을 조회합니다.
     */
    @Override
    public List<PropertyOption> selectPropertyOptions(int propertyNo) {
        PropertyOption option = optionMapper.selectOnesOption(Long.valueOf(propertyNo));
        return option != null ? java.util.Arrays.asList(option) : java.util.Collections.emptyList();
    }

    /**
     * 매물 번호로 해당 매물의 이미지 목록을 조회합니다.
     */
    @Override
    public List<PropertyImg> selectPropertyImages(int propertyNo) {
        return propertyMapper.selectImagesByPropertyNo(Long.valueOf(propertyNo));
    }

    /**
     * 매물 정보를 수정합니다.
     */
    @Transactional
    @Override
    public int updateProperty(Map<String, Object> params) {
        return propertyMapper.updateProperty(params);
    }

    /**
     * 계약 완료 처리를 수행합니다.
     * USER_ID, CONTRACT_STATUS, STATUS, CONTRACT_AT 업데이트
     */
    @Transactional
    @Override
    public int completeContract(int propertyNo, String buyerUserId, String realtorId) {
        Map<String, Object> params = new HashMap<>();
        params.put("propertyNo", propertyNo);
        params.put("buyerUserId", buyerUserId);
        params.put("realtorId", realtorId);
        return propertyMapper.completeContract(params);
    }

    /**
     * 특정 사용자가 계약한 매물 목록을 조회합니다.
     */
    @Override
    public List<Property> getContractedPropertiesByUserId(Map<String, String> filterParams) {
        return propertyMapper.selectContractedPropertiesByUserId(filterParams);
    }

	@Override
	public List<Property> selectListByNoList(List<Long> propertyNos) {
		return propertyMapper.selectListByNoList(propertyNos);
	}

	@Override
	public List<PropertyImg> getImgListByNoList(List<Long> propertyNos) {
		return propertyMapper.getImgListByNoList(propertyNos);
	}

	/**
	 * 최근 등록된 매물 5개를 조회합니다. (썸네일 이미지 및 옵션 포함)
	 */
	@Override
	public List<Property> getRecentProperties() {
		List<Property> properties = propertyMapper.selectRecentProperties();

		// 각 매물에 대해 옵션 정보를 조회하여 설정
		for (Property property : properties) {
			PropertyOption option = optionMapper.selectOnesOption(property.getPropertyNo());
			property.setPropertyOption(option);
		}

		return properties;
	}
}