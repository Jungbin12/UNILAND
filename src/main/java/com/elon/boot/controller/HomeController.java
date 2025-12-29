package com.elon.boot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.elon.boot.controller.dto.property.PropertyFilterRequest;
import com.elon.boot.domain.community.guide.model.service.GuideService;
import com.elon.boot.domain.community.guide.model.vo.Guide;
import com.elon.boot.domain.community.notice.model.service.NoticeService;
import com.elon.boot.domain.community.notice.model.vo.Notice;
import com.elon.boot.domain.property.model.service.PropertyService;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.service.GeminiService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class HomeController {

	private final NoticeService noticeService;
	private final GuideService guideService;
	private final PropertyService propertyService;
	private final GeminiService geminiService;

    // 지도 검색 페이지
    @GetMapping("/map")
    public String propertyMap(Model model) {
        try {
            // 지도에 표시할 매물 목록 가져오기
            List<Property> properties = propertyService.getAllProperties();

            // 각 매물에 썸네일 이미지 경로와 옵션 정보 설정
            if (properties != null) {
                for (Property property : properties) {
                    try {
                        var images = propertyService.selectOnesImgs(property.getPropertyNo());
                        if (images != null && !images.isEmpty()) {
                            property.setThumbnailPath(images.get(0).getImgPath());
                        }
                    } catch (Exception e) {
                        log.warn("매물 {} 썸네일 조회 실패", property.getPropertyNo());
                    }

                    // 옵션 정보 조회 및 설정
                    try {
                        var option = propertyService.selectOnesOption(property.getPropertyNo());
                        property.setPropertyOption(option);
                    } catch (Exception e) {
                        log.warn("매물 {} 옵션 조회 실패", property.getPropertyNo());
                    }
                }
            }

            model.addAttribute("properties", properties);
            log.debug("지도 페이지 매물 조회: {} 건", properties != null ? properties.size() : 0);
        } catch (Exception e) {
            log.error("지도 페이지 매물 조회 실패: ", e);
        }

        return "unilandmap";
    }
    
    // 메인 페이지
    @GetMapping({"/", "/uniland"})
    public String index(Model model) {
        try {
            // 최근 공지사항 5개 조회
            List<Notice> noticeList = noticeService.getRecentNotices(5);
            model.addAttribute("noticeList", noticeList);

            log.debug("메인 페이지 공지사항 조회: {} 건", noticeList != null ? noticeList.size() : 0);

        } catch (Exception e) {
            log.error("메인 페이지 공지사항 조회 실패: ", e);
            // 에러가 발생해도 페이지는 표시되도록 함
        }

        try {
            // 인기 가이드 5개 조회
            List<Guide> guideList = guideService.getPopularGuides();
            model.addAttribute("guideList", guideList);

            log.debug("메인 페이지 가이드 조회: {} 건", guideList != null ? guideList.size() : 0);

        } catch (Exception e) {
            log.error("메인 페이지 가이드 조회 실패: ", e);
            // 에러가 발생해도 페이지는 표시되도록 함
        }

        try {
            // 최근 등록 매물 5개 조회 (썸네일 이미지 및 옵션 포함)
            List<Property> recentProperties = propertyService.getRecentProperties();
            model.addAttribute("recentProperties", recentProperties);

            log.debug("메인 페이지 최근 매물 조회: {} 건", recentProperties != null ? recentProperties.size() : 0);

        } catch (Exception e) {
            log.error("메인 페이지 최근 매물 조회 실패: ", e);
            // 에러가 발생해도 페이지는 표시되도록 함
        }

        return "uniland";
    }

    // 필터링된 매물 목록 조회 API
    @PostMapping("/api/properties/filter")
    @ResponseBody
    public Map<String, Object> filterProperties(@RequestBody PropertyFilterRequest filter) {
        Map<String, Object> response = new HashMap<>();

        try {
            log.debug("필터 요청: {}", filter);

            // 필터링된 매물 조회
            List<Property> properties = propertyService.getFilteredProperties(filter);

            // 학교 필터가 있는 경우 거리 계산으로 추가 필터링
            if (filter.getSchoolLocations() != null && !filter.getSchoolLocations().isEmpty() && filter.getSchoolRadius() != null) {
                properties = properties.stream()
                    .filter(property -> {
                        if (property.getLatitude() == null || property.getLongitude() == null) {
                            return false;
                        }

                        // 선택된 학교 중 하나라도 반경 내에 있으면 포함
                        return filter.getSchoolLocations().stream()
                            .anyMatch(school -> {
                                double distance = calculateDistance(
                                    property.getLatitude(), property.getLongitude(),
                                    school.getLatitude(), school.getLongitude()
                                );
                                return distance <= filter.getSchoolRadius();
                            });
                    })
                    .toList();
            }

            // 각 매물에 썸네일 이미지 경로와 옵션 정보 설정
            if (properties != null) {
                for (Property property : properties) {
                    try {
                        var images = propertyService.selectOnesImgs(property.getPropertyNo());
                        if (images != null && !images.isEmpty()) {
                            property.setThumbnailPath(images.get(0).getImgPath());
                        }
                    } catch (Exception e) {
                        log.warn("매물 {} 썸네일 조회 실패", property.getPropertyNo());
                    }

                    try {
                        var option = propertyService.selectOnesOption(property.getPropertyNo());
                        property.setPropertyOption(option);
                    } catch (Exception e) {
                        log.warn("매물 {} 옵션 조회 실패", property.getPropertyNo());
                    }
                }
            }

            response.put("success", true);
            response.put("properties", properties);
            response.put("count", properties != null ? properties.size() : 0);

            log.debug("필터링된 매물 조회: {} 건", properties != null ? properties.size() : 0);

        } catch (Exception e) {
            log.error("필터링된 매물 조회 실패: ", e);
            response.put("success", false);
            response.put("message", "매물 조회 중 오류가 발생했습니다.");
        }

        return response;
    }

    // 두 좌표 간의 거리 계산 (Haversine formula) - km 단위
    private double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        final int EARTH_RADIUS = 6371; // 지구 반경 (km)

        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);

        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                   Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) *
                   Math.sin(dLon / 2) * Math.sin(dLon / 2);

        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

        return EARTH_RADIUS * c;
    }

    // AI 자연어 검색
    @PostMapping("/api/properties/ai-search")
    @ResponseBody
    public Map<String, Object> aiSearch(@RequestParam String query) {
        Map<String, Object> response = new HashMap<>();

        try {
            log.debug("AI 검색 질문: {}", query);

            // Gemini AI로 검색 조건 추출
            PropertyFilterRequest filter = geminiService.extractSearchConditions(query);

            log.debug("AI가 추출한 필터: {}", filter);

            // 추출된 필터로 매물 검색
            response.put("success", true);
            response.put("filter", filter);
            response.put("message", "AI가 검색 조건을 추출했습니다.");

        } catch (Exception e) {
            log.error("AI 검색 실패: ", e);
            response.put("success", false);
            response.put("message", "AI 검색 중 오류가 발생했습니다: " + e.getMessage());
        }

        return response;
    }
}