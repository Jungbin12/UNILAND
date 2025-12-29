package com.elon.boot.service;

import com.elon.boot.controller.dto.property.PropertyFilterRequest;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@RequiredArgsConstructor
@Slf4j
public class GeminiService {

    @Value("${gemini.api.key}")
    private String apiKey;

    @Value("${gemini.api.url}")
    private String apiUrl;

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    public PropertyFilterRequest extractSearchConditions(String userQuery) {
        try {
            // Gemini AI에게 보낼 프롬프트
            String prompt = createPrompt(userQuery);

            // Gemini API 호출
            String aiResponse = callGeminiApi(prompt);

            // AI 응답을 PropertyFilterRequest로 변환
            return parseAiResponse(aiResponse);

        } catch (Exception e) {
            log.error("Gemini API 호출 실패: ", e);
            return new PropertyFilterRequest();
        }
    }

    private String createPrompt(String userQuery) {
        return """
            당신은 부동산 매물 검색 조건을 추출하는 AI입니다.
            사용자의 자연어 질문을 분석하여 검색 조건을 JSON 형식으로 추출하세요.

            사용자 질문: "%s"

            다음 형식의 JSON만 반환하세요 (다른 설명 없이):
            {
              "regions": ["강남구", "서초구"] 또는 null,
              "schoolLocations": [{"name": "연세대학교", "latitude": 37.5665, "longitude": 126.9387}] 또는 null,
              "schoolRadius": 2.0 또는 null (km 단위),
              "depositMin": 0 또는 null,
              "depositMax": 5000 또는 null (만원 단위),
              "rentMin": 0 또는 null,
              "rentMax": 200 또는 null (만원 단위),
              "propertyTypes": ["oneRoom", "twoRoom", "threeRoom", "officetel"] 또는 null,
              "studentPref": true/false/null,
              "shortCont": true/false/null,
              "airConditioner": true/false/null,
              "heater": true/false/null,
              "refrigerator": true/false/null,
              "washer": true/false/null,
              "parking": true/false/null,
              "elevator": true/false/null
            }

            매물 유형 매핑:
            - 원룸 -> "oneRoom"
            - 투룸 -> "twoRoom"
            - 쓰리룸 -> "threeRoom"
            - 오피스텔 -> "officetel"

            학교 좌표:
            - 연세대학교: 37.5665, 126.9387
            - 고려대학교: 37.5906, 127.0267
            - 서울대학교: 37.4601, 126.9520
            - 홍익대학교: 37.5509, 126.9227
            - 이화여자대학교: 37.5616, 126.9468
            - 한양대학교: 37.5559, 127.0448
            - 건국대학교: 37.5412, 127.0786
            - 성균관대학교: 37.5943, 126.9895
            - 동국대학교: 37.5582, 126.9989
            - 중앙대학교: 37.5040, 126.9570
            - 경희대학교: 37.5971, 127.0519
            - 서울시립대학교: 37.5838, 127.0581
            - 숙명여자대학교: 37.5450, 126.9654
            - 성신여자대학교: 37.5927, 127.0187
            - 국민대학교: 37.6108, 126.9958
            - 서강대학교: 37.5509, 126.9410
            - 광운대학교: 37.6200, 127.0590
            - 세종대학교: 37.5510, 127.0740
            - 숭실대학교: 37.4963, 126.9573
            - 단국대학교: 37.3211, 127.1265
            - 상명대학교: 37.6010, 126.9266
            - 덕성여자대학교: 37.6537, 127.0155
            - 부산대학교: 35.2328, 129.0824
            - 경북대학교: 35.8894, 128.6109
            - 수원대학교: 37.2974, 127.0566

            주요 지하철역 좌표 (역 근처 검색용):
            [2호선]
            - 강남역: 37.4979, 127.0276
            - 역삼역: 37.5004, 127.0365
            - 선릉역: 37.5045, 127.0493
            - 삼성역: 37.5088, 127.0633
            - 건대입구역: 37.5404, 127.0703
            - 구의역: 37.5372, 127.0856
            - 잠실역: 37.5133, 127.1000
            - 신림역: 37.4842, 126.9296
            - 봉천역: 37.4816, 126.9426
            - 사당역: 37.4765, 126.9815
            - 방배역: 37.4814, 127.0013
            - 서초역: 37.4836, 127.0107
            - 교대역: 37.4933, 127.0143
            - 서울대입구역: 37.4813, 126.9528
            - 홍대입구역: 37.5571, 126.9240
            - 신촌역: 37.5559, 126.9364
            - 이대역: 37.5565, 126.9457
            - 아현역: 37.5574, 126.9565
            - 충정로역: 37.5600, 126.9636

            [1호선]
            - 서울역: 37.5547, 126.9707
            - 종각역: 37.5702, 126.9820
            - 종로3가역: 37.5713, 126.9910
            - 종로5가역: 37.5707, 127.0020
            - 동대문역: 37.5714, 127.0098
            - 신설동역: 37.5750, 127.0251

            [3호선]
            - 압구정역: 37.5273, 127.0276
            - 신사역: 37.5162, 127.0204
            - 고속터미널역: 37.5048, 127.0048
            - 교대역: 37.4933, 127.0143
            - 남부터미널역: 37.4764, 127.0063
            - 양재역: 37.4844, 127.0343
            - 도곡역: 37.4918, 127.0541
            - 매봉역: 37.4798, 127.0454
            - 안국역: 37.5754, 126.9853
            - 경복궁역: 37.5753, 126.9730
            - 독립문역: 37.5742, 126.9566
            - 홍제역: 37.5862, 126.9483

            [4호선]
            - 혜화역: 37.5820, 127.0018
            - 한성대입구역: 37.5886, 127.0063
            - 성신여대입구역: 37.5925, 127.0166
            - 미아역: 37.6132, 127.0289
            - 수유역: 37.6381, 127.0253
            - 쌍문역: 37.6515, 127.0298
            - 창동역: 37.6533, 127.0473
            - 노원역: 37.6545, 127.0615
            - 동대문역사문화공원역: 37.5653, 127.0079
            - 충무로역: 37.5612, 126.9945
            - 명동역: 37.5607, 126.9862
            - 회현역: 37.5588, 126.9785
            - 서울역: 37.5547, 126.9707

            [5호선]
            - 광화문역: 37.5715, 126.9763
            - 종로3가역: 37.5713, 126.9910
            - 을지로4가역: 37.5666, 127.0028
            - 왕십리역: 37.5611, 127.0373
            - 군자역: 37.5573, 127.0739
            - 천호역: 37.5385, 127.1236
            - 강동역: 37.5375, 127.1262

            [6호선]
            - 응암역: 37.6018, 126.9132
            - 역촌역: 37.5976, 126.9271
            - 불광역: 37.6102, 126.9292
            - 독바위역: 37.6159, 126.9256
            - 연신내역: 37.6190, 126.9211
            - 구산역: 37.6099, 126.9149
            - 새절역: 37.6121, 126.8895
            - 증산역: 37.6022, 126.9030
            - 디지털미디어시티역: 37.5766, 126.9006
            - 상수역: 37.5478, 126.9225
            - 합정역: 37.5496, 126.9138
            - 망원역: 37.5556, 126.9104
            - 마포구청역: 37.5663, 126.9019
            - 공덕역: 37.5446, 126.9515
            - 효창공원앞역: 37.5394, 126.9618
            - 삼각지역: 37.5346, 126.9730
            - 녹사평역: 37.5343, 126.9883
            - 이태원역: 37.5344, 127.0023
            - 한강진역: 37.5318, 126.9993
            - 버티고개역: 37.5482, 127.0020
            - 약수역: 37.5543, 127.0099
            - 청구역: 37.5608, 127.0158
            - 신당역: 37.5657, 127.0179

            [7호선]
            - 강남구청역: 37.5173, 127.0417
            - 논현역: 37.5104, 127.0222
            - 반포역: 37.5007, 127.0110
            - 고속터미널역: 37.5048, 127.0048
            - 내방역: 37.4780, 126.9947
            - 총신대입구역: 37.4762, 126.9826
            - 남성역: 37.4782, 126.9700
            - 숭실대입구역: 37.4964, 126.9574
            - 상도역: 37.5024, 126.9525
            - 장승배기역: 37.4756, 126.9727
            - 신대방역: 37.4874, 126.9134

            [9호선]
            - 개화역: 37.5778, 126.7994
            - 김포공항역: 37.5619, 126.8014
            - 마곡나루역: 37.5664, 126.8252
            - 양천향교역: 37.5576, 126.8348
            - 가양역: 37.5614, 126.8548
            - 증미역: 37.5642, 126.8656
            - 등촌역: 37.5502, 126.8653
            - 염창역: 37.5477, 126.8743
            - 신목동역: 37.5348, 126.8765
            - 선유도역: 37.5351, 126.8933
            - 당산역: 37.5344, 126.9023
            - 국회의사당역: 37.5297, 126.9181
            - 여의도역: 37.5212, 126.9244
            - 샛강역: 37.5170, 126.8927
            - 노량진역: 37.5142, 126.9423
            - 노들역: 37.5177, 126.9515
            - 흑석역: 37.5088, 126.9615
            - 동작역: 37.5024, 126.9798
            - 구반포역: 37.5020, 127.0119
            - 신반포역: 37.5041, 127.0070
            - 고속터미널역: 37.5048, 127.0048
            - 사평역: 37.4917, 127.0078
            - 신논현역: 37.5043, 127.0249
            - 언주역: 37.5087, 127.0354
            - 선정릉역: 37.5044, 127.0490
            - 삼성중앙역: 37.5088, 127.0633
            - 봉은사역: 37.5147, 127.0621
            - 종합운동장역: 37.5110, 127.0735

            도보 시간 변환:
            - 도보 5분 = 0.5km
            - 도보 10분 = 1.0km
            - 도보 15분 = 1.5km
            - 도보 20분 = 2.0km
            - "역 근처" = 1.0km (기본)

            참고:
            - 언급되지 않은 조건은 null로 설정
            - 가격은 만원 단위로 변환
            - 학교가 언급되면 반경은 기본 2km
            - 역이 언급되고 거리가 없으면 반경 1.0km (기본)
            - "도보 X분"이 언급되면 위 변환표 사용
            - 역 이름은 schoolLocations 배열에 포함 (학교와 동일하게 처리)
            - 예: "강남역 근처" → schoolLocations: [{"name": "강남역", "latitude": 37.4979, "longitude": 127.0276}], schoolRadius: 1.0
            - 예: "홍대 도보 10분" → schoolLocations: [{"name": "홍대입구역", "latitude": 37.5571, "longitude": 126.9240}], schoolRadius: 1.0
            - 예: "신촌역 도보 5분" → schoolLocations: [{"name": "신촌역", "latitude": 37.5559, "longitude": 126.9364}], schoolRadius: 0.5
            - JSON만 반환하고 다른 텍스트는 포함하지 마세요
            """.formatted(userQuery);
    }

