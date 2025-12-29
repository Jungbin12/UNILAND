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
            grid-template-columns: 1fr 380px;
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            margin-bottom: 25px;
            padding-bottom: 25px;
            border-bottom: 2px solid #e5e5e5;
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

        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .btn-action {
            padding: 16px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-primary {
            background: white;
            color: #333;
            border: 1px solid #ddd;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            background: #f8f9fa;
            border-color: #007bff;
            color: #007bff;
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.2);
        }

        .btn-secondary {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-secondary:hover {
            background: #f7fafc;
        }

        .btn-share {
            background: #f7fafc;
            color: #4a5568;
            border: 2px solid #e2e8f0;
        }

        .btn-share:hover {
            background: #e2e8f0;
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
    <!-- 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <!-- 메인 컨테이너 -->
    <div class="main-container">
        <!-- 이미지 갤러리 -->
        <div class="image-gallery">
            <div class="main-image-container">
                <c:choose>
                    <c:when test="${not empty imgs}">
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
                    <span id="currentImageIndex">1</span> / <span id="totalImages">5</span>
                </div>
            </div>
            <div class="thumbnail-container">
                <c:choose>
                    <c:when test="${not empty imgs}">
<%--                         <c:forEach var="image" items="${imgs}" varStatus="status">
                            <div class="thumbnail ${status.index == 0 ? 'active' : ''}" onclick="selectImage(${status.index})">
                                <img src="${pageContext.request.contextPath}${image.imgPath}" alt="썸네일 ${status.index + 1}">
                            </div>
                        </c:forEach> --%>
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

        <!-- 컨텐츠 레이아웃 -->
        <div class="content-layout">
            <!-- 왼쪽 메인 컨텐츠 -->
            <div class="main-content">
                <!-- 기본 정보 -->
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

                <!-- 상세 정보 -->
                <div class="content-card">
                    <h2 class="section-title">
                        <i class="fa-solid fa-circle-info"></i> 상세 정보
                    </h2>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">전용면적</span>
                            <span class="info-value">
                                ${property.contractArea != null ? property.contractArea : 20}㎡
                                (약 <fmt:formatNumber value="${property.contractArea != null ? property.contractArea/3.3 : 6}" pattern="0"/>평)
                            </span>
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
                            <span class="info-value">${option.parking != null ? (option.parking == 'Y' ? '가능' : '불가') : '불가'}</span>
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

                <!-- 옵션 -->
                <div class="content-card">
                    <h2 class="section-title">
                        <i class="fa-solid fa-star"></i> 옵션
                    </h2>

                    <!-- 냉난방 -->
                    <c:if test="${option.airConditioner == 'Y' or option.heater == 'Y'}">
                        <div style="margin-bottom: 20px;">
                            <div style="font-size: 14px; font-weight: 600; color: #666; margin-bottom: 10px;">냉난방</div>
                            <div class="option-grid">
                                <c:if test="${option.airConditioner == 'Y'}">
                                    <div class="option-badge">❄️ 에어컨</div>
                                </c:if>
                                <c:if test="${option.heater == 'Y'}">
                                    <div class="option-badge">🌡️ 히터</div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>

                    <!-- 주방 -->
                    <c:if test="${option.refrigerator == 'Y' or option.microwave == 'Y' or option.induction == 'Y' or option.gasStove == 'Y'}">
                        <div style="margin-bottom: 20px;">
                            <div style="font-size: 14px; font-weight: 600; color: #666; margin-bottom: 10px;">주방</div>
                            <div class="option-grid">
                                <c:if test="${option.refrigerator == 'Y'}">
                                    <div class="option-badge">🧊 냉장고</div>
                                </c:if>
                                <c:if test="${option.microwave == 'Y'}">
                                    <div class="option-badge">📻 전자레인지</div>
                                </c:if>
                                <c:if test="${option.induction == 'Y'}">
                                    <div class="option-badge">🍳 인덕션</div>
                                </c:if>
                                <c:if test="${option.gasStove == 'Y'}">
                                    <div class="option-badge">🔥 가스레인지</div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>

                    <!-- 가구/가전 -->
                    <c:if test="${option.washer == 'Y' or option.dryer == 'Y' or option.bed == 'Y' or option.desk == 'Y' or option.wardrobe == 'Y' or option.shoeRack == 'Y' or option.tv == 'Y'}">
                        <div style="margin-bottom: 20px;">
                            <div style="font-size: 14px; font-weight: 600; color: #666; margin-bottom: 10px;">가구/가전</div>
                            <div class="option-grid">
                                <c:if test="${option.washer == 'Y'}">
                                    <div class="option-badge">🧺 세탁기</div>
                                </c:if>
                                <c:if test="${option.dryer == 'Y'}">
                                    <div class="option-badge">💨 건조기</div>
                                </c:if>
                                <c:if test="${option.bed == 'Y'}">
                                    <div class="option-badge">🛏️ 침대</div>
                                </c:if>
                                <c:if test="${option.desk == 'Y'}">
                                    <div class="option-badge">📚 책상</div>
                                </c:if>
                                <c:if test="${option.wardrobe == 'Y'}">
                                    <div class="option-badge">👔 옷장</div>
                                </c:if>
                                <c:if test="${option.shoeRack == 'Y'}">
                                    <div class="option-badge">👞 신발장</div>
                                </c:if>
                                <c:if test="${option.tv == 'Y'}">
                                    <div class="option-badge">📺 TV</div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>

                    <!-- 시설 -->
                    <c:if test="${option.parking == 'Y' or option.elevator == 'Y' or option.security == 'Y' or option.petAllowed == 'Y'}">
                        <div>
                            <div style="font-size: 14px; font-weight: 600; color: #666; margin-bottom: 10px;">시설</div>
                            <div class="option-grid">
                                <c:if test="${option.parking == 'Y'}">
                                    <div class="option-badge">🚗 주차 가능</div>
                                </c:if>
                                <c:if test="${option.elevator == 'Y'}">
                                    <div class="option-badge">🏢 엘리베이터</div>
                                </c:if>
                                <c:if test="${option.security == 'Y'}">
                                    <div class="option-badge">🔒 보안시스템</div>
                                </c:if>
                                <c:if test="${option.petAllowed == 'Y'}">
                                    <div class="option-badge">🐾 반려동물</div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>

                    <!-- 옵션이 없는 경우 -->
                    <c:if test="${option.airConditioner != 'Y' and option.heater != 'Y' and option.refrigerator != 'Y' and option.microwave != 'Y' and option.induction != 'Y' and option.gasStove != 'Y' and option.washer != 'Y' and option.dryer != 'Y' and option.bed != 'Y' and option.desk != 'Y' and option.wardrobe != 'Y' and option.shoeRack != 'Y' and option.tv != 'Y' and option.parking != 'Y' and option.elevator != 'Y' and option.security != 'Y' and option.petAllowed != 'Y'}">
                        <div style="text-align: center; padding: 40px; color: #999;">
                            등록된 옵션이 없습니다.
                        </div>
                    </c:if>
                </div>

                <!-- 상세 설명 -->
                <div class="content-card">
                    <h2 class="section-title">
                        <i class="fa-solid fa-align-left"></i> 상세 설명
                    </h2>
                    <div class="property-description">
                        ${property.description}
                    </div>
                </div>

                <!-- 위치 정보 -->
                <div class="content-card">
                    <h2 class="section-title">
                        <i class="fa-solid fa-map-location-dot"></i> 위치 정보
                    </h2>
                    <div id="map"></div>
                    <div style="margin-top: 15px; font-size: 14px; color: #666;">
                        <i class="fa-solid fa-location-dot"></i> ${property.roadAddress != null ? property.roadAddress : '서울 서대문구 창천동 123-45'}${not empty property.addressDetail ? ' ' : ''}${property.addressDetail}
                    </div>
                </div>

                <!-- 중개사 정보 -->
                <div class="content-card">
                    <h2 class="section-title">
                        <i class="fa-solid fa-user-tie"></i> 중개사 정보
                    </h2>
                    <div class="agent-info">
<!-- 						<div class="agent-avatar">
							김
						</div>
                        <div class="agent-details">
                            <h3>'김부동산' 중개사</h3>
                            <div class="agent-contact">
                                <i class="fa-solid fa-building"></i> '신촌부동산중개사무소'
                            </div>
                            <div class="agent-contact">
                                <i class="fa-solid fa-phone"></i> '02-1234-5678'
                            </div>
                            <div class="agent-contact">
                                <i class="fa-solid fa-id-card"></i> 중개사 등록번호:'12345-2024-00001'
                            </div>
                        </div> -->
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

            <!-- 우측 고정 가격 박스 -->
            <aside class="price-sticky">
                <div class="price-section">
                    <c:choose>
                        <c:when test="${property.monthlyRent == 0 or property.monthlyRent == null}">
                            <div class="price-label">전세</div>
                            <div class="price-main">${property.deposit != null ? property.deposit : 500}</div>
                        </c:when>
                        <c:otherwise>
                            <div class="price-label">보증금 / 월세</div>
                            <div class="price-main">${property.deposit != null ? property.deposit : 500} / ${property.monthlyRent}</div>
                        </c:otherwise>
                    </c:choose>
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

                <div class="action-buttons">
                    <button class="btn-action btn-primary" onclick="goToInquiryPage()">
                        <i class="fa-solid fa-comment-dots"></i> 중개사 문의하기
                    </button>
					<form action="${pageContext.request.contextPath}/property/${property.propertyNo}/wishlist" method="post" style="margin-top:12px;">
					  <button type="submit" class="btn-action btn-secondary">
					    <i class="${isFavorited ? 'fa-solid fa-heart' : 'fa-regular fa-heart'}"></i>
					    ${isFavorited ? '찜 취소' : '찜하기'}
					  </button>
					</form>
                    <button class="btn-action btn-share" onclick="shareProperty()">
                        <i class="fa-solid fa-share-nodes"></i> 공유하기
                    </button>
                </div>
            </aside>
        </div>
    </div>


    <!-- 푸터 포함 -->
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

        // 초기 이미지 개수 설정
        document.getElementById('totalImages').textContent = images.length;

        // 카카오맵 초기화
        var mapContainer = document.getElementById('map');
        var mapOption = {
            center: new kakao.maps.LatLng(${property.latitude != null ? property.latitude : 37.5665}, ${property.longitude != null ? property.longitude : 126.9780}),
            level: 3
        };

        var map = new kakao.maps.Map(mapContainer, mapOption);

        // 마커 표시
        var markerPosition = new kakao.maps.LatLng(${property.latitude != null ? property.latitude : 37.5665}, ${property.longitude != null ? property.longitude : 126.9780});
        var marker = new kakao.maps.Marker({
            position: markerPosition
        });
        marker.setMap(map);

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
                    const text = document.getElementById('favoriteText');

                    if (isFavorited) {
                        icon.className = 'fa-solid fa-heart';
                        text.textContent = '찜 취소';
                        alert('찜 목록에 추가되었습니다!');
                    } else {
                        icon.className = 'fa-regular fa-heart';
                        text.textContent = '찜하기';
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

		// 중개사 문의하기 페이지로 이동
        function goToInquiryPage() {
            // 로그인 체크
            const isLoggedIn = ${not empty sessionScope.loginUser};

            if (!isLoggedIn) {
                if (confirm('로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?')) {
                    window.location.href = '${pageContext.request.contextPath}/auth/login?redirectUrl=/property/${property.propertyNo}';
                }
                return;
            }

            // 로그인이 되어있으면 중개사 문의 페이지로 이동
            window.location.href = '${pageContext.request.contextPath}/inquiries/realtor?propertyId=${property.propertyNo}';
        }

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
