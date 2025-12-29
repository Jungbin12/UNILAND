<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>매물 등록 - UNILAND</title>
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

        /* ---------------------------------------------------- */
        /* 헤더 관련 CSS는 별도의 파일(realtorHeader.jsp 내부)에 있다고 가정하고 제거되었습니다. */
        /* ---------------------------------------------------- */
        
        .main-layout {
            display: flex;
            max-width: 1400px;
            margin: 0 auto;
            min-height: calc(100vh - 80px); /* 헤더 높이에 맞게 조정이 필요할 수 있습니다. */
        }

        .sidebar {
            width: 260px;
            background: white;
            padding: 30px 0;
            box-shadow: 2px 0 8px rgba(0,0,0,0.05);
        }

        .sidebar-title {
            padding: 0 25px 20px;
            font-size: 18px;
            font-weight: bold;
            color: #2d3748;
            border-bottom: 2px solid #e2e8f0;
        }

        .sidebar-menu {
            list-style: none;
            padding: 20px 0;
        }

        .sidebar-menu li {
            margin: 5px 0;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 25px;
            color: #4a5568;
            text-decoration: none;
            transition: all 0.3s;
            font-weight: 500;
        }

        .sidebar-menu a:hover {
            background: #f0f2ff;
            color: #667eea;
        }

        .sidebar-menu a.active {
            background: #e6e8ff;
            color: #5568d3;
            font-weight: 600;
        }

        .menu-icon {
            font-size: 20px;
            width: 24px;
            text-align: center;
        }

        .main-content {
            flex: 1;
            padding: 40px;
        }

        .page-header {
            margin-bottom: 30px;
        }

        .page-header h1 {
            font-size: 32px;
            color: #2d3748;
            margin-bottom: 10px;
        }

        .page-header p {
            color: #718096;
            font-size: 16px;
        }

        .form-container {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .form-section {
            margin-bottom: 40px;
            padding-bottom: 40px;
            border-bottom: 2px solid #e2e8f0;
        }

        .form-section:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }

        .section-title {
            font-size: 20px;
            font-weight: bold;
            color: #2d3748;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title i {
            font-size: 20px;
            color: #667eea;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-row.single {
            grid-template-columns: 1fr;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-label {
            font-size: 14px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 8px;
        }

        .required {
            color: #f56565;
            margin-left: 4px;
        }

        .form-input {
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .form-input:focus {
            outline: none;
            border-color: #667eea;
        }

        .form-input::placeholder {
            color: #a0aec0;
        }

        .form-textarea {
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            min-height: 120px;
            resize: vertical;
            font-family: inherit;
            transition: border-color 0.3s;
        }

        .form-textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .form-select {
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            background: white;
            transition: border-color 0.3s;
        }

        .form-select:focus {
            outline: none;
            border-color: #667eea;
        }

        .input-suffix {
            position: relative;
        }

        .input-suffix input {
            padding-right: 50px;
        }

        .suffix-text {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #718096;
            font-size: 14px;
            font-weight: 600;
        }

        .address-group {
            display: flex;
            gap: 10px;
        }

        .address-group input {
            flex: 1;
        }

        .btn-search {
            padding: 12px 24px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            white-space: nowrap;
            transition: all 0.3s;
        }

        .btn-search:hover {
            background: #5568d3;
        }

        .option-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 12px;
        }

        .option-checkbox {
            display: none;
        }

        .option-label {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 12px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 14px;
            font-weight: 500;
            text-align: center;
        }

        .option-checkbox:checked + .option-label {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }

        .option-label:hover {
            border-color: #cbd5e0;
        }

        .photo-upload-area {
            border: 3px dashed #e2e8f0;
            border-radius: 12px;
            padding: 40px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
        }

        .photo-upload-area:hover {
            border-color: #667eea;
            background: #f7fafc;
        }

        .upload-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }

        .upload-text {
            font-size: 16px;
            color: #2d3748;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .upload-hint {
            font-size: 14px;
            color: #718096;
        }

        .photo-input {
            display: none;
        }

        .photo-preview-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 15px;
            margin-top: 20px;
        }

        .photo-preview {
            position: relative;
            aspect-ratio: 1;
            border-radius: 8px;
            background: #e2e8f0;
            overflow: hidden;
        }

        .photo-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .photo-badge {
            position: absolute;
            top: 8px;
            left: 8px;
            background: #667eea;
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
        }

        .photo-remove {
            position: absolute;
            top: 8px;
            right: 8px;
            width: 24px;
            height: 24px;
            background: rgba(0,0,0,0.7);
            color: white;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
        }

        .form-hint {
            font-size: 13px;
            color: #718096;
            margin-top: 8px;
        }

        .button-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 40px;
            padding-top: 40px;
            border-top: 2px solid #e2e8f0;
        }

        .btn-submit {
            padding: 16px 48px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }

        .btn-cancel {
            padding: 16px 48px;
            background: white;
            color: #4a5568;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-cancel:hover {
            background: #f7fafc;
        }

        .character-count {
            text-align: right;
            font-size: 13px;
            color: #718096;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<%-- 
    ✅ 외부 파일(realtorHeader.jsp)을 포함하여 헤더를 추가합니다. 
    실제 파일 경로는 프로젝트 구조에 맞게 수정해야 합니다. 
    일반적인 경로 예시를 사용했습니다.
--%>
<jsp:include page="/WEB-INF/views/common/realtor-header.jsp" />

<div class="main-layout">
    <aside class="sidebar">
        <div class="sidebar-title">중개사 메뉴</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/realtor/realtor-dashboard"><i class="fas fa-chart-line menu-icon"></i>대시보드</a></li>
            <li><a href="${pageContext.request.contextPath}/realtor/property-management"><i class="fas fa-building menu-icon"></i>매물 관리</a></li>
            <li><a href="#" class="active"><i class="fas fa-plus-circle menu-icon"></i>매물 등록</a></li>
            <li><a href="${pageContext.request.contextPath}/realtor/inquiry-management"><i class="fas fa-comments menu-icon"></i>받은 문의</a></li>
        </ul>
    </aside>

    <main class="main-content">
        <div class="page-header">
            <h1>매물 등록</h1>
            <p>새로운 매물 정보를 등록하세요</p>
        </div>

        <form class="form-container"
              action="${pageContext.request.contextPath}/property/register"
              method="post"
              enctype="multipart/form-data"
              id="propertyForm">


            <!-- 기본 정보 -->
            <div class="form-section">
                <h2 class="section-title"><i class="fas fa-file-alt"></i>기본 정보</h2>
                <div class="form-row single">
                    <div class="form-group">
                        <label class="form-label">매물 제목<span class="required">*</span></label>
                        <input type="text" class="form-input" name="propertyName" placeholder="예) 신촌역 5분거리 풀옵션 원룸" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">매물 유형<span class="required">*</span></label>
                        <select class="form-select" name="propertyType" required>
                            <option value="">선택하세요</option>
                            <option value="oneRoom">원룸</option>
                            <option value="twoRoom">투룸</option>
                            <option value="threeRoom">쓰리룸</option>
                            <option value="officetel">오피스텔</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">거래 유형<span class="required">*</span></label>
                        <select class="form-select" name="priceType" required>
                            <option value="">선택하세요</option>
                            <option value="monthlyRent">월세</option>
                            <option value="rent">전세</option>
                            <option value="sale">매매</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- 가격 정보 -->
            <div class="form-section">
                <h2 class="section-title"><i class="fas fa-dollar-sign"></i>가격 정보</h2>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">보증금<span class="required">*</span></label>
                        <div class="input-suffix">
                            <input type="number" class="form-input" name="deposit" placeholder="500" step="100" required>
                            <span class="suffix-text">만원</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">월세<span class="required">*</span></label>
                        <div class="input-suffix">
                            <input type="number" class="form-input" name="monthlyRent" placeholder="55" step="5" required>
                            <span class="suffix-text">만원</span>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">관리비</label>
                        <div class="input-suffix">
                            <input type="number" class="form-input" name="maintenanceFee" placeholder="5" id="maintenanceFeeInput">
                            <span class="suffix-text">만원</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">
                            <input type="checkbox" id="maintenanceInclCheck" style="margin-right:5px;">
                            관리비 있음
                        </label>
                        <div id="maintenanceItemsContainer" style="display:none; margin-top:10px;">
                            <div class="option-grid" style="grid-template-columns: repeat(2, 1fr);">
                                <input type="checkbox" id="maint1" class="option-checkbox" name="maintenanceItems" value="water">
                                <label for="maint1" class="option-label">수도</label>
                                <input type="checkbox" id="maint2" class="option-checkbox" name="maintenanceItems" value="elec">
                                <label for="maint2" class="option-label">전기</label>
                                <input type="checkbox" id="maint3" class="option-checkbox" name="maintenanceItems" value="gas">
                                <label for="maint3" class="option-label">가스</label>
                                <input type="checkbox" id="maint4" class="option-checkbox" name="maintenanceItems" value="internet">
                                <label for="maint4" class="option-label">인터넷</label>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="hidden" name="maintenanceIncl" id="maintenanceIncl" value="N">
            </div>

            <!-- 위치 정보 -->
            <div class="form-section">
                <h2 class="section-title"><i class="fas fa-map-marker-alt"></i>위치 정보</h2>
                <div class="form-row single">
                    <div class="form-group">
                        <label class="form-label">주소<span class="required">*</span></label>
                        <div class="address-group">
                            <input type="text" class="form-input" name="roadAddress" id="roadAddress" placeholder="도로명 주소를 검색하세요" readonly required>
                            <button type="button" class="btn-search" id="btnAddr">주소 검색</button>
                        </div>
                    </div>
                </div>
                <div class="form-row single">
                    <div class="form-group">
                        <label class="form-label">상세 주소</label>
                        <input type="text" class="form-input" name="addressDetail" placeholder="동, 호수 입력 (선택)">
                    </div>
                </div>

            </div>

            <!-- 상세 정보 -->
            <div class="form-section">
                <h2 class="section-title"><i class="fas fa-home"></i>상세 정보</h2>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">전용면적<span class="required">*</span></label>
                        <div class="input-suffix">
                            <input type="number" class="form-input" name="contractArea" placeholder="20" required>
                            <span class="suffix-text">㎡</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">방 개수<span class="required">*</span></label>
                        <input type="number" class="form-input" name="room" placeholder="1" min="1" value="1" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">욕실 개수<span class="required">*</span></label>
                        <input type="number" class="form-input" name="bathroom" placeholder="1" min="1" value="1" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">건축년도</label>
                        <input type="text" class="form-input" name="constructionYear" placeholder="2020">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">현재 층<span class="required">*</span></label>
                        <input type="number" class="form-input" name="floor" placeholder="3" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">총 층수<span class="required">*</span></label>
                        <input type="number" class="form-input" name="totalFloor" placeholder="5" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">입주가능일</label>
                        <input type="text" class="form-input" name="availableDate" placeholder="즉시입주 또는 2024-03-01">
                    </div>
                    <div class="form-group">
                        <label class="form-label">추가 옵션</label>
                        <div style="display: flex; gap: 15px; align-items: center; margin-top: 10px;">
                            <label style="display: flex; align-items: center; gap: 5px; cursor: pointer;">
                                <input type="checkbox" name="studentPref" value="Y">
                                <span>학생 우대</span>
                            </label>
                            <label style="display: flex; align-items: center; gap: 5px; cursor: pointer;">
                                <input type="checkbox" name="shortCont" value="Y">
                                <span>단기 계약 가능</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- api에서 받아올 위도&경도 등등 -->
            <input type="hidden" name="province"  id="province">
          <input type="hidden" name="district"  id="district">
          <input type="hidden" name="latitude"  id="latitude">
          <input type="hidden" name="longitude" id="longitude">
            

         <!-- 옵션 정보 -->
         <div class="form-section">
           <h2 class="section-title"><i class="fas fa-star"></i>옵션 정보</h2>
         
           <!-- 냉난방 -->
           <div class="form-group">
             <label class="form-label">냉난방</label>
             <div class="option-grid">
               <input type="checkbox" id="opt1" class="option-checkbox" name="airConditioner" value="Y"><label for="opt1" class="option-label">에어컨</label>
               <input type="checkbox" id="opt2" class="option-checkbox" name="heater" value="Y"><label for="opt2" class="option-label">히터</label>
             </div>
           </div>
         
           <!-- 주방 -->
           <div class="form-group" style="margin-top:20px;">
             <label class="form-label">주방</label>
             <div class="option-grid">
               <input type="checkbox" id="opt3" class="option-checkbox" name="refrigerator" value="Y"><label for="opt3" class="option-label">냉장고</label>
               <input type="checkbox" id="opt4" class="option-checkbox" name="microwave" value="Y"><label for="opt4" class="option-label">전자레인지</label>
               <input type="checkbox" id="opt5" class="option-checkbox" name="induction" value="Y"><label for="opt5" class="option-label">인덕션</label>
               <input type="checkbox" id="opt6" class="option-checkbox" name="gasStove" value="Y"><label for="opt6" class="option-label">가스레인지</label>
             </div>
           </div>
         
           <!-- 가구/가전 -->
           <div class="form-group" style="margin-top:20px;">
             <label class="form-label">가구/가전</label>
             <div class="option-grid">
               <input type="checkbox" id="opt7"  class="option-checkbox" name="washer" value="Y"><label for="opt7" class="option-label">세탁기</label>
               <input type="checkbox" id="opt8"  class="option-checkbox" name="dryer" value="Y"><label for="opt8" class="option-label">건조기</label>
               <input type="checkbox" id="opt9"  class="option-checkbox" name="bed" value="Y"><label for="opt9" class="option-label">침대</label>
               <input type="checkbox" id="opt10" class="option-checkbox" name="desk" value="Y"><label for="opt10" class="option-label">책상</label>
               <input type="checkbox" id="opt11" class="option-checkbox" name="wardrobe" value="Y"><label for="opt11" class="option-label">옷장</label>
               <input type="checkbox" id="opt12" class="option-checkbox" name="shoeRack" value="Y"><label for="opt12" class="option-label">신발장</label>
               <input type="checkbox" id="opt13" class="option-checkbox" name="tv" value="Y"><label for="opt13" class="option-label">TV</label>
             </div>
           </div>
         
           <!-- 시설 -->
           <div class="form-group" style="margin-top:20px;">
             <label class="form-label">시설</label>
             <div class="option-grid">
               <input type="checkbox" id="opt14" class="option-checkbox" name="parking" value="Y"><label for="opt14" class="option-label">주차 가능</label>
               <input type="checkbox" id="opt15" class="option-checkbox" name="elevator" value="Y"><label for="opt15" class="option-label">엘리베이터</label>
               <input type="checkbox" id="opt16" class="option-checkbox" name="security" value="Y"><label for="opt16" class="option-label">보안시스템</label>
               <input type="checkbox" id="opt17" class="option-checkbox" name="petAllowed" value="Y"><label for="opt17" class="option-label">반려동물</label>
             </div>
           </div>
         </div>

            <!-- 매물 설명 -->
            <div class="form-section">
                <h2 class="section-title"><i class="fas fa-file-alt"></i>매물 설명</h2>
                <div class="form-group">
                    <label class="form-label">상세 설명<span class="required">*</span></label>
                    <textarea class="form-textarea" name="description" placeholder="매물에 대한 자세한 설명을 입력하세요. (최대 1000자)" maxlength="1000" required></textarea>
                    <div class="character-count">0 / 1000</div>
                </div>
            </div>

            <!-- 매물 사진 -->
            <div class="form-section">
                <h2 class="section-title"><i class="fas fa-camera"></i>매물 사진</h2>
                <div class="form-group">
                    <label class="form-label">사진 업로드<span class="required">*</span> (최소 1장, 최대 10장)</label>
                    <div class="photo-upload-area" onclick="document.getElementById('photoInput').click()">
                        <div class="upload-icon"><i class="fas fa-camera"></i></div>
                        <div class="upload-text">클릭하여 사진 업로드</div>
                        <div class="upload-hint">JPG, PNG 파일 (최대 5MB)</div>
                    </div>
                    <input type="file" id="photoInput" class="photo-input" accept="image/*" name="images" multiple>
                    <div class="photo-preview-grid" id="previewGrid" style="display:none;"></div>
                </div>
            </div>

            <!-- 버튼 -->
            <div class="button-group">
                <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
                <button type="submit" class="btn-submit">매물 등록하기</button>
            </div>
        </form>
    </main>
</div>

     <script>
        // 글자 수 카운터
        const textarea = document.querySelector('.form-textarea');
        const charCount = document.querySelector('.character-count');
        
        textarea.addEventListener('input', function() {
            charCount.textContent = this.value.length + ' / 1000';
        });
    </script>
   <!-- 주소검색/지도 SDK는 그대로 유지 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=7daf28f562c53c0e3ac5048836758f12&libraries=services"></script>


<script>


  window.addEventListener('DOMContentLoaded', function () {
    // 요소 참조 (이제 DOM이 준비된 뒤라 null 아님)
    const btnAddr     = document.getElementById('btnAddr');
    const roadAddress = document.getElementById('roadAddress');
    const province    = document.getElementById('province');
    const district    = document.getElementById('district');
    const latitude    = document.getElementById('latitude');
    const longitude   = document.getElementById('longitude');

    const inclCheck   = document.getElementById('maintenanceInclCheck');
    const inclHidden  = document.getElementById('maintenanceIncl');
    const maintenanceItemsContainer = document.getElementById('maintenanceItemsContainer');
    const form        = document.getElementById('propertyForm');

    // 안전장치: 필수 요소 못 찾으면 콘솔에 표시
    if (!btnAddr || !roadAddress || !province || !district || !latitude || !longitude || !form) {
      console.error('[UNILAND] 필수 요소를 찾지 못했습니다. ID 중복/오타 여부 확인하세요.');
      return;
    }

    // 관리비 포함(Y/N) 동기화 및 체크박스 표시/숨김
    if (inclCheck && inclHidden && maintenanceItemsContainer) {
      inclCheck.addEventListener('change', () => {
        inclHidden.value = inclCheck.checked ? 'Y' : 'N';
        maintenanceItemsContainer.style.display = inclCheck.checked ? 'block' : 'none';
      });
    }

    // 주소검색 팝업
    btnAddr.addEventListener('click', () => {
      new daum.Postcode({
        oncomplete: function(data) {
          // 1) 도로명 주소 입력
          roadAddress.value = data.roadAddress || data.address || '';

          // 2) 시/도, 구/군 입력
          province.value = data.sido || '';
          district.value = data.sigungu || '';

          // 3) 카카오 지오코딩(주소→좌표)
          if (roadAddress.value) {
            const geocoder = new kakao.maps.services.Geocoder();
            geocoder.addressSearch(roadAddress.value, function(result, status) {
              if (status === kakao.maps.services.Status.OK && result && result.length > 0) {
                //  x=경도, y=위도
                longitude.value = result[0].x;
                latitude.value  = result[0].y;
              } else {
                alert('주소 좌표를 찾지 못했습니다. 주소를 다시 선택해주세요.');
                longitude.value = '';
                latitude.value  = '';
              }
            });
          }
        }
      }).open();
    });

    // 제출 전 필수값 체크 (주소/좌표)
    form.addEventListener('submit', (e) => {
      if (inclCheck && inclHidden) {
        inclHidden.value = inclCheck.checked ? 'Y' : 'N';
      }
      if (!roadAddress.value) {
        e.preventDefault();
        alert('주소를 검색해서 입력하세요.');
        btnAddr.focus();
        return;
      }
      if (!latitude.value || !longitude.value) {
        e.preventDefault();
        alert('좌표가 비어있습니다. 주소를 다시 선택해주세요.');
        btnAddr.focus();
      }
    });
  });
  
  
  /*  이미지 업로드용도        */
    const photoInput = document.getElementById('photoInput');
     const previewGrid = document.getElementById('previewGrid');
     const MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
     let fileArray = []; // 파일 목록을 저장할 배열

     // 미리보기 업데이트 함수
     function updatePreview() {
        previewGrid.innerHTML = '';

        if(fileArray.length === 0) {
           previewGrid.style.display = 'none';
           return;
        }

        previewGrid.style.display = 'grid';

        fileArray.forEach((file, index) => {
           const reader = new FileReader();
           reader.onload = e => {
              // photo-preview wrapper 생성
              const previewDiv = document.createElement('div');
              previewDiv.className = 'photo-preview';

              // 이미지 생성
              const img = document.createElement('img');
              img.src = e.target.result;

              // 대표 사진 뱃지 (첫 번째 이미지만)
              if(index === 0) {
                 const badge = document.createElement('div');
                 badge.className = 'photo-badge';
                 badge.textContent = '대표';
                 previewDiv.appendChild(badge);
              }

              // 삭제 버튼 추가
              const removeBtn = document.createElement('button');
              removeBtn.className = 'photo-remove';
              removeBtn.type = 'button';
              removeBtn.innerHTML = '×';
              removeBtn.onclick = () => removeImage(index);

              previewDiv.appendChild(img);
              previewDiv.appendChild(removeBtn);
              previewGrid.appendChild(previewDiv);
           };
           reader.readAsDataURL(file);
        });

        // input file 업데이트
        updateFileInput();
     }

     // FileList 업데이트 함수
     function updateFileInput() {
        const dataTransfer = new DataTransfer();
        fileArray.forEach(file => dataTransfer.items.add(file));
        photoInput.files = dataTransfer.files;
     }

     // 이미지 삭제 함수
     function removeImage(index) {
        fileArray.splice(index, 1);
        updatePreview();
     }

     photoInput.addEventListener('change', function() {
        const newFiles = Array.from(this.files);

        // 새 파일 추가
        for(let file of newFiles) {
           // 이미지 파일 체크
           if(!file.type.startsWith('image/')) {
              alert(file.name + '은(는) 이미지 파일이 아닙니다.');
              continue;
           }

           // 파일 크기 체크
           if(file.size > MAX_FILE_SIZE) {
              alert(file.name + '의 크기가 5MB를 초과합니다. 더 작은 파일을 선택해주세요.');
              continue;
           }

           // 최대 개수 체크
           if(fileArray.length >= 10) {
              alert('이미지는 최대 10장까지만 업로드 가능합니다.');
              break;
           }

           fileArray.push(file);
        }

        updatePreview();
     });
</script>
</body>
</html>