    private String callGeminiApi(String prompt) throws Exception {
        String url = apiUrl + "?key=" + apiKey;

        Map<String, Object> requestBody = new HashMap<>();

        // contents 배열
        List<Map<String, Object>> contents = new ArrayList<>();
        Map<String, Object> content = new HashMap<>();

        // parts 배열
        List<Map<String, String>> parts = new ArrayList<>();
        Map<String, String> part = new HashMap<>();
        part.put("text", prompt);
        parts.add(part);

        content.put("parts", parts);
        contents.add(content);

        requestBody.put("contents", contents);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);

        ResponseEntity<String> response = restTemplate.exchange(
            url,
            HttpMethod.POST,
            entity,
            String.class
        );

        // 응답에서 텍스트 추출
        JsonNode root = objectMapper.readTree(response.getBody());
        String generatedText = root.path("candidates").get(0)
            .path("content").path("parts").get(0)
            .path("text").asText();

        log.debug("Gemini AI 응답: {}", generatedText);
        return generatedText;
    }

    private PropertyFilterRequest parseAiResponse(String aiResponse) {
        try {
            // JSON 부분만 추출 (```json ... ``` 제거)
            String jsonStr = aiResponse;
            if (aiResponse.contains("```json")) {
                jsonStr = aiResponse.substring(
                    aiResponse.indexOf("```json") + 7,
                    aiResponse.lastIndexOf("```")
                ).trim();
            } else if (aiResponse.contains("```")) {
                jsonStr = aiResponse.substring(
                    aiResponse.indexOf("```") + 3,
                    aiResponse.lastIndexOf("```")
                ).trim();
            }

            // JSON 파싱
            JsonNode node = objectMapper.readTree(jsonStr);
            PropertyFilterRequest filter = new PropertyFilterRequest();

            // 지역
            if (node.has("regions") && !node.get("regions").isNull()) {
                List<String> regions = new ArrayList<>();
                node.get("regions").forEach(r -> regions.add(r.asText()));
                filter.setRegions(regions.isEmpty() ? null : regions);
            }

            // 학교
            if (node.has("schoolLocations") && !node.get("schoolLocations").isNull()) {
                List<PropertyFilterRequest.SchoolLocation> schools = new ArrayList<>();
                node.get("schoolLocations").forEach(s -> {
                    PropertyFilterRequest.SchoolLocation school = new PropertyFilterRequest.SchoolLocation();
                    school.setName(s.get("name").asText());
                    school.setLatitude(s.get("latitude").asDouble());
                    school.setLongitude(s.get("longitude").asDouble());
                    schools.add(school);
                });
                filter.setSchoolLocations(schools.isEmpty() ? null : schools);
            }

            // 학교 반경
            if (node.has("schoolRadius") && !node.get("schoolRadius").isNull()) {
                filter.setSchoolRadius(node.get("schoolRadius").asDouble());
            }

            // 보증금
            if (node.has("depositMin") && !node.get("depositMin").isNull()) {
                filter.setDepositMin(node.get("depositMin").asInt());
            }
            if (node.has("depositMax") && !node.get("depositMax").isNull()) {
                filter.setDepositMax(node.get("depositMax").asInt());
            }

            // 월세
            if (node.has("rentMin") && !node.get("rentMin").isNull()) {
                filter.setRentMin(node.get("rentMin").asInt());
            }
            if (node.has("rentMax") && !node.get("rentMax").isNull()) {
                filter.setRentMax(node.get("rentMax").asInt());
            }

            // 매물 유형
            if (node.has("propertyTypes") && !node.get("propertyTypes").isNull()) {
                List<String> types = new ArrayList<>();
                node.get("propertyTypes").forEach(t -> types.add(t.asText()));
                filter.setPropertyTypes(types.isEmpty() ? null : types);
            }

            // 학생 특화
            if (node.has("studentPref") && !node.get("studentPref").isNull()) {
                filter.setStudentPref(node.get("studentPref").asBoolean());
            }
            if (node.has("shortCont") && !node.get("shortCont").isNull()) {
                filter.setShortCont(node.get("shortCont").asBoolean());
            }

            // 옵션들
            setOptionIfPresent(node, filter, "airConditioner", filter::setAirConditioner);
            setOptionIfPresent(node, filter, "heater", filter::setHeater);
            setOptionIfPresent(node, filter, "refrigerator", filter::setRefrigerator);
            setOptionIfPresent(node, filter, "washer", filter::setWasher);
            setOptionIfPresent(node, filter, "parking", filter::setParking);
            setOptionIfPresent(node, filter, "elevator", filter::setElevator);

            log.debug("파싱된 필터: {}", filter);
            return filter;

        } catch (Exception e) {
            log.error("AI 응답 파싱 실패: ", e);
            return new PropertyFilterRequest();
        }
    }

    private void setOptionIfPresent(JsonNode node, PropertyFilterRequest filter,
                                    String fieldName, java.util.function.Consumer<Boolean> setter) {
        if (node.has(fieldName) && !node.get(fieldName).isNull()) {
            setter.accept(node.get(fieldName).asBoolean());
        }
    }
}
