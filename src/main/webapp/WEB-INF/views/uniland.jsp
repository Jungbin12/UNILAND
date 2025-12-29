<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UNILAND - 대학생 맞춤 원룸 중개 플랫폼</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            color: #1a1a1a;
            background: linear-gradient(180deg, #f8f9ff 0%, #f5f5f5 50%, #fafafa 100%);
            line-height: 1.6;
            min-width: 1400px;
            overflow-x: auto;
        }

        /* 메인 컨테이너 */
        .main-container {
            max-width: 1400px;
            min-width: 1400px;
            margin: 0 auto;
            padding: 24px 40px 48px;
        }

        /* AI 검색 섹션 */
        .ai-search-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px 32px;
            border-radius: 12px;
            text-align: center;
            margin-bottom: 48px;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
            position: relative;
            overflow: hidden;
        }

        .phone-background {
            position: absolute;
            right: -50px;
            bottom: 0;
            width: 400px;
            height: 500px;
            background-size: contain;
            background-repeat: no-repeat;
            background-position: center bottom;
            opacity: 0.5;
            z-index: 3;
            pointer-events: none;
        }

        .ai-search-section::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: pulse 4s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 0.5; }
            50% { transform: scale(1.1); opacity: 0.8; }
        }

        .ai-badge {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: rgba(255,255,255,0.25);
            color: white;
            padding: 10px 20px;
            border-radius: 24px;
            font-size: 14px;
            font-weight: 700;
            margin-bottom: 20px;
            border: 1.5px solid rgba(255,255,255,0.4);
            position: relative;
            box-shadow: 0 4px 16px rgba(255,255,255,0.15);
        }

        .ai-badge::before {
            content: '';
            position: absolute;
            inset: -2px;
            border-radius: 24px;
            padding: 2px;
            background: linear-gradient(135deg, rgba(255,255,255,0.4), rgba(255,255,255,0.1));
            -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
            -webkit-mask-composite: xor;
            mask-composite: exclude;
            opacity: 0.6;
        }

        .ai-badge i {
            font-size: 16px;
            animation: sparkle 2s ease-in-out infinite;
            filter: drop-shadow(0 0 4px rgba(255,255,255,0.5));
        }

        @keyframes sparkle {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.8; transform: scale(1.15); }
        }

        .ai-search-section h1 {
            color: white;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 16px;
            letter-spacing: -0.5px;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .ai-search-section h1 i {
            font-size: 28px;
        }

        .ai-search-section p {
            color: rgba(255,255,255,0.85);
            font-size: 16px;
            margin-bottom: 32px;
            font-weight: 400;
            position: relative;
        }

        .search-input-container {
            max-width: 720px;
            margin: 0 auto;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 16px 120px 16px 56px;
            border: none;
            border-radius: 30px;
            font-size: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
            transition: all 0.3s;
        }

        .search-input:focus {
            outline: none;
            box-shadow: 0 6px 30px rgba(0,0,0,0.25);
            transform: translateY(-2px);
        }

        .search-icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            font-size: 20px;
            animation: ai-pulse 3s ease-in-out infinite;
            filter: drop-shadow(0 0 3px rgba(102, 126, 234, 0.3));
        }

        @keyframes ai-pulse {
            0%, 100% {
                opacity: 1;
                filter: drop-shadow(0 0 3px rgba(102, 126, 234, 0.3));
            }
            50% {
                opacity: 0.7;
                filter: drop-shadow(0 0 6px rgba(102, 126, 234, 0.5));
            }
        }

        .search-button {
            position: absolute;
            right: 6px;
            top: 50%;
            transform: translateY(-50%);
            background: #667eea;
            color: white;
            border: none;
            padding: 10px 24px;
            border-radius: 30px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            transition: background 0.2s;
        }

        .search-button:hover {
            background: #5568d3;
        }

        .search-examples {
            margin-top: 24px;
            color: rgba(255,255,255,0.75);
            font-size: 13px;
            position: relative;
            z-index: 2;
        }

        .search-examples span {
            display: inline-block;
            margin: 6px 8px;
            padding: 7px 14px;
            background: rgba(255,255,255,0.15);
            border-radius: 12px;
            cursor: pointer;
            transition: background 0.2s;
            font-weight: 400;
            position: relative;
            z-index: 2;
        }

        .search-examples span:hover {
            background: rgba(255,255,255,0.25);
        }

        .map-link {
            margin-top: 20px;
            color: rgba(255,255,255,0.85);
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
            position: relative;
            z-index: 1;
        }

        .map-link:hover {
            color: white;
            text-decoration: underline;
        }

        .map-link strong {
            cursor: pointer;
        }

        /* 메인 배너 */
        .promo-banner {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            border-radius: 20px;
            padding: 32px 40px;
            margin-bottom: 48px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 10px 30px rgba(16, 185, 129, 0.2);
            overflow: hidden;
            position: relative;
        }

        .promo-text-background {
            position: absolute;
            right: 150px;
            top: 47%;
            transform: translateY(-50%);
            width: 450px;
            height: 300px;
            background-size: contain;
            background-repeat: no-repeat;
            background-position: center;
            opacity: 0.9;
            z-index: 1;
            pointer-events: none;
        }

        .promo-banner::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, rgba(255,255,255,0.2) 0%, transparent 70%);
            border-radius: 50%;
        }

        .promo-content {
            flex: 1;
            position: relative;
            z-index: 1;
        }

        .promo-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(255,255,255,0.3);
            color: white;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 12px;
        }

        .promo-title {
            font-size: 28px;
            font-weight: 800;
            color: white;
            margin-bottom: 8px;
            line-height: 1.3;
        }

        .promo-subtitle {
            font-size: 16px;
            color: rgba(255,255,255,0.9);
            margin-bottom: 20px;
        }

        .promo-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: white;
            color: #059669;
            padding: 12px 28px;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 700;
            border: none;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .promo-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.15);
            background: #f0fdf4;
        }

        .promo-image {
            position: relative;
            z-index: 1;
        }

        .promo-image i {
            font-size: 120px;
            color: rgba(255,255,255,0.3);
        }

        /* 중간 배너 */
        .middle-banner {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            border-radius: 24px;
            padding: 48px;
            margin: 60px 0;
            display: flex;
            align-items: center;
            gap: 40px;
            box-shadow: 0 12px 40px rgba(59, 130, 246, 0.2);
            position: relative;
            overflow: hidden;
        }

        .middle-banner::before {
            content: '';
            position: absolute;
            top: -30%;
            left: -10%;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(255,255,255,0.15) 0%, transparent 70%);
            border-radius: 50%;
        }

        .move-background {
            position: absolute;
            right: 5px;
            top: 55%;
            transform: translateY(-50%);
            width: 500px;
            height: 500px;
            background-size: contain;
            background-repeat: no-repeat;
            background-position: center;
            opacity: 0.8;
            z-index: 1;
            pointer-events: none;
        }

        .banner-image {
            flex-shrink: 0;
            position: relative;
            z-index: 1;
        }

        .banner-image img {
            width: 240px;
            height: 240px;
            border-radius: 20px;
            object-fit: cover;
            box-shadow: 0 16px 48px rgba(0,0,0,0.25);
        }

        .banner-content {
            flex: 1;
            position: relative;
            z-index: 1;
        }

        .banner-tag {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 16px;
        }

        .banner-title {
            font-size: 32px;
            font-weight: 800;
            color: white;
            margin-bottom: 12px;
            line-height: 1.3;
        }

        .banner-description {
            font-size: 16px;
            color: rgba(255,255,255,0.9);
            margin-bottom: 24px;
            line-height: 1.6;
        }

        .banner-features {
            display: flex;
            gap: 24px;
            margin-bottom: 24px;
        }

        .banner-feature {
            display: flex;
            align-items: center;
            gap: 8px;
            color: white;
            font-size: 14px;
            font-weight: 600;
        }

        .banner-feature i {
            font-size: 18px;
            color: #fbbf24;
        }

        .banner-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: white;
            color: #2563eb;
            padding: 14px 32px;
            border-radius: 14px;
            font-size: 16px;
            font-weight: 700;
            border: none;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }

        .banner-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 32px rgba(0,0,0,0.25);
            background: #eff6ff;
        }

        /* 인기 매물 섹션 */
        .popular-section {
            margin-bottom: 60px;
            padding-bottom: 60px;
            border-bottom: 2px solid #e5e5e5;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .section-header h2 {
            font-size: 28px;
            color: #0a0a0a;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .view-all {
            color: #667eea;
            font-weight: 500;
            font-size: 14px;
            cursor: pointer;
            transition: color 0.2s;
        }

        .view-all:hover {
            color: #5568d3;
        }

        .property-slider-container {
            position: relative;
            overflow: hidden;
            padding: 0 60px;
        }

        .property-slider-wrapper {
        	margin-top: 10px;
            overflow: hidden;
        }

        .property-grid {
        	margin-top: 10px;
            display: flex;
            gap: 20px;
            transition: transform 0.5s ease;
        }

        .property-card {
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 8px 32px rgba(102, 126, 234, 0.1);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            min-width: calc((100% - 40px) / 3);
            flex-shrink: 0;
            position: relative;
        }

        .property-card:hover {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 12px 48px rgba(102, 126, 234, 0.2);
            border-color: rgba(102, 126, 234, 0.3);
            transform: translateY(-8px);
        }

        .slider-btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: white;
            border: 1px solid #e5e5e5;
            width: 45px;
            height: 45px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 10;
            transition: all 0.2s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .slider-btn:hover {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }

        .slider-btn-prev {
            left: 0;
        }

        .slider-btn-next {
            right: 0;
        }

        .slider-btn:disabled {
            opacity: 0.3;
            cursor: not-allowed;
        }

        .slider-btn:disabled:hover {
            background: white;
            color: #333;
            border-color: #e5e5e5;
        }

        .property-image {
            width: 100%;
            height: 200px;
            background: #f0f0f0;
            position: relative;
            overflow: hidden;
        }

        .property-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .property-badge {
            position: absolute;
            top: 12px;
            left: 12px;
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 0.3px;
        }

        .property-badge.student {
            background: #667eea;
        }

        .property-badge.new {
            background: #48bb78;
        }

        .property-badge.urgent {
            background: #f56565;
        }

        .property-info {
            padding: 20px;
        }

        .property-title {
            font-size: 17px;
            font-weight: 700;
            color: #0a0a0a;
            margin-bottom: 8px;
            line-height: 1.4;
            letter-spacing: -0.3px;
        }

        .property-location {
            color: #666;
            font-size: 13px;
            margin-bottom: 12px;
        }

        .property-price {
            font-size: 22px;
            font-weight: 800;
            color: #667eea;
            margin-bottom: 12px;
            letter-spacing: -0.5px;
        }

        .property-tags {
            display: flex;
            gap: 6px;
            flex-wrap: wrap;
        }

        .property-tags span {
            background: #f5f5f5;
            color: #555;
            padding: 4px 9px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 500;
        }

        /* 정보 섹션 */
        .info-section {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-top: 20px;
        }

        .info-section-title {
            font-size: 28px;
            color: #0a0a0a;
            font-weight: 800;
            letter-spacing: -1px;
            margin-bottom: 24px;
        }

        .info-card {
            background: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            padding: 32px;
            border-radius: 16px;
            border: 1px solid rgba(255, 255, 255, 0.4);
            box-shadow: 0 8px 32px rgba(102, 126, 234, 0.08);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .info-card:hover {
            background: rgba(255, 255, 255, 0.85);
            transform: translateY(-4px);
            box-shadow: 0 12px 48px rgba(102, 126, 234, 0.15);
            border-color: rgba(102, 126, 234, 0.2);
        }

        .info-card-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 20px;
            padding-bottom: 16px;
            border-bottom: 1px solid #e5e5e5;
        }

        .info-card-icon {
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #667eea;
            font-size: 24px;
        }

        .info-card h3 {
            font-size: 18px;
            color: #0a0a0a;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .info-list {
            list-style: none;
        }

        .info-list li {
            padding: 11px 0;
            color: #555;
            font-size: 14px;
            border-bottom: 1px solid #f5f5f5;
            cursor: pointer;
            transition: color 0.2s;
        }

        .info-list li:hover {
            color: #667eea;
        }

        .info-list li:last-child {
            border-bottom: none;
        }

        .view-more {
            display: block;
            text-align: center;
            margin-top: 16px;
            color: #667eea;
            font-weight: 500;
            font-size: 14px;
            cursor: pointer;
            transition: color 0.2s;
        }

        .view-more:hover {
            color: #5568d3;
        }
    </style>
