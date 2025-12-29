<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${property.propertyName != null ? property.propertyName : '신촌역 5분거리 풀옵션 원룸'} - UNILAND</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3dcf1c6a535cc727189e80cbf9ad7b43"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            color: #1a1a1a;
            background-color: #f5f5f5;
            line-height: 1.6;
        }

        /* 메인 컨텐츠 */
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 24px;
        }

        /* 이미지 갤러리 */
        .image-gallery {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            margin-bottom: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .main-image-container { 
            position: relative;
            width: 100%;
            height: 500px;
            background: #f0f0f0;
            overflow: hidden;
        }

        .main-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .image-nav {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(255,255,255,0.9);
            border: none;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: #333;
            transition: all 0.2s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }

        .image-nav:hover {
            background: white;
            transform: translateY(-50%) scale(1.1);
        }

        .image-nav-prev {
            left: 20px;
        }

        .image-nav-next {
            right: 20px;
        }

        .image-counter {
            position: absolute;
            bottom: 20px;
            right: 20px;
            background: rgba(0,0,0,0.7);
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        .thumbnail-container {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 10px;
            padding: 15px;
            background: white;
        }

        .thumbnail {
            aspect-ratio: 1;
            border-radius: 8px;
            overflow: hidden;
            cursor: pointer;
            border: 3px solid transparent;
            transition: all 0.2s;
        }

        .thumbnail:hover {
            border-color: #cbd5e0;
        }

        .thumbnail.active {
            border-color: #667eea;
        }

        .thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* 레이아웃 */
        .content-layout {
            display: grid;
            grid-template-columns: minmax(600px, 1fr) 380px;
            gap: 30px;
            align-items: start;
        }

        /* 왼쪽 컨텐츠 */
        .main-content {
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        .content-card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        /* 기본 정보 */
        .property-header {
            margin-bottom: 20px;
        }

        .property-type-badge {
            display: inline-block;
            background: #e0e7ff;
            color: #667eea;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 12px;
        }

        .property-title {
            font-size: 28px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 12px;
            line-height: 1.3;
        }

        .property-location {
            font-size: 16px;
            color: #666;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .property-meta {
            display: flex;
            gap: 20px;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #e5e5e5;
            font-size: 14px;
            color: #666;
        }

        .property-meta span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* 상세 정보 */
        .section-title {
            font-size: 20px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            padding: 15px;
            background: #f7fafc;
            border-radius: 8px;
        }

        .info-label {
            color: #666;
            font-size: 14px;
        }

        .info-value {
            font-weight: 600;
            color: #1a1a1a;
            font-size: 14px;
        }

        /* 옵션 */
        .option-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
        }

        .option-badge {
            background: #e0e7ff;
            color: #667eea;
            padding: 10px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 500;
            text-align: center;
        }

        /* 설명 */
        .property-description {
            font-size: 15px;
            color: #333;
            line-height: 1.8;
            white-space: pre-line;
        }

        /* 지도 */
        #map {
            width: 100%;
            height: 350px;
            border-radius: 8px;
        }

        /* 중개사 정보 */
        .agent-info {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .agent-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: #667eea;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 32px;
            font-weight: 700;
            flex-shrink: 0;
        }

        .agent-details h3 {
            font-size: 18px;
            color: #1a1a1a;
            margin-bottom: 8px;
        }

        .agent-contact {
            font-size: 14px;
            color: #666;
            margin-bottom: 4px;
        }


        /* 우측 고정 박스 */
        .price-sticky {
            position: sticky;
            top: 100px;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.12);
        }

        .price-section {
            margin-bottom: 0; 
            padding-bottom: 0;
            border-bottom: none; 
        }

        .price-label {
            font-size: 14px;
            color: #666;
            margin-bottom: 8px;
        }

        .price-main {
            font-size: 36px;
            font-weight: 700;
            color: #667eea;
            line-height: 1.2;
        }

        .price-detail {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
            font-size: 14px;
        }

        .price-detail-item {
            color: #666;
        }

        .price-detail-value {
            font-weight: 600;
            color: #1a1a1a;
        }

        /* 문의 모달 */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal-overlay.active {
            display: flex;
        }

        .modal-content {
            background: white;
            padding: 40px;
            border-radius: 12px;
            width: 90%;
            max-width: 600px;
            max-height: 90vh;
            overflow-y: auto;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .modal-title {
            font-size: 24px;
            font-weight: 700;
            color: #1a1a1a;
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 28px;
            color: #666;
            cursor: pointer;
            padding: 0;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
            transition: all 0.2s;
        }

        .modal-close:hover {
            background: #f7fafc;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 8px;
        }

        .form-input,
        .form-select,
        .form-textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            font-family: inherit;
            transition: border-color 0.2s;
        }

        .form-input:focus,
        .form-select:focus,
        .form-textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .form-textarea {
            resize: vertical;
            min-height: 150px;
        }

        .modal-footer {
            display: flex;
            gap: 12px;
            margin-top: 30px;
        }

        .btn-modal {
            flex: 1;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-modal-cancel {
            background: #f7fafc;
            color: #4a5568;
        }

        .btn-modal-cancel:hover {
            background: #e2e8f0;
        }

        .btn-modal-submit {
            background: #667eea;
            color: white;
        }

        .btn-modal-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }

        /* 반응형 */
        @media (max-width: 968px) {
            .content-layout {
                grid-template-columns: 1fr;
            }

            .price-sticky {
                position: static;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .option-grid {
                grid-template-columns: repeat(3, 1fr);
            }

        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/realtor-header.jsp"/>

    <div class="main-container">
        <div class="image-gallery">
            <div class="main-image-container">
                <c:choose>
                    <c:when test="${not empty imgs and not empty imgs[0].imgPath}">
					  <img id="mainImage" class="main-image"
					       src="${pageContext.request.contextPath}${imgs[0].imgPath}"
					       alt="${property.propertyName}">
                    </c:when>
                    <c:otherwise>
                        <img id="mainImage" class="main-image" src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=1200&h=800&fit=crop" alt="매물 사진">
                    </c:otherwise>
                </c:choose>
                <button class="image-nav image-nav-prev" onclick="changeImage(-1)">
                    <i class="fa-solid fa-chevron-left"></i>
                </button>
                <button class="image-nav image-nav-next" onclick="changeImage(1)">
                    <i class="fa-solid fa-chevron-right"></i>
                </button>
                <div class="image-counter">
                    <span id="currentImageIndex">1</span> / <span id="totalImages">${not empty imgs ? fn:length(imgs) : 5}</span>
                </div>
            </div>
            <div class="thumbnail-container">
                <c:choose>
                    <c:when test="${not empty imgs}">
                      	<c:forEach var="image" items="${imgs}" varStatus="status">
					  	<div class="thumbnail ${status.index == 0 ? 'active' : ''}" onclick="selectImage(${status.index})">
					    	<img src="${pageContext.request.contextPath}${image.imgPath}" alt="썸네일 ${status.index + 1}">
					  	</div>
						</c:forEach>
						
                    </c:when>
                    <c:otherwise>
                        <div class="thumbnail active" onclick="selectImage(0)">
                            <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=300&h=300&fit=crop" alt="썸네일 1">
                        </div>
                        <div class="thumbnail" onclick="selectImage(1)">
                            <img src="https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=300&h=300&fit=crop" alt="썸네일 2">
                        </div>
                        <div class="thumbnail" onclick="selectImage(2)">
                            <img src="https://images.unsplash.com/photo-1484154218962-a197022b5858?w=300&h=300&fit=crop" alt="썸네일 3">
                        </div>
                        <div class="thumbnail" onclick="selectImage(3)">
                            <img src="https://images.unsplash.com/photo-1536376072261-38c75010e6c9?w=300&h=300&fit=crop" alt="썸네일 4">
                        </div>
                        <div class="thumbnail" onclick="selectImage(4)">
                            <img src="https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=300&h=300&fit=crop" alt="썸네일 5">
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="content-layout">
            <div class="main-content">
                <div class="content-card">
                    <div class="property-header">
                        <div style="display: flex; gap: 8px; flex-wrap: wrap; margin-bottom: 12px;">
                            <span class="property-type-badge">
                                <i class="fa-solid fa-home"></i> ${property.propertyType != null ? property.propertyType : '원룸'}
                            </span>
                            <c:if test="${property.studentPref == 'Y'}">
                                <span class="property-type-badge" style="background: #fef3c7; color: #d97706;">
                                    <i class="fa-solid fa-graduation-cap"></i> 학생 우대
                                </span>
                            </c:if>
                            <c:if test="${property.shortCont == 'Y'}">
                                <span class="property-type-badge" style="background: #dbeafe; color: #2563eb;">
                                    <i class="fa-solid fa-calendar-check"></i> 단기 계약 가능
                                </span>
                            </c:if>
                        </div>
                        <h1 class="property-title">${property.propertyName != null ? property.propertyName : '신촌역 5분거리 풀옵션 원룸'}</h1>
                        <div class="property-location">
                            <i class="fa-solid fa-location-dot"></i>
                            ${property.roadAddress != null ? property.roadAddress : '서울 서대문구 창천동'}${not empty property.addressDetail ? ' ' : ''}${property.addressDetail}
                        </div>
                        <div class="property-meta">
                            <span><i class="fa-solid fa-eye"></i> 조회 142<%-- ${property.viewCount != null ? property.viewCount : 142} --%></span>
                            <span><i class="fa-solid fa-heart"></i> 찜 <span id="favoriteCount">${favoriteCount}</span></span>
                            <span><i class="fa-solid fa-calendar"></i> <fmt:formatDate value="${property.createdAt}" pattern="yyyy.MM.dd"/></span>
                        </div>
                    </div>
                </div>

                <div class="content-card">
                    <h2 class="section-title">
                        <i class="fa-solid fa-circle-info"></i> 상세 정보
                    </h2>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">전용면적</span>
                            <span class="info-value">${property.contractArea != null ? property.contractArea : 20}㎡ (약 ${property.contractArea != null ? property.contractArea/3.3 : 6}평)</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">방/욕실</span>
                            <span class="info-value">${property.room != null ? property.room : 1}개 / ${property.bathroom != null ? property.bathroom : 1}개</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">층수</span>
                            <span class="info-value">${property.floor != null ? property.floor : 3}층 / 총 ${property.totalFloor != null ? property.totalFloor : 5}층</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">건축년도</span>
                            <span class="info-value">${property.constructionYear != null ? property.constructionYear : 2020}년</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">입주가능일</span>
                            <span class="info-value">${property.availableDate != null ? property.availableDate : '2024.03.01'}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">주차</span>
                            <span class="info-value">${options.parking != null ? (options.parking == 'Y' ? '가능' : '불가') : '불가'}</span>
                        </div>
                        <c:if test="${property.studentPref == 'Y' or property.shortCont == 'Y'}">
                            <div class="info-item">
                                <span class="info-label">추가 옵션</span>
                                <span class="info-value">
                                    <c:if test="${property.studentPref == 'Y'}">학생 우대</c:if>
                                    <c:if test="${property.studentPref == 'Y' and property.shortCont == 'Y'}"> / </c:if>
                                    <c:if test="${property.shortCont == 'Y'}">단기 계약 가능</c:if>
                                </span>
                            </div>
                        </c:if>
                    </div>
                </div>

                <div class="content-card">
                    <h2 class="section-title">
                        <i class="fa-solid fa-star"></i> 옵션
                    </h2>

                    <c:if test="${options.airConditioner == 'Y' or options.heater == 'Y'}">
                        <div style="margin-bottom: 20px;">
                            <div style="font-size: 14px; font-weight: 600; color: #666; margin-bottom: 10px;">냉난방</div>
                            <div class="option-grid">
                                <c:if test="${options.airConditioner == 'Y'}">
                                    <div class="option-badge"><i class="fas fa-snowflake"></i> 에어컨</div>
                                </c:if>
                                <c:if test="${options.heater == 'Y'}">
                                    <div class="option-badge"><i class="fas fa-thermometer-half"></i> 히터</div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${options.refrigerator == 'Y' or options.microwave == 'Y' or options.induction == 'Y' or options.gasStove == 'Y'}">
                        <div style="margin-bottom: 20px;">
                            <div style="font-size: 14px; font-weight: 600; color: #666; margin-bottom: 10px;">주방</div>
                            <div class="option-grid">
                                <c:if test="${options.refrigerator == 'Y'}">
                                    <div class="option-badge"><i class="fas fa-fridge"></i> 냉장고</div>
                                </c:if>
                                <c:if test="${options.microwave == 'Y'}">
                                    <div class="option-badge"><i class="fas fa-microwave"></i> 전자레인지</div>
                                </c:if>
                                <c:if test="${options.induction == 'Y'}">
                                    <div class="option-badge"><i class="fas fa-fire"></i> 인덕션</div>
                                </c:if>
                                <c:if test="${options.gasStove == 'Y'}">
                                    <div class="option-badge"><i class="fas fa-fire-burner"></i> 가스레인지</div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${options.washer == 'Y' or options.dryer == 'Y' or options.bed == 'Y' or options.desk == 'Y' or options.wardrobe == 'Y' or options.shoeRack == 'Y' or options.tv == 'Y'}">
                        <div style="margin-bottom: 20px;">
                            <div style="font-size: 14px; font-weight: 600; color: #666; margin-bottom: 10px;">가구/가전</div>
                            <div class="option-grid">
                                <c:if test="${options.washer == 'Y'}">
                                    <div class="option-badge"><i class="fas fa-tshirt"></i> 세탁기</div>
                                </c:if>
                                <c:if test="${options.dryer == 'Y'}">
                                    <div class="option-badge"><i class="fas fa-wind"></i> 건조기</div>
                                </c:if>
                                <c:if test="${options.bed == 'Y'}">
                                    <div class="option-badge"><i class="fas fa-bed"></i> 침대</div>
                                </c:if>
                                <c:if test="${options.desk == 'Y'}">
                                    <div class="option-badge"><i class="fas fa-book"></i> 책상</div>
                                </c:if>
                                <c:if test="${options.wardrobe == 'Y'}">
                                    <div class="option-badge"><i class="fas fa-shirt"></i> 옷장</div>
                                </c:if>
                                <c:if test="${options.shoeRack == 'Y'}">
                                    <div class="option-badge"><i class="fas fa-shoe-prints"></i> 신발장</div>
                                </c:if>
                                <c:if test="${options.tv == 'Y'}">
                                    <div class="option-badge"><i class="fas fa-tv"></i> TV</div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${options.parking == 'Y' or options.elevator == 'Y' or options.security == 'Y' or options.petAllowed == 'Y'}">
                        <div>
                            <div style="font-size: 14px; font-weight: 600; color: #666; margin-bottom: 10px;">시설</div>
                            <div class="option-grid">
                                <c:if test="${options.parking == 'Y'}">
                                    <div class="option-badge"><i class="fas fa-car"></i> 주차 가능</div>
                                </c:if>
                                <c:if test="${options.elevator == 'Y'}">
                                    <div class="option-badge"><i class="fas fa-building"></i> 엘리베이터</div>
                                </c:if>
                                <c:if test="${options.security == 'Y'}">
                                    <div class="option-badge"><i class="fas fa-lock"></i> 보안시스템</div>
                                </c:if>
                                <c:if test="${options.petAllowed == 'Y'}">
                                    <div class="option-badge"><i class="fas fa-paw"></i> 반려동물</div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${options.airConditioner != 'Y' and options.heater != 'Y' and options.refrigerator != 'Y' and options.microwave != 'Y' and options.induction != 'Y' and options.gasStove != 'Y' and options.washer != 'Y' and options.dryer != 'Y' and options.bed != 'Y' and options.desk != 'Y' and options.wardrobe != 'Y' and options.shoeRack != 'Y' and options.tv != 'Y' and options.parking != 'Y' and options.elevator != 'Y' and options.security != 'Y' and options.petAllowed != 'Y'}">
                        <div style="text-align: center; padding: 40px; color: #999;">
                            등록된 옵션이 없습니다.
                        </div>
                    </c:if>
                </div>

                <div class="content-card">
                    <h2 class="section-title">
                        <i class="fa-solid fa-align-left"></i> 상세 설명
                    </h2>
                    <div class="property-description">
                        <c:choose>
                            <c:when test="${not empty property.description}">
                                ${property.description}
                            </c:when>
                            <c:otherwise>신촌역에서 도보 5분 거리에 위치한 풀옵션 원룸입니다.

연세대, 이화여대 도보 통학 가능하며 주변 편의시설이 우수합니다.
최근 리모델링하여 깔끔한 상태이며, 보일러 개별 난방으로 관리비 부담이 적습니다.

📍 위치 장점
- 신촌역 도보 5분
- 연세대 도보 10분
- 이화여대 도보 15분
- 주변 편의점, 카페, 식당 다수

✨ 특징
- 2020년 신축 건물
- 풀옵션 (에어컨, 냉장고, 세탁기, 침대, 책상 등)
- 개별 난방으로 관리비 저렴
- 보안 우수 (CCTV, 도어락)
- 깔끔한 실내 인테리어

💰 비용
- 관리비 5만원 (수도, 인터넷 포함)
- 가스, 전기 개별 정산

학생 우대 가능하니 문의 주세요!</c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="content-card">
                    <h2 class="section-title">
                        <i class="fa-solid fa-map-location-dot"></i> 위치 정보
                    </h2>
                    <div id="map"></div>
                    <div style="margin-top: 15px; font-size: 14px; color: #666;">
                        <i class="fa-solid fa-location-dot"></i> ${property.roadAddress != null ? property.roadAddress : '서울 서대문구 창천동 123-45'}${not empty property.addressDetail ? ' ' : ''}${property.addressDetail}
                    </div>
                </div>

                <div class="content-card">
                    <h2 class="section-title">
                        <i class="fa-solid fa-user-tie"></i> 중개사 정보
                    </h2>
                    <div class="agent-info">
 						<div class="agent-avatar">				
						  <c:choose>
						    <c:when test="${not empty realtor.realtorName}">
						      ${fn:substring(realtor.realtorName, 0, 1)}
						    </c:when>
						    <c:otherwise>김</c:otherwise>
						  </c:choose>
						</div>
                        <div class="agent-details">
                            <h3>${realtor.realtorName != null ? realtor.realtorName : '김부동산'} 중개사</h3>
                            <div class="agent-contact">
                                <i class="fa-solid fa-building"></i> ${realtor.officeName != null ? realtor.officeName : '신촌부동산중개사무소'}
                            </div>
                            <div class="agent-contact">
                                <i class="fa-solid fa-phone"></i> ${realtor.realtorPhone != null ? realtor.realtorPhone : '02-1234-5678'}
                            </div>
                            <div class="agent-contact">
                                <i class="fa-solid fa-id-card"></i> 중개사 등록번호: ${realtor.businessNum != null ? realtor.businessNum : '12345-2024-00001'}
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <aside class="price-sticky">
                <div class="price-section">
                    <div class="price-label">보증금 / 월세</div>
                    <div class="price-main">${property.deposit != null ? property.deposit : 500} / ${property.monthlyRent != null ? property.monthlyRent : 55}</div>
                    <div class="price-detail" style="margin-top: 20px;">
                        <div>
                            <div class="price-detail-item">관리비</div>
                            <div class="price-detail-value">${property.maintenanceFee != null ? property.maintenanceFee : 5}만원</div>
							<c:if test="${property.water == 'Y' or property.elect == 'Y' or property.gas == 'Y' or property.internet == 'Y'}">
							    <div style="font-size: 12px; color: #666; margin-top: 4px;">
							        (
							        <c:set var="includedItems" value="" />
							
							        <c:if test="${property.water == 'Y'}">
							            <c:set var="includedItems" value="${includedItems}수도, " />
							        </c:if>
							        <c:if test="${property.elect == 'Y'}">
							            <c:set var="includedItems" value="${includedItems}전기, " />
							        </c:if>
							        <c:if test="${property.gas == 'Y'}">
							            <c:set var="includedItems" value="${includedItems}가스, " />
							        </c:if>
							        <c:if test="${property.internet == 'Y'}">
							            <c:set var="includedItems" value="${includedItems}인터넷, " />
							        </c:if>
							
							        <c:out value="${fn:substring(includedItems, 0, fn:length(includedItems) - 2)}" /> 포함
							        )
							    </div>
							</c:if>
                        </div>
                        <div>
                            <div class="price-detail-item">총 월 비용</div>
                            <div class="price-detail-value">약 ${property.monthlyRent != null ? property.monthlyRent + (property.maintenanceFee != null ? property.maintenanceFee : 5) : 60}만원</div>
                        </div>
                    </div>
                </div>
                </aside>
        </div>
    </div>

    <div class="modal-overlay" id="inquiryModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">매물 문의하기</h2>
                <button class="modal-close" onclick="closeInquiryModal()">×</button>
            </div>
            <form id="inquiryForm" action="${pageContext.request.contextPath}/inquiry/create" method="post">
                <input type="hidden" name="propertyId" value="${property.propertyNo}">
                <div class="form-group">
                    <label class="form-label">이름</label>
                    <input type="text" name="name" class="form-input" placeholder="이름을 입력하세요" required>
                </div>
                <div class="form-group">
                    <label class="form-label">연락처</label>
                    <input type="tel" name="phone" class="form-input" placeholder="010-0000-0000" required>
                </div>
                <div class="form-group">
                    <label class="form-label">문의 유형</label>
                    <select name="inquiryType" class="form-select" required>
                        <option value="">선택하세요</option>
                        <option value="visit">방문 문의</option>
                        <option value="price">가격 문의</option>
                        <option value="contract">계약 문의</option>
                        <option value="other">기타</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">문의 내용</label>
                    <textarea name="content" class="form-textarea" placeholder="문의하실 내용을 입력하세요" required></textarea>
                </div>
                <div class="form-group">
                    <label class="form-label">연락 가능 시간대</label>
                    <input type="text" name="availableTime" class="form-input" placeholder="예) 평일 오후 2시~6시">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-modal btn-modal-cancel" onclick="closeInquiryModal()">취소</button>
                    <button type="submit" class="btn-modal btn-modal-submit">문의 전송</button>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

    <script>
        // 이미지 갤러리
        const images = [
            <c:choose>
	            <c:when test="${not empty imgs}">
		            <c:forEach var="image" items="${imgs}" varStatus="status">
		              '${pageContext.request.contextPath}${image.imgPath}'${!status.last ? ',' : ''}
		            </c:forEach>
	          	</c:when>
                <c:otherwise>
                    'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=1200&h=800&fit=crop',
                    'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=1200&h=800&fit=crop',
                    'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=1200&h=800&fit=crop',
                    'https://images.unsplash.com/photo-1536376072261-38c75010e6c9?w=1200&h=800&fit=crop',
                    'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1200&h=800&fit=crop'
                </c:otherwise>
            </c:choose>
        ];

        let currentImageIndex = 0;

        function changeImage(direction) {
            currentImageIndex += direction;
            if (currentImageIndex < 0) currentImageIndex = images.length - 1;
            if (currentImageIndex >= images.length) currentImageIndex = 0;
            updateImage();
        }

        function selectImage(index) {
            currentImageIndex = index;
            updateImage();
        }

        function updateImage() {
            document.getElementById('mainImage').src = images[currentImageIndex];
            document.getElementById('currentImageIndex').textContent = currentImageIndex + 1;
            document.getElementById('totalImages').textContent = images.length;

            // 썸네일 활성화 상태 업데이트
            const thumbnails = document.querySelectorAll('.thumbnail');
            thumbnails.forEach((thumb, index) => {
                if (index === currentImageIndex) {
                    thumb.classList.add('active');
                } else {
                    thumb.classList.remove('active');
                }
            });
        }

        // ⭐ 초기 로드 함수 (DOM이 완전히 로드된 후 실행)
        function initPage() {
            // 초기 이미지 개수 설정 및 첫 이미지 업데이트
            // totalImages는 JSTL에서 이미 설정됨.
            
            // 이미지 배열이 비어있지 않은 경우에만 업데이트 실행 (에러 방지)
            if (images.length > 0 && document.getElementById('mainImage')) {
                updateImage();
            }

            // ⭐ 카카오맵 초기화 로직
            if (typeof kakao !== 'undefined' && kakao.maps) {
                initializeKakaoMap();
            } else {
                // Kakao API 스크립트가 로드될 때까지 기다림 (API 로드 후 실행 보장)
                window.onload = function() {
                    if (typeof kakao !== 'undefined' && kakao.maps) {
                        initializeKakaoMap();
                    }
                };
            }
        }
        
        function initializeKakaoMap() {
            <c:if test="${property.latitude != null && property.longitude != null}">
                var latitude = ${property.latitude};
                var longitude = ${property.longitude};

                var mapContainer = document.getElementById('map');
                var mapOption = {
                    center: new kakao.maps.LatLng(latitude, longitude),
                    level: 3
                };

                // 지도를 표시할 div의 크기가 0이 아닌지 확인 후 생성
                // 이전에 문제가 발생했을 때 추가했던 로직을 사용하여 안정성을 확보
                if (mapContainer.offsetHeight > 0 && mapContainer.offsetWidth > 0) {
                    var map = new kakao.maps.Map(mapContainer, mapOption);

                    // 마커 표시
                    var markerPosition = new kakao.maps.LatLng(latitude, longitude);
                    var marker = new kakao.maps.Marker({
                        position: markerPosition
                    });
                    marker.setMap(map);
                } else {
                    // console.warn("지도 컨테이너의 크기가 0입니다. 지도를 로드할 수 없습니다."); 
                    // 로딩 직후 크기가 0일 경우 로드 지연 문제일 수 있으므로, 재시도 로직을 추가하는 대신 콘솔 경고만 남깁니다.
                }
            </c:if>
        }

        document.addEventListener('DOMContentLoaded', initPage); // 페이지 로드 시 초기화 함수 실행

        // 찜하기 토글
        let isFavorited = false;

        function toggleFavorite() {
        	const isLoggedIn = ${not empty sessionScope.loginUser};

            if (!isLoggedIn) {
                if (confirm('로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?')) {
                    window.location.href = '${pageContext.request.contextPath}/auth/login';
                }
                return;
            }

            // AJAX로 찜하기 처리
            fetch('${pageContext.request.contextPath}/property/${property.propertyNo}/wishlist', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    isFavorited = data.isFavorited;
                    const icon = document.querySelector('.btn-secondary i');
                    const text = document.querySelector('.btn-secondary');

                    if (isFavorited) {
                        icon.className = 'fa-solid fa-heart';
                        text.innerHTML = '<i class="fa-solid fa-heart"></i> 찜 취소'; // 텍스트와 아이콘 업데이트
                        document.getElementById('favoriteCount').textContent = parseInt(document.getElementById('favoriteCount').textContent) + 1;
                        alert('찜 목록에 추가되었습니다!');
                    } else {
                        icon.className = 'fa-regular fa-heart';
                        text.innerHTML = '<i class="fa-regular fa-heart"></i> 찜하기'; // 텍스트와 아이콘 업데이트
                        document.getElementById('favoriteCount').textContent = parseInt(document.getElementById('favoriteCount').textContent) - 1;
                        alert('찜 목록에서 제거되었습니다.');
                    }
                }
            })
            .catch(err => console.error('찜하기 처리 실패:', err));
        }

        // 공유하기
		function shareProperty() {
		  const url = window.location.href;
		  const title = '${property.propertyName != null ? property.propertyName : "신촌역 5분거리 풀옵션 원룸"}';
		
		  if (navigator.share) {
		    navigator.share({
		      title: title,              
		      text: 'UNILAND에서 매물을 공유합니다.',
		      url: url
		    }).catch(err => console.log('공유 실패:', err));
		  } else {
		    navigator.clipboard.writeText(url).then(() => {
		      alert('링크가 복사되었습니다!');
		    });
		  }
		}

		// 문의 모달
        function openInquiryModal() {
            const isLoggedIn = ${not empty sessionScope.loginUser}; 

            if (!isLoggedIn) {
                if (confirm('로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?')) {
                    window.location.href = '${pageContext.request.contextPath}/auth/login?redirectUrl=/realtor/property-detail?id=${property.propertyNo}';
                }
                return;
            }

            document.getElementById('inquiryModal').classList.add('active');
        }

        function closeInquiryModal() {
            document.getElementById('inquiryModal').classList.remove('active');
        }

        // 모달 외부 클릭 시 닫기
        document.getElementById('inquiryModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeInquiryModal();
            }
        });

        // 문의 폼 제출
        document.getElementById('inquiryForm').addEventListener('submit', function(e) {
            e.preventDefault();

            const formData = new FormData(this);

            fetch(this.action, {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('문의가 전송되었습니다!\n중개사가 빠른 시일 내에 연락드릴 예정입니다.');
                    closeInquiryModal();
                    this.reset();
                } else {
                    alert('문의 전송에 실패했습니다. 다시 시도해주세요.');
                }
            })
            .catch(err => {
                console.error('문의 전송 실패:', err);
                alert('문의 전송 중 오류가 발생했습니다.');
            });
        });

        // 키보드 이미지 네비게이션
        document.addEventListener('keydown', function(e) {
            if (e.key === 'ArrowLeft') {
                changeImage(-1);
            } else if (e.key === 'ArrowRight') {
                changeImage(1);
            }
        });
    </script>
</body>
</html>