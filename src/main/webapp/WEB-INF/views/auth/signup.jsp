<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일반 회원가입 - UNILAND</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f5f5f5;
        }

        .main-container {
            max-width: 700px;
            margin: 60px auto;
            padding: 20px;
        }

        .signup-card {
            background: white;
            border-radius: 8px;
            padding: 40px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .page-logo {
            text-align: center;
            margin-bottom: 24px;
        }

        .page-logo img {
            height: 80px;
        }

        .page-title {
            text-align: center;
            font-size: 22px;
            font-weight: 600;
            margin-bottom: 40px;
            padding-bottom: 20px;
            border-bottom: 2px solid #1a1a1a;
        }

        .form-wrapper {
            max-width: 450px;
            margin: 0 auto;
        }

        .form-row {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .form-label {
            width: 120px;
            font-size: 14px;
            flex-shrink: 0;
        }

        .form-label .required {
            color: #f56565;
            margin-right: 4px;
        }

        .form-input-group {
            flex: 1;
        }

        .input-field, .select-field {
            width: 100%;
            padding: 12px;
            border: 1px solid #d0d0d0;
            border-radius: 6px;
            font-size: 14px;
            background-color: white;
        }

        .input-field:focus, .select-field:focus {
            outline: none;
            border-color: #667eea;
        }

        .select-field:disabled {
            background-color: #f5f5f5;
            cursor: not-allowed;
        }

        .gender-group {
            display: flex;
            gap: 30px;
        }

        .submit-section {
            margin-top: 40px;
            text-align: center;
        }

        .submit-btn {
            width: 200px;
            padding: 14px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
        }

        .submit-btn:hover {
            background: #5568d3;
        }

        .signup-footer {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
            font-size: 14px;
        }

        .signup-footer a {
            color: #666;
            text-decoration: none;
        }

        .signup-footer a:hover {
            color: #667eea;
        }

        .loading-text {
            color: #999;
            font-size: 13px;
            margin-top: 4px;
        }

        .error-message {
            background-color: #fee;
            border: 1px solid #fcc;
            color: #c33;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
        }

        .success-message {
            background-color: #efe;
            border: 1px solid #cfc;
            color: #3c3;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="signup-card">
            <div class="page-logo">
                <a href="${pageContext.request.contextPath}/">
                    <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="UNILAND">
                </a>
            </div>
            <h1 class="page-title">회원가입 정보 입력</h1>

            <c:if test="${not empty errorMsg}">
                <div class="error-message">${errorMsg}</div>
            </c:if>
            <c:if test="${not empty successMsg}">
                <div class="success-message">${successMsg}</div>
            </c:if>

            <div class="form-wrapper">
                <form action="${pageContext.request.contextPath}/auth/signup" method="post">
                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>이름</label>
                        <div class="form-input-group">
                            <input type="text" name="userName" class="input-field" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>아이디</label>
                        <div class="form-input-group">
                            <input type="text" name="userId" class="input-field"
                                   placeholder="영문, 숫자 6~12자" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>비밀번호</label>
                        <div class="form-input-group">
                            <input type="password" name="userPassword" class="input-field"
                                   placeholder="영문, 숫자, 특수문자 조합 8자 이상" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>생년월일</label>
                        <div class="form-input-group">
                            <input type="date" name="birthDate" class="input-field" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>성별</label>
                        <div class="form-input-group">
                            <div class="gender-group">
                                <label><input type="radio" name="userGender" value="M" required> 남자</label>
                                <label><input type="radio" name="userGender" value="F" required> 여자</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>연락처</label>
                        <div class="form-input-group">
                            <input type="tel" name="userPhone" class="input-field"
                                   placeholder="'-' 없이 숫자만 입력" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>이메일</label>
                        <div class="form-input-group">
                            <input type="email" name="userEmail" class="input-field" required>
                        </div>
                    </div>
                    
                    <!-- 지역 선택 추가 -->
                    <div class="form-row">
                        <label class="form-label">지역</label>
                        <div class="form-input-group">
                            <select id="regionSelect" name="userRegion" class="select-field">
                                <option value="">지역을 선택하세요</option>
                                <option value="100260">서울특별시</option>
                                <option value="100276">경기도</option>
                                <option value="100267">부산광역시</option>
                                <option value="100269">인천광역시</option>
                                <option value="100271">대전광역시</option>
                                <option value="100272">대구광역시</option>
                                <option value="100273">울산광역시</option>
                                <option value="100275">광주광역시</option>
                                <option value="100278">강원도</option>
                                <option value="100280">충청북도</option>
                                <option value="100281">충청남도</option>
                                <option value="100282">전북특별자치도</option>
                                <option value="100283">전라남도</option>
                                <option value="100285">경상북도</option>
                                <option value="100291">경상남도</option>
                                <option value="100292">제주도</option>
                            </select>
                        </div>
                    </div>
                    
                    <!-- 학교 선택 -->
                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>학교</label>
                        <div class="form-input-group">
                            <select id="schoolSelect" name="userSchool" class="select-field" required disabled>
                                <option value="">지역을 먼저 선택하세요</option>
                            </select>
                            <div id="loadingText" class="loading-text" style="display:none;">불러오는 중...</div>
                        </div>
                    </div>
                    
                    <div class="submit-section">
                        <button type="submit" class="submit-btn">회원가입</button>
                    </div>
                </form>
            </div>

            <div class="signup-footer">
                <a href="${pageContext.request.contextPath}/auth/login">로그인</a>
                <span>|</span>
                <a href="${pageContext.request.contextPath}/auth/signup-realtor">중개사 회원가입</a>
            </div>
        </div>
    </div>

    <script>
        const regionSelect = document.getElementById('regionSelect');
        const schoolSelect = document.getElementById('schoolSelect');
        const loadingText = document.getElementById('loadingText');

        // 지역 선택 시 대학교 목록 불러오기
        regionSelect.addEventListener('change', async function() {
            const regionCode = this.value;
            
            // 초기화
            schoolSelect.innerHTML = '<option value="">대학교를 선택하세요</option>';
            schoolSelect.disabled = true;
            
            if (!regionCode) {
                schoolSelect.innerHTML = '<option value="">지역을 먼저 선택하세요</option>';
                return;
            }

            // 로딩 표시
            loadingText.style.display = 'block';
            
            try {
                // 백엔드 프록시를 통해 API 호출
                const url = '${pageContext.request.contextPath}/api/universities?region=' + regionCode;
                
                console.log('Calling:', url);
                
                const response = await fetch(url);
                console.log('Response status:', response.status);
                
                if (!response.ok) {
                    throw new Error('서버 응답 오류: ' + response.status);
                }
                
                const text = await response.text();
                console.log('Response text:', text);
                
                const data = JSON.parse(text);
                console.log('Parsed data:', data);
                
                if (data.dataSearch && data.dataSearch.content) {
                    const universities = data.dataSearch.content;
                    
                    // 대학교 목록이 있으면
                    if (universities.length > 0) {
                        // 학교명 기준으로 정렬
                        universities.sort((a, b) => a.schoolName.localeCompare(b.schoolName));
                        
                        // 옵션 추가
                        universities.forEach(univ => {
                            const option = document.createElement('option');
                            option.value = univ.schoolName;
                            option.textContent = univ.schoolName + ' (' + univ.estType + ')';
                            schoolSelect.appendChild(option);
                        });
                        
                        schoolSelect.disabled = false;
                    } else {
                        schoolSelect.innerHTML = '<option value="">해당 지역에 대학교가 없습니다</option>';
                    }
                } else {
                    console.error('Unexpected data structure:', data);
                    schoolSelect.innerHTML = '<option value="">데이터를 불러올 수 없습니다</option>';
                }
            } catch (error) {
                console.error('API 호출 실패:', error);
                console.error('Error details:', error.message);
                schoolSelect.innerHTML = '<option value="">오류가 발생했습니다</option>';
            } finally {
                loadingText.style.display = 'none';
            }
        });
    </script>
</body>
</html>