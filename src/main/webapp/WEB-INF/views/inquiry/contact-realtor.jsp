<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>중개사 문의하기 - UNILAND</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
            background-color: #f8f9fa;
        }

        .page-wrapper {
            display: flex;
            max-width: 1200px;
            margin: 40px auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        /* ========================================
           왼쪽 컬럼 - 매물 상세 정보
        ======================================== */
        .property-detail-column {
            flex: 1;
            min-width: 450px;
            max-width: 550px;
            border-right: 1px solid #e2e8f0;
            background: white;
        }

        .detail-images {
            width: 100%;
            height: 300px;
            position: relative;
            background: #f0f0f0;
        }

        .detail-images img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .detail-info {
            padding: 25px;
        }

        .detail-price {
            font-size: 32px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 15px;
        }

        .detail-title {
            font-size: 22px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 10px;
        }

        .detail-location {
            font-size: 15px;
            color: #718096;
            margin-bottom: 20px;
        }

        .detail-section {
            margin-bottom: 25px;
            padding-bottom: 25px;
            border-bottom: 1px solid #e2e8f0;
        }

        .detail-section:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .detail-section h3 {
            font-size: 16px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 12px;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }

        .detail-item {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            background: #f7fafc;
            border-radius: 4px;
        }

        .detail-item-label {
            color: #718096;
            font-size: 14px;
        }

        .detail-item-value {
            color: #2d3748;
            font-weight: 600;
            font-size: 14px;
        }

        .detail-options {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .detail-option {
            background: #e0e7ff;
            color: #667eea;
            padding: 8px 14px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 500;
        }

        .detail-description {
            color: #4a5568;
            line-height: 1.6;
            font-size: 14px;
            white-space: pre-wrap;
        }

        /* ========================================
           오른쪽 컬럼 - 문의 양식
        ======================================== */
        .inquiry-form-column {
            flex: 1;
            min-width: 400px;
            padding: 40px;
            display: flex;
            flex-direction: column;
        }

        .page-header {
            margin-bottom: 30px;
        }

        .page-header h1 {
            font-size: 32px;
            color: #2d3748;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .page-header p {
            color: #718096;
            font-size: 16px;
        }

        .alert {
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-error {
            background: rgba(245, 101, 101, 0.1);
            color: #f56565;
            border: 1px solid #f56565;
        }

        .inquiry-form {
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: #4a5568;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .required-mark {
            color: #f56565;
            margin-left: 2px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            font-family: inherit;
            transition: all 0.3s;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
        }

        textarea.form-control {
            min-height: 200px;
            resize: vertical;
        }

        .form-group-grow {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .form-group-grow textarea {
            flex-grow: 1;
        }

        .form-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
            padding-top: 20px;
            border-top: 2px solid #e2e8f0;
        }

        .btn-cancel {
            padding: 12px 24px;
            background: white;
            color: #4a5568;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-cancel:hover {
            background: #f7fafc;
        }

        .btn-submit {
            padding: 12px 24px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-submit:hover {
            background: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        /* 반응형 */
        @media (max-width: 1024px) {
            .page-wrapper {
                flex-direction: column;
            }

            .property-detail-column {
                min-width: 100%;
                max-width: 100%;
                border-right: none;
                border-bottom: 1px solid #e2e8f0;
            }

            .inquiry-form-column {
                min-width: 100%;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    
    <div class="page-wrapper">
        <!-- 왼쪽: 매물 상세 정보 -->
        <div class="property-detail-column">
            <c:if test="${not empty property}">
                <div class="detail-images">
                    <c:if test="${not empty thumbnail and not empty thumbnail.imgPath}">
                        <img src="${pageContext.request.contextPath}${thumbnail.imgPath}" alt="매물 썸네일" 
                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/property/placeholder.jpg';">
                    </c:if>
                    <c:if test="${empty thumbnail or empty thumbnail.imgPath}">
                        <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=500&h=300&fit=crop" alt="기본 이미지">
                    </c:if>
                </div>
                
                <div class="detail-info">
                    <div class="detail-price">
                        보증금 <fmt:formatNumber value="${property.deposit}" pattern="#,###" />만 / 
                        월세 <fmt:formatNumber value="${property.monthlyRent}" pattern="#,###" />만
                    </div>
                    <div class="detail-title">${property.propertyName}</div>
                    <div class="detail-location">
                        📍 ${property.roadAddress} ${property.addressDetail}
                    </div>

                    <div class="detail-section">
                        <h3>기본 정보</h3>
                        <div class="detail-grid">
                            <div class="detail-item">
                                <span class="detail-item-label">방 종류</span>
                                <span class="detail-item-value">
                                    <c:choose>
                                        <c:when test="${property.propertyType == 'oneRoom'}">원룸</c:when>
                                        <c:when test="${property.propertyType == 'twoRoom'}">투룸</c:when>
                                        <c:when test="${property.propertyType == 'threeRoom'}">쓰리룸</c:when>
                                        <c:when test="${property.propertyType == 'office'}">오피스텔</c:when>
                                        <c:otherwise>${property.propertyType}</c:otherwise> 
                                    </c:choose>
                                </span>
                            </div>
                            
                            <div class="detail-item">
                                <span class="detail-item-label">전용면적</span>
                                <span class="detail-item-value">${property.contractArea}㎡</span>
                            </div>

                            <div class="detail-item">
                                <span class="detail-item-label">층수</span>
                                <span class="detail-item-value">
                                    <c:choose>
                                        <c:when test="${not empty property.floor and not empty property.totalFloor}">
                                            ${property.floor}층 / 총 ${property.totalFloor}층
                                        </c:when>
                                        <c:when test="${not empty property.floor}">
                                            ${property.floor}층
                                        </c:when>
                                        <c:when test="${not empty property.totalFloor}">
                                            총 ${property.totalFloor}층
                                        </c:when>
                                        <c:otherwise>정보 없음</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <div class="detail-item">
                                <span class="detail-item-label">관리비</span>
                                <span class="detail-item-value">
                                    <fmt:formatNumber value="${property.maintenanceFee}" pattern="#,###" />만
                                </span>
                            </div>
                        </div>
                    </div>

                    <c:if test="${not empty options}">
                        <div class="detail-section">
                            <h3>옵션</h3>
                            <div class="detail-options">
                                <c:if test="${options.airConditioner == 'Y'}"><span class="detail-option">에어컨</span></c:if>
                                <c:if test="${options.heater == 'Y'}"><span class="detail-option">히터</span></c:if>
                                <c:if test="${options.refrigerator == 'Y'}"><span class="detail-option">냉장고</span></c:if>
                                <c:if test="${options.microwave == 'Y'}"><span class="detail-option">전자레인지</span></c:if>
                                <c:if test="${options.induction == 'Y'}"><span class="detail-option">인덕션</span></c:if>
                                <c:if test="${options.gasStove == 'Y'}"><span class="detail-option">가스레인지</span></c:if>
                                <c:if test="${options.washer == 'Y'}"><span class="detail-option">세탁기</span></c:if>
                                <c:if test="${options.dryer == 'Y'}"><span class="detail-option">건조기</span></c:if>
                                <c:if test="${options.bed == 'Y'}"><span class="detail-option">침대</span></c:if>
                                <c:if test="${options.desk == 'Y'}"><span class="detail-option">책상</span></c:if>
                                <c:if test="${options.wardrobe == 'Y'}"><span class="detail-option">옷장</span></c:if>
                                <c:if test="${options.shoeRack == 'Y'}"><span class="detail-option">신발장</span></c:if>
                                <c:if test="${options.tv == 'Y'}"><span class="detail-option">TV</span></c:if>
                                <c:if test="${options.parking == 'Y'}"><span class="detail-option">주차가능</span></c:if>
                                <c:if test="${options.elevator == 'Y'}"><span class="detail-option">엘리베이터</span></c:if>
                                <c:if test="${options.security == 'Y'}"><span class="detail-option">보안시스템</span></c:if>
                                <c:if test="${options.petAllowed == 'Y'}"><span class="detail-option">반려동물</span></c:if>
                            </div>
                        </div>
                    </c:if>

                    <div class="detail-section">
                        <h3>상세 설명</h3>
                        <div class="detail-description">${property.description}</div>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${empty property}">
                <div class="detail-info">
                    <div class="detail-title">매물 정보를 불러올 수 없습니다.</div>
                    <div class="detail-description">이전 페이지로 돌아가 다시 시도해 주세요.</div>
                </div>
            </c:if>
        </div>

        <!-- 오른쪽: 문의 양식 -->
        <div class="inquiry-form-column">
            <div class="page-header">
                <h1>
                    <i class="fas fa-comment-dots"></i>
                    중개사 문의하기
                </h1>
                <p>궁금한 사항을 문의하시면 빠르게 답변 드리겠습니다</p>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/inquiries/realtor" method="post" class="inquiry-form">
                <input type="hidden" name="propertyId" value="${property.propertyNo}">
                <input type="hidden" name="realtorId" value="${property.realtorId}">
                <input type="hidden" name="userId" value="${sessionScope.loginUser.userId}">
                <input type="hidden" name="inquiryType" value="REALTOR">

                <div class="form-group">
                    <label for="contactPhone" class="form-label">
                        연락처<span class="required-mark">*</span>
                    </label>
                    <input type="tel" 
                           id="contactPhone" 
                           name="contactPhone" 
                           class="form-control" 
                           value="${sessionScope.loginUser.userPhone}" 
                           placeholder="010-1234-5678"
                           required>
                </div>

                <div class="form-group">
                    <label for="inquiryCategory" class="form-label">
                        문의 유형<span class="required-mark">*</span>
                    </label>
                    <select id="inquiryCategory" 
                            name="inquiryCategory" 
                            class="form-control" 
                            required>
                        <option value="">문의 유형을 선택하세요</option>
                        <option value="VISIT">방문 문의</option>
                        <option value="PRICE">가격 문의</option>
                        <option value="CONTRACT">계약 문의</option>
                        <option value="ETC">기타</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="inquiryTitle" class="form-label">
                        제목<span class="required-mark">*</span>
                    </label>
                    <input type="text" 
                           id="inquiryTitle" 
                           name="inquiryTitle"
                           class="form-control" 
                           placeholder="문의 제목을 입력하세요 (예: ${property.propertyName} 방문 희망합니다)" 
                           required>
                </div>
                
                <div class="form-group form-group-grow">
                    <label for="inquiryContent" class="form-label">
                        내용<span class="required-mark">*</span>
                    </label>
                    <textarea id="inquiryContent" 
                              name="inquiryContent" 
                              class="form-control" 
                              placeholder="문의 내용을 자세히 입력해주세요&#10;&#10;예시:&#10;- 방문 희망 시간: 평일 오후 6시 이후&#10;- 입주 희망일: 2025년 3월 1일&#10;- 기타 문의사항" 
                              required></textarea>
                </div>
                
                <div class="form-actions">
                    <a href="javascript:history.back()" class="btn-cancel">
                        <i class="fas fa-arrow-left"></i>
                        취소
                    </a>
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-paper-plane"></i>
                        문의하기
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>