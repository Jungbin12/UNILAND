<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>부동산 중개인 마이페이지 - UNILAND</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <style>
        /* (원본 CSS — 절대 수정 금지) */
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

        /* 기존 헤더 관련 CSS는 모두 삭제됨 (header, .header-container, .logo img, .user-info, .user-name, .auth-buttons, .btn-logout 등) */
        
        /* 컨테이너 */
        .container {
            max-width: 1200px;
            margin: 20px auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            overflow: hidden;
            padding: 0 20px;
        }
        
        .tab-menu {
            display: flex;
            justify-content: center;
            border-bottom: 2px solid #e0e0e0;
            background: #fafafa;
            margin: 0 -20px;
            padding: 0 20px;
        }
        
        .tab-item {
            flex-grow: 1; 
            max-width: 500px;
            padding: 20px 40px;
            text-align: center;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            color: #999;
            border-bottom: 3px solid transparent;
            transition: all 0.3s;
            position: relative;
        }
        
        .tab-item:hover {
            background: #f0f0f0;
            color: #333;
        }
        
        .tab-item.active {
            color: #667eea;
            border-bottom-color: #667eea;
            background: white;
        }
        
        .content-area {
            padding: 40px 0;
            min-height: 500px;
        }
        
        .content-section {
            display: none;
        }
        
        .content-section.active {
            display: block;
        }
        
        .section-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 30px;
            color: #333;
        }
        
        .profile-section {
            display: flex;
            gap: 30px;
            margin-bottom: 40px;
            padding: 30px;
            background: #fafafa;
            border-radius: 8px;
        }

        /* ----------------------- 프로필 이미지 관련 CSS 추가/수정 ----------------------- */
        .profile-image-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            flex-shrink: 0;
            width: 120px;
        }
        
        .profile-image {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: #e0e0e0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #999;
            cursor: pointer; /* 클릭 가능 표시 */
            overflow: hidden;
            position: relative;
            margin-bottom: 10px;
            border: 2px solid #ccc;
            transition: border-color 0.3s;
        }

        .profile-image:hover {
            border-color: #667eea;
        }

        .profile-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .profile-image .upload-text {
            position: absolute;
            bottom: 0;
            width: 100%;
            background: rgba(0, 0, 0, 0.5);
            color: white;
            font-size: 10px;
            text-align: center;
            padding: 2px 0;
            display: none;
        }

        .profile-image:hover .upload-text {
            display: block;
        }
        /* ---------------------------------------------------------------------------- */
        
        .profile-info {
            flex: 1;
        }
        
        .info-row {
            display: flex;
            padding: 12px 0;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .info-label {
            /* ⭐ 수정: 모든 .info-label의 너비를 130px로 통일하여 중앙 정렬 대칭성 확보 */
            width: 130px; 
            color: #666;
            font-weight: 500;
            flex-shrink: 0; 
            padding-right: 10px; 
            white-space: nowrap; 
        }
        
        /* 이전의 특정 nth-child에 대한 예외 처리를 제거하고 130px로 통일합니다. */
        
        .info-value {
            color: #333;
            flex: 1;
        }
        
        .edit-btn-container {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }
        
        .btn-edit {
            padding: 10px 20px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-edit:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }
        
        .btn-secondary {
            padding: 10px 20px;
            background: white;
            color: #667eea;
            border: 1px solid #667eea;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-secondary:hover {
            background: #f8f8f8;
        }
        
        /* 계약, 찜 등 삭제된 섹션 관련 CSS는 유지 (수정 금지 조건) */
        /* ... */

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        
        .modal.active {
            display: flex;
        }
        
        .modal-content {
            background: white;
            padding: 40px;
            border-radius: 8px;
            max-width: 500px;
            width: 90%;
            max-height: 80vh;
            overflow-y: auto;
        }
        
        .modal-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 25px;
            color: #333;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
        }
        
        .form-input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .form-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .modal-buttons {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }
        
        .btn-save {
            flex: 1;
            padding: 12px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: 500;
            cursor: pointer;
        }
        
        .btn-cancel {
            flex: 1;
            padding: 12px;
            background: #f0f0f0;
            color: #333;
            border: none;
            border-radius: 4px;
            font-weight: 500;
            cursor: pointer;
        }

        /* ⭐ 주소 검색 필드 그룹 스타일 */
        .address-group {
            display: flex;
            gap: 5px;
        }

        .btn-search {
            padding: 10px 15px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            white-space: nowrap;
            transition: all 0.3s;
        }
        .btn-search:hover {
            background: #5568d3;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/realtor-header.jsp" flush="true" />
    <div class="container">
        <div class="tab-menu">
            <div class="tab-item active" data-tab="mypage">개인정보 수정</div>
            <div class="tab-item" data-tab="contracts">계약현황</div>
        </div>

        <div class="content-area">
            <div class="content-section active" id="mypage">
                <div class="section-title">중개사 개인정보</div>
                
                <form action="${pageContext.request.contextPath}/realtor/profile/updateImage" method="post" enctype="multipart/form-data" id="imageUpdateForm">
                    <input type="hidden" name="realtorId" value="${realtor.realtorId}" />

                    <div class="profile-section">
                        
                        <div class="profile-image-container">
                            <div class="profile-image" id="profileImagePreview" onclick="document.getElementById('realtorImageInput').click()">
                                <c:choose>
                                    <c:when test="${realtor.realtorImage != null && realtor.realtorImage != ''}">
                                        <img src="${pageContext.request.contextPath}/assets/profile/${realtor.realtorImage}" alt="프로필 이미지">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-user-tie fa-3x"></i>
                                    </c:otherwise>
                                </c:choose>
                                </div>
                            <input type="file" id="realtorImageInput" name="realtorImage" accept="image/*" style="display: none;">
                            <button type="button" class="btn-secondary" id="imageUploadBtn" style="display:none;" onclick="submitImageForm()">저장</button>
                        </div>

                        <div class="profile-info">
                            <div class="info-row">
                                <div class="info-label">중개사 ID</div>
                                <div class="info-value">${realtor.realtorId != null ? realtor.realtorId : 'REALTOR_001'}</div>
                            </div>
                            
                            <div class="info-row">
                                <div class="info-label">중개사 등록번호</div>
                                <div class="info-value" id="displayRealtorRegNum">
                                    ${realtor.realtorRegNum != null ? realtor.realtorRegNum : '1100000000000000000'}
                                </div>
                            </div>

                            <div class="info-row">
                                <div class="info-label">사업자번호</div>
                                <div class="info-value" id="displayBusinessNum">
                                    ${realtor.businessNum != null ? realtor.businessNum : '1234567890'}
                                </div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">사무소 상호</div>
                                <div class="info-value">${realtor.officeName != null ? realtor.officeName : '우리공인중개사무소'}</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">대표 중개인</div>
                                <div class="info-value">${realtor.realtorName != null ? realtor.realtorName : '홍길동'}</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">사무소 주소</div>
                                <div class="info-value">${realtor.realtorAddress != null ? realtor.realtorAddress : '서울특별시 강남구 역삼동 123-45'}</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">연락처</div>
                                <div class="info-value" id="displayRealtorPhone">
                                    ${realtor.realtorPhone != null ? realtor.realtorPhone : '01012345678'}
                                </div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">이메일</div>
                                <div class="info-value">${realtor.realtorEmail != null ? realtor.realtorEmail : 'realtor@example.com'}</div>
                            </div>
                            
                            <div class="edit-btn-container">
                                <button type="button" class="btn-edit" onclick="openEditModal()">회원 정보 수정</button>
                                <button type="button" class="btn-secondary" onclick="confirmDelete()">탈퇴</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- 계약현황 탭 -->
            <div class="content-section" id="contracts">
                <div class="section-title">계약현황</div>

                <c:choose>
                    <c:when test="${empty contractedProperties}">
                        <div style="text-align: center; padding: 80px 20px; color: #999;">
                            <i class="fas fa-file-contract" style="font-size: 60px; margin-bottom: 20px; color: #ccc;"></i>
                            <p style="font-size: 18px;">계약 완료된 매물이 없습니다.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="overflow-x: auto;">
                            <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
                                <thead>
                                    <tr style="background: #f7fafc; border-bottom: 2px solid #e2e8f0;">
                                        <th style="padding: 15px; text-align: left; font-weight: 600; color: #2d3748;">매물번호</th>
                                        <th style="padding: 15px; text-align: left; font-weight: 600; color: #2d3748;">매물명</th>
                                        <th style="padding: 15px; text-align: left; font-weight: 600; color: #2d3748;">주소</th>
                                        <th style="padding: 15px; text-align: left; font-weight: 600; color: #2d3748;">가격</th>
                                        <th style="padding: 15px; text-align: left; font-weight: 600; color: #2d3748;">구매자 ID</th>
                                        <th style="padding: 15px; text-align: left; font-weight: 600; color: #2d3748;">계약일시</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="property" items="${contractedProperties}">
                                        <tr style="border-bottom: 1px solid #e2e8f0;">
                                            <td style="padding: 15px;">${property.propertyNo}</td>
                                            <td style="padding: 15px; font-weight: 500;">${property.propertyName}</td>
                                            <td style="padding: 15px; color: #4a5568;">${property.roadAddress}</td>
                                            <td style="padding: 15px; color: #667eea; font-weight: 600;">
                                                <c:if test="${property.deposit > 0}">${property.deposit}</c:if>
                                                <c:if test="${property.monthlyRent > 0}">/${property.monthlyRent}</c:if>
                                            </td>
                                            <td style="padding: 15px;">
                                                <c:choose>
                                                    <c:when test="${not empty property.userId}">
                                                        <span style="background: #e6e8ff; color: #5568d3; padding: 4px 8px; border-radius: 4px; font-size: 13px;">
                                                            ${property.userId}
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: #999;">-</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="padding: 15px; color: #718096;">
                                                <c:choose>
                                                    <c:when test="${not empty property.contractAt}">
                                                        <fmt:formatDate value="${property.contractAt}" pattern="yyyy-MM-dd HH:mm"/>
                                                    </c:when>
                                                    <c:otherwise>-</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="modal" id="editModal">
        <div class="modal-content">
            <div class="modal-title">회원 정보 수정</div>

            <form action="${pageContext.request.contextPath}/realtor/mypage/update" method="post" id="updateForm">
                <input type="hidden" name="realtorId" value="${realtor.realtorId}" />
                <input type="hidden" name="businessNum" value="${realtor.businessNum}" />

                <div class="form-group">
                    <label class="form-label">중개사 ID</label>
                    <input type="text" class="form-input" value="${realtor.realtorId != null ? realtor.realtorId : ''}" readonly>
                </div>
                
                <div class="form-group">
                    <label class="form-label">중개사 등록번호</label>
                    <input type="text" class="form-input" id="modalRealtorRegNum" 
                           value="" readonly>
                </div>

                <div class="form-group">
                    <label class="form-label">사업자등록번호</label>
                    <input type="text" class="form-input" id="modalBusinessNum" 
                           value="${realtor.businessNum != null ? realtor.businessNum : ''}" readonly>
                </div>
                
                <div class="form-group">
                    <label class="form-label">사무소 상호</label>
                    <input type="text" name="officeName" class="form-input" value="${realtor.officeName != null ? realtor.officeName : ''}" placeholder="사무소 상호를 입력하세요" required>
                </div>

                <div class="form-group">
                    <label class="form-label">대표 중개인 이름</label>
                    <input type="text" name="realtorName" class="form-input" value="${realtor.realtorName != null ? realtor.realtorName : ''}" placeholder="대표 중개인 이름을 입력하세요" required>
                </div>

                <div class="form-group">
                    <label class="form-label">사무소 주소</label>
                    <div class="address-group" style="margin-bottom: 8px;">
                        <input type="text" class="form-input" id="realtorAddress" 
                               name="realtorAddress" 
                               value="${realtor.realtorAddress != null ? realtor.realtorAddress : ''}"
                               placeholder="주소 검색을 클릭하세요" readonly required>
                        <button type="button" class="btn-search" onclick="searchAddress()">주소 검색</button>
                    </div>
                    <input type="text" class="form-input" id="realtorAddressDetail"
                           name="realtorAddressDetail"
                           value="" placeholder="나머지 상세 주소 입력 (건물명, 동/호수 등)">
                </div>
                
                <div class="form-group">
                    <label class="form-label">연락처</label>
                    <input type="tel" name="realtorPhone" class="form-input" id="modalRealtorPhone"
                           value="${realtor.realtorPhone != null ? realtor.realtorPhone : ''}" 
                           placeholder="연락처를 입력하세요 (예: 010-1234-5678)" pattern="[\d\-+\s]+" required>
                </div>

                <div class="form-group">
                    <label class="form-label">이메일</label>
                    <input type="email" name="realtorEmail" class="form-input" value="${realtor.realtorEmail != null ? realtor.realtorEmail : ''}" placeholder="이메일을 입력하세요" required>
                </div>

                <div class="modal-buttons">
                    <button type="button" class="btn-save" onclick="saveChanges()">저장하기</button>
                    <button type="button" class="btn-cancel" onclick="closeEditModal()">취소</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // 사업자등록번호 포매팅 함수 (XXX-XX-XXXXX)
        function formatBusinessNum(num) {
            if (!num) return '';
            const cleanNum = num.replace(/[^0-9]/g, '');

            if (cleanNum.length === 10) {
                return cleanNum.substring(0, 3) + '-' +
                       cleanNum.substring(3, 5) + '-' +
                       cleanNum.substring(5, 10);
            }
            return num;
        }
        
        // ⭐ 수정: 중개사 등록번호 포매팅 함수 (XXXXX-XXXX-XXXXX, 총 14자리 숫자 기준)
        function formatRealtorRegNum(num) {
            if (!num) return '';
            const cleanNum = num.replace(/[^0-9]/g, '');
            
            if (cleanNum.length === 14) {
                // 5자리 (지역코드) - 4자리 (연도) - 5자리 (일련번호) 형식
                return cleanNum.substring(0, 5) + '-' +
                       cleanNum.substring(5, 9) + '-' +
                       cleanNum.substring(9, 14);
            }
            return num;
        }

        // 연락처 포매팅 함수
        function formatPhoneNum(num) {
            if (!num) return '';
            const cleanNum = num.replace(/[^0-9]/g, '');
            let result = '';

            if (cleanNum.length === 10) {
                if (cleanNum.startsWith('02')) {
                    result = cleanNum.substring(0, 2) + '-' + cleanNum.substring(2, 6) + '-' + cleanNum.substring(6, 10);
                } else {
                    result = cleanNum.substring(0, 3) + '-' + cleanNum.substring(3, 6) + '-' + cleanNum.substring(6, 10);
                }
            } else if (cleanNum.length === 11) {
                result = cleanNum.substring(0, 3) + '-' + cleanNum.substring(3, 7) + '-' + cleanNum.substring(7, 11);
            } else if (cleanNum.length === 9) { 
                 result = cleanNum.substring(0, 2) + '-' + cleanNum.substring(2, 5) + '-' + cleanNum.substring(5, 9);
            } else {
                return num;
            }
            return result;
        }

        // 카카오 주소 검색 함수
        function searchAddress() {
            new daum.Postcode({
                oncomplete: function(data) {
                    let fullAddress = data.roadAddress;
                    let extraRoadAddr = '';

                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraRoadAddr += data.bname;
                    }
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if (extraRoadAddr !== '') {
                        fullAddress += ' (' + extraRoadAddr + ')';
                    }

                    document.getElementById('realtorAddress').value = fullAddress;
                    document.getElementById('realtorAddressDetail').focus();
                }
            }).open();
        }


        // DOMContentLoaded 이벤트 발생 시 포맷 적용
        document.addEventListener('DOMContentLoaded', function() {
            // 1. 중개사 등록번호 포맷 적용 (본문)
            const rawRegNumElement = document.getElementById('displayRealtorRegNum');
            const rawRegNum = rawRegNumElement.textContent.trim();
            rawRegNumElement.textContent = formatRealtorRegNum(rawRegNum.replace(/[^0-9]/g, ''));


            // 2. 사업자등록번호 포맷 적용 (본문)
            const rawBusinessNumElement = document.getElementById('displayBusinessNum');
            const rawBusinessNum = rawBusinessNumElement.textContent.trim();
            rawBusinessNumElement.textContent = formatBusinessNum(rawBusinessNum.replace(/[^0-9]/g, ''));

            // 3. 연락처 포맷 적용 (본문)
            const rawPhoneNumElement = document.getElementById('displayRealtorPhone');
            const rawPhoneNum = rawPhoneNumElement.textContent.trim();
            rawPhoneNumElement.textContent = formatPhoneNum(rawPhoneNum.replace(/[^0-9]/g, ''));

            // 4. 모달 내부 입력 필드 값 설정 (DOMContentLoaded 시점)
            const modalBusinessNumInput = document.getElementById('modalBusinessNum');
            if (modalBusinessNumInput) {
                // 모달의 사업자번호는 읽기 전용이므로 value를 포맷팅
                modalBusinessNumInput.value = formatBusinessNum(modalBusinessNumInput.value.replace(/[^0-9]/g, ''));
            }
            
            // 주소 필드 초기값 설정 (DB 값으로 시작)
            const addressInput = document.getElementById('realtorAddress');
            
            // 주소는 6번째 .info-row (ID, 등록번호, 사업자번호, 상호, 대표자명, 주소)
            const addressRow = document.querySelectorAll('.profile-info .info-row')[5];
            let dbAddress = '';
            if (addressRow) {
                dbAddress = addressRow.querySelector('.info-value').textContent.trim();
            }
            
            addressInput.value = dbAddress;
            document.getElementById('realtorAddressDetail').value = '';
            
            if (dbAddress === '') {
                 addressInput.placeholder = '주소 검색을 클릭하세요';
            }
        });

        // 프로필 이미지 관련 DOM 요소
        const imageInput = document.getElementById('realtorImageInput');
        const imagePreview = document.getElementById('profileImagePreview');
        const imageUploadBtn = document.getElementById('imageUploadBtn');
        const imageUpdateForm = document.getElementById('imageUpdateForm');

        // 파일 선택 시 미리보기 표시 및 저장 버튼 활성화
        imageInput.addEventListener('change', function(e) {
            const file = e.target.files[0];
            
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    imagePreview.innerHTML = ''; 
                    
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    
                    imagePreview.appendChild(img);
                    imageUploadBtn.style.display = 'block';
                }
                reader.readAsDataURL(file);
            } else {
                imagePreview.innerHTML = '<i class="fas fa-user-tie fa-3x"></i>';
                imageUploadBtn.style.display = 'none';
            }
        });

        // 이미지 폼 제출
        function submitImageForm() {
            if (imageInput.files.length > 0) {
                imageUpdateForm.submit();
            } else {
                alert('업로드할 이미지를 선택해주세요.');
            }
        }
        
        // 모달 기능 (기존 유지)
        function openEditModal() {
            
            // 1. 주소 필드 설정
            const addressRow = document.querySelectorAll('.profile-info .info-row')[5];
            let dbAddress = '';
            if (addressRow) {
                dbAddress = addressRow.querySelector('.info-value').textContent.trim();
            }
            document.getElementById('realtorAddress').value = dbAddress;
            document.getElementById('realtorAddressDetail').value = ''; 
            
            // 2. ⭐ 모달 내 중개사 등록번호 필드 설정 (읽기 전용)
            const formattedRegNum = document.getElementById('displayRealtorRegNum').textContent.trim();
            document.getElementById('modalRealtorRegNum').value = formattedRegNum;

            // 3. 모달 내 연락처 필드 포맷 적용
            const dbPhone = document.getElementById('displayRealtorPhone').textContent.trim().replace(/-/g, '');
            document.getElementById('modalRealtorPhone').value = formatPhoneNum(dbPhone); 

            document.getElementById('editModal').classList.add('active');
        }

        function closeEditModal() {
            document.getElementById('editModal').classList.remove('active');
        }

        function saveChanges() {
            const form = document.getElementById('updateForm');

            // 1. 주소 필드 합치기
            const baseAddress = document.getElementById('realtorAddress').value.trim();
            const detailAddress = document.getElementById('realtorAddressDetail').value.trim();
            
            let finalAddress = baseAddress;
            if (detailAddress) {
                finalAddress += ' ' + detailAddress;
            }
            form.querySelector('input[name="realtorAddress"]').value = finalAddress;
            
            // 2. 연락처 필드 하이픈 제거 후 전송
            const rawPhone = document.getElementById('modalRealtorPhone').value.replace(/[^0-9]/g, '');
            form.querySelector('input[name="realtorPhone"]').value = rawPhone;

            // 폼 유효성 검사
            if (!form.checkValidity()) {
                alert('모든 필드를 올바르게 입력해주세요.');
                return;
            }

            // 폼 제출
            form.submit();
        }

        // 회원 탈퇴
        function confirmDelete() {
            if (confirm('정말로 탈퇴하시겠습니까? 탈퇴 후에는 복구할 수 없습니다.')) {
                location.href = '${pageContext.request.contextPath}/realtor/mypage/delete';
            }
        }

        // 채팅 열기 (사용되지 않지만 혹시 몰라 유지)
        function openChat(contractId) {
            location.href = '${pageContext.request.contextPath}/chat/' + contractId;
        }

        // 모달 외부 클릭 시 닫기
        document.getElementById('editModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeEditModal();
            }
        });

        // 탭 전환 기능
        document.addEventListener('DOMContentLoaded', function() {
            const tabItems = document.querySelectorAll('.tab-item');
            const contentSections = document.querySelectorAll('.content-section');

            tabItems.forEach(function(tabItem) {
                tabItem.addEventListener('click', function() {
                    const targetTab = this.getAttribute('data-tab');

                    // 모든 탭과 콘텐츠에서 active 클래스 제거
                    tabItems.forEach(function(item) {
                        item.classList.remove('active');
                    });
                    contentSections.forEach(function(section) {
                        section.classList.remove('active');
                    });

                    // 클릭한 탭과 해당 콘텐츠에 active 클래스 추가
                    this.classList.add('active');
                    document.getElementById(targetTab).classList.add('active');
                });
            });
        });
    </script>
</body>
</html>