</head>
<body>
    <!-- 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <!-- 메인 컨텐츠 -->
    <div class="main-container">
        <!-- AI 검색 섹션 -->
        <section class="ai-search-section">
            <div class="phone-background" style="background-image: url('${pageContext.request.contextPath}/phone.png');"></div>
            <div class="ai-badge">
                <i class="fa-solid fa-sparkles"></i>
                AI 기반 검색
            </div>
            <h1>
                <i class="fa-solid fa-house-circle-check"></i>
                대학생을 위한 똑똑한 방 찾기
            </h1>
            <p>AI가 당신의 조건에 딱 맞는 원룸을 찾아드립니다</p>
            <div class="search-input-container">
                <i class="fa-solid fa-wand-magic-sparkles search-icon"></i>
                <input type="text" class="search-input" placeholder="💡 AI에게 물어보세요: 연세대 근처에서 월세 70만원 이하로 찾아줘">
                <button class="search-button"><i class="fa-solid fa-magnifying-glass"></i> 검색</button>
            </div>
            <div class="search-examples">
                <span>홍익대 도보 10분</span>
                <span>보증금 500만원 이하</span>
                <span>풀옵션</span>
                <span>합정역 근처</span>
            </div>
            <div class="map-link" style="cursor: pointer;">
                또는 <strong>지도에서 직접 찾아보기 →</strong>
            </div>
        </section>

        <!-- 프로모션 배너 -->
        <section class="promo-banner">
            <div class="promo-text-background" style="background-image: url('${pageContext.request.contextPath}/text.png');"></div>
            <div class="promo-content">
                <div class="promo-badge">
                    <i class="fa-solid fa-bolt"></i>
                    특별 이벤트
                </div>
                <h2 class="promo-title">2025 새학기 특가!</h2>
                <p class="promo-subtitle">원룸 중개수수료 50% 할인 + 이사비용 최대 30만원 지원</p>
                <button class="promo-btn" onclick="alert('이벤트 준비중입니다!')">
                    <i class="fa-solid fa-gift"></i>
                    지금 신청하기
                </button>
            </div>
            <div class="promo-image">
                <i class="fa-solid fa-tags"></i>
            </div>
        </section>

        <!-- 최근 등록 매물 섹션 -->
        <section class="popular-section">
            <div class="section-header">
                <h2>최근 등록 매물</h2>
            </div>
            <div class="property-slider-container">
                <button class="slider-btn slider-btn-prev" onclick="slideProperty(-1)">
                    <i class="fa-solid fa-chevron-left"></i>
                </button>
                <button class="slider-btn slider-btn-next" onclick="slideProperty(1)">
                    <i class="fa-solid fa-chevron-right"></i>
                </button>
                <div class="property-slider-wrapper">
                    <div class="property-grid">
                        <c:choose>
                            <c:when test="${not empty recentProperties}">
                                <c:forEach var="property" items="${recentProperties}">
                                    <div class="property-card" onclick="location.href='${pageContext.request.contextPath}/property/${property.propertyNo}'">
                                        <div class="property-image">
                                            <c:choose>
                                                <c:when test="${not empty property.thumbnailPath}">
                                                    <img src="${pageContext.request.contextPath}${property.thumbnailPath}" alt="${property.propertyName}">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=300&fit=crop" alt="매물 이미지">
                                                </c:otherwise>
                                            </c:choose>
                                            <c:if test="${property.studentPref eq 'Y'}">
                                                <span class="property-badge student">학생 우대</span>
                                            </c:if>
                                        </div>
                                        <div class="property-info">
                                            <div class="property-title">${property.propertyName}</div>
                                            <div class="property-location">${property.roadAddress}</div>
                                            <div class="property-price">${property.deposit}/${property.monthlyRent}</div>
                                            <div style="font-size: 12px; color: #888; margin-bottom: 6px; font-weight: 600;">주요 옵션</div>
                                            <div class="property-tags">
                                                <!-- 주요 옵션만 최대 6개까지 표시 -->
                                                <c:set var="optionCount" value="0" />

                                                <c:if test="${property.propertyOption.airConditioner eq 'Y' and optionCount < 6}">
                                                    <span>에어컨</span>
                                                    <c:set var="optionCount" value="${optionCount + 1}" />
                                                </c:if>
                                                <c:if test="${property.propertyOption.refrigerator eq 'Y' and optionCount < 6}">
                                                    <span>냉장고</span>
                                                    <c:set var="optionCount" value="${optionCount + 1}" />
                                                </c:if>
                                                <c:if test="${property.propertyOption.washer eq 'Y' and optionCount < 6}">
                                                    <span>세탁기</span>
                                                    <c:set var="optionCount" value="${optionCount + 1}" />
                                                </c:if>
                                                <c:if test="${property.propertyOption.bed eq 'Y' and optionCount < 6}">
                                                    <span>침대</span>
                                                    <c:set var="optionCount" value="${optionCount + 1}" />
                                                </c:if>
                                                <c:if test="${property.propertyOption.parking eq 'Y' and optionCount < 6}">
                                                    <span>주차</span>
                                                    <c:set var="optionCount" value="${optionCount + 1}" />
                                                </c:if>
                                                <c:if test="${property.propertyOption.elevator eq 'Y' and optionCount < 6}">
                                                    <span>엘리베이터</span>
                                                    <c:set var="optionCount" value="${optionCount + 1}" />
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div style="width: 100%; text-align: center; padding: 40px; color: #999;">
                                    등록된 매물이 없습니다.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </section>

        <!-- 중간 배너 -->
        <section class="middle-banner">
            <div class="move-background" style="background-image: url('${pageContext.request.contextPath}/move.png');"></div>
            <div class="banner-image">
                <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400&h=400&fit=crop" alt="이사 서비스">
            </div>
            <div class="banner-content">
                <div class="banner-tag">
                    <i class="fa-solid fa-truck"></i>
                    제휴 서비스
                </div>
                <h2 class="banner-title">이사 걱정 끝! 견적 비교하고 최저가로</h2>
                <p class="banner-description">
                    UNILAND와 함께하는 이사업체 비교 서비스로<br>
                    최대 30% 저렴하게 이사하세요
                </p>
                <div class="banner-features">
                    <div class="banner-feature">
                        <i class="fa-solid fa-check-circle"></i>
                        무료 견적 비교
                    </div>
                    <div class="banner-feature">
                        <i class="fa-solid fa-check-circle"></i>
                        실시간 예약
                    </div>
                    <div class="banner-feature">
                        <i class="fa-solid fa-check-circle"></i>
                        안전 보장
                    </div>
                </div>
                <button class="banner-btn" onclick="window.open('https://da24.co.kr/', '_blank')">
                    <i class="fa-solid fa-calculator"></i>
                    무료 견적 받기
                </button>
            </div>
        </section>

        <!-- 정보 섹션 -->
        <h2 class="info-section-title">유용한 정보</h2>
        <div class="info-section">
            <div class="info-card">
                <div class="info-card-header">
                    <div class="info-card-icon"><i class="fa-solid fa-lightbulb"></i></div>
                    <h3>첫 자취 꿀팁</h3>
                </div>
                <ul class="info-list">
                    <c:forEach var="guide" items="${guideList}" begin="0" end="4">
                        <li onclick="location.href='${pageContext.request.contextPath}/community/guide/${guide.guideNo}'">
                            ${guide.guideTitle}
                        </li>
                    </c:forEach>
                    <c:if test="${empty guideList}">
                        <li style="color: #999; cursor: default;">등록된 가이드가 없습니다.</li>
                    </c:if>
                </ul>
                <span class="view-more" onclick="location.href='${pageContext.request.contextPath}/community/guide'">더보기 →</span>
            </div>

            <div class="info-card">
                <div class="info-card-header">
                    <div class="info-card-icon"><i class="fa-solid fa-clipboard-check"></i></div>
                    <h3>입주 점검표</h3>
                </div>
                <ul class="info-list">
                    <li>수압 및 수도 시설 확인</li>
                    <li>채광 및 통풍 체크</li>
                    <li>전기 콘센트 위치 확인</li>
                    <li>도어락 및 보안 점검</li>
                    <li>인터넷 및 통신 환경</li>
                </ul>
                <span class="view-more" onclick="openChecklistModal()">PDF 다운로드 →</span>
            </div>

            <div class="info-card">
		    <div class="info-card-header">
		        <div class="info-card-icon"><i class="fa-solid fa-bullhorn"></i></div>
		        <h3>공지사항</h3>
		    </div>
		    <ul class="info-list">
		        <c:forEach var="notice" items="${noticeList}" begin="0" end="4">
		            <li onclick="location.href='${pageContext.request.contextPath}/community/notice/${notice.noticeNo}'">
		                ${notice.noticeSubject}
		            </li>
		        </c:forEach>
		        <c:if test="${empty noticeList}">
		            <li style="color: #999; cursor: default;">등록된 공지사항이 없습니다.</li>
		        </c:if>
		    </ul>
		    <span class="view-more" onclick="location.href='${pageContext.request.contextPath}/community/notice'">더보기 →</span>
		</div>
        </div>
    </div>

    <!-- 푸터 포함 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

    <!-- 입주 점검표 모달 포함 -->
    <jsp:include page="/WEB-INF/views/components/checklist-modal.jsp"/>

    <script>
        // 슬라이더 관련
        let currentSlide = 0;
        const propertyGrid = document.querySelector('.property-grid');
        const propertyCards = document.querySelectorAll('.property-card');
        const totalCards = propertyCards.length;
        const cardsPerView = 3;
        const maxSlide = totalCards - cardsPerView;

        function slideProperty(direction) {
            currentSlide += direction;

            if (currentSlide < 0) currentSlide = 0;
            if (currentSlide > maxSlide) currentSlide = maxSlide;

            const cardWidth = propertyCards[0].offsetWidth;
            const gap = 20;
            const slideAmount = currentSlide * (cardWidth + gap);
            propertyGrid.style.transform = 'translateX(-' + slideAmount + 'px)';

            updateButtons();
        }

        function updateButtons() {
            const prevBtn = document.querySelector('.slider-btn-prev');
            const nextBtn = document.querySelector('.slider-btn-next');

            prevBtn.disabled = currentSlide === 0;
            nextBtn.disabled = currentSlide === maxSlide;
        }

        // 초기 버튼 상태 설정
        updateButtons();

        // AI 검색 버튼
        const searchButton = document.querySelector('.search-button');
        if (searchButton) {
            searchButton.addEventListener('click', function() {
                const searchInput = document.querySelector('.search-input');
                const query = searchInput.value.trim();

                if (query) {
                    performAiSearch(query);
                } else {
                    alert('검색어를 입력해주세요.');
                }
            });
        }

        // AI 검색 실행
        function performAiSearch(query) {
            // 로딩 표시
            var button = document.querySelector('.search-button');
            var originalText = button.innerHTML;
            button.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> AI 분석 중...';
            button.disabled = true;

            // AI API 호출
            fetch('${pageContext.request.contextPath}/api/properties/ai-search?query=' + encodeURIComponent(query), {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log('AI가 추출한 필터:', data.filter);

                    // 필터를 세션 스토리지에 저장
                    sessionStorage.setItem('aiSearchFilter', JSON.stringify(data.filter));
                    sessionStorage.setItem('aiSearchQuery', query);

                    // 지도 페이지로 이동
                    window.location.href = '${pageContext.request.contextPath}/map?ai=true';
                } else {
                    alert('AI 검색 실패: ' + (data.message || '오류가 발생했습니다.'));
                    button.innerHTML = originalText;
                    button.disabled = false;
                }
            })
            .catch(error => {
                console.error('AI 검색 오류:', error);
                alert('AI 검색 중 오류가 발생했습니다.');
                button.innerHTML = originalText;
                button.disabled = false;
            });
        }

        // 검색창 엔터키
        const searchInput = document.querySelector('.search-input');
        if (searchInput) {
            searchInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    const searchButton = document.querySelector('.search-button');
                    if (searchButton) {
                        searchButton.click();
                    }
                }
            });
        }

        // 검색 예시 클릭
        document.addEventListener('DOMContentLoaded', function() {
            const searchExamples = document.querySelectorAll('.search-examples span');
            const searchInput = document.querySelector('.search-input');

            if (searchInput) {
                searchExamples.forEach(function(span) {
                    span.addEventListener('click', function(e) {
                        e.stopPropagation();
                        searchInput.value = this.textContent;
                        searchInput.focus();
                    });
                });
            }
        });

        // 지도 링크 클릭
        const mapLink = document.querySelector('.map-link');
        if (mapLink) {
            mapLink.addEventListener('click', function() {
                location.href = '${pageContext.request.contextPath}/map';
            });
        }

        // 전체보기 버튼
        const viewAllButton = document.querySelector('.view-all');
        if (viewAllButton) {
            viewAllButton.addEventListener('click', function() {
                // TODO: 매물 목록 페이지로 이동
                alert('매물 목록 페이지는 준비 중입니다.');
            });
        }
        
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get("sessionExpired") === "true") {
            alert("세션이 만료되었습니다. 다시 로그인해주세요.");
        }
    </script>
</body>
</html>
