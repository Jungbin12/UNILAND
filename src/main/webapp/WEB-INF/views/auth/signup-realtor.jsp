<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공인중개사 회원가입 - UNILAND</title>
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <style>
        /* ⚠️ 기존 CSS는 전혀 수정하지 않음 */
        :root {
            --primary-purple: #667eea;
            --primary-dark: #5568d3;
            --badge-urgent: #f56565;
            --text-primary: #1a1a1a;
            --text-secondary: #555;
            --text-tertiary: #666;
            --text-light: #999;
            --bg-body: #f5f5f5;
            --bg-white: #ffffff;
            --bg-light-gray: #f0f0f0;
            --border-light: #e5e5e5;
            --border-medium: #d0d0d0;
            --spacing-xs: 6px;
            --spacing-sm: 12px;
            --spacing-md: 20px;
            --spacing-lg: 24px;
            --spacing-xl: 32px;
            --spacing-2xl: 40px;
            --spacing-4xl: 60px;
            --radius-md: 6px;
            --radius-lg: 8px;
            --font-sm: 13px;
            --font-md: 14px;
            --font-lg: 16px;
            --font-2xl: 24px;
        }
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap');
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Noto Sans KR', sans-serif; background-color: var(--bg-body); }
        .main-container { max-width: 700px; margin: var(--spacing-4xl) auto; padding: var(--spacing-md); }
        .signup-card { background: var(--bg-white); border-radius: var(--radius-lg); padding: var(--spacing-2xl); box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
        .page-logo { text-align: center; margin-bottom: var(--spacing-lg); }
        .page-logo img { height: 80px; object-fit: contain; }
        .page-title { text-align: center; font-size: 22px; font-weight: 600; color: var(--text-primary); margin-bottom: var(--spacing-2xl); padding-bottom: var(--spacing-md); border-bottom: 2px solid var(--text-primary); }
        .form-wrapper { max-width: 450px; margin: 0 auto; }
        .form-row { display: flex; align-items: center; margin-bottom: var(--spacing-md); }
        /* ⭐ 수정: 라벨 너비를 140px로 확장 및 줄바꿈 방지 */
        .form-label { width: 140px; font-size: var(--font-md); color: var(--text-primary); flex-shrink: 0; white-space: nowrap; } 
        .form-label .required { color: var(--badge-urgent); margin-right: 4px; }
        .form-input-group { position: relative; flex: 1; display: flex; gap: var(--spacing-sm); align-items: center; }
        .form-input-group .input-field { 
            flex: 1;
            width: auto;
            padding: 12px; border: 1px solid var(--border-medium); border-radius: var(--radius-md); font-size: var(--font-md); outline: none; background-color: var(--bg-white); transition: border-color 0.3s; 
        }
        .input-field:focus { border-color: var(--primary-purple); }
        .password-toggle-icon { position: absolute; top: 50%; right: 12px; transform: translateY(-50%); cursor: pointer; color: var(--text-light); user-select: none; display: none; }
        .btn-check { padding: 12px 16px; background: var(--bg-white); border: 1px solid var(--border-medium); border-radius: var(--radius-md); color: var(--text-tertiary); font-size: var(--font-sm); cursor: pointer; white-space: nowrap; flex-shrink: 0; transition: all 0.2s; }
        .btn-check:hover { background: var(--bg-light-gray); border-color: var(--primary-purple); color: var(--primary-purple); }
        .btn-check:disabled { background: var(--bg-light-gray); border-color: var(--border-light); color: var(--text-light); cursor: not-allowed; }
        .verification-message { font-size: var(--font-sm); margin-top: 4px; display: none; }
        .verification-message.success { color: #22c55e; display: block; }
        .verification-message.error { color: var(--badge-urgent); display: block; }
        .submit-section { margin-top: var(--spacing-2xl); text-align: center; }
        .submit-btn { width: 100%; max-width: 200px; padding: 14px; background: var(--primary-purple); color: var(--bg-white); border: none; border-radius: var(--radius-md); font-size: var(--font-lg); font-weight: 500; cursor: pointer; transition: background 0.3s; }
        .submit-btn:hover { background: var(--primary-dark); }
        .submit-btn:disabled { background: var(--text-light); cursor: not-allowed; }
        .signup-footer { display: flex; justify-content: center; gap: var(--spacing-md); margin-top: var(--spacing-xl); font-size: var(--font-md); }
        .signup-footer a { color: var(--text-tertiary); text-decoration: none; }
        .signup-footer a:hover { color: var(--primary-purple); }
        .signup-footer .divider { color: var(--border-light); }
        
        /* 주소 상세 입력 줄의 간격 제거 */
        .form-wrapper .form-row.address-detail-row {
            margin-bottom: var(--spacing-md); 
            margin-top: var(--spacing-sm); 
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
            <h1 class="page-title">중개사 회원가입</h1>
            <div class="form-wrapper">
                <form id="realtorSignupForm">
                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>아이디</label>
                        <div class="form-input-group">
                            <input type="text" class="input-field" id="realtorId" name="realtorId" placeholder="아이디를 입력하세요" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>비밀번호</label>
                        <div class="form-input-group">
                            <input type="password" class="input-field" id="realtorPassword" name="realtorPassword" placeholder="비밀번호를 입력하세요" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>중개 사무소 이름</label>
                        <div class="form-input-group">
                            <input type="text" class="input-field" id="officeName" name="officeName" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>대표자명</label>
                        <div class="form-input-group">
                            <input type="text" class="input-field" id="realtorName" name="realtorName" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>주소</label>
                        <div class="form-input-group">
                            <input type="text" class="input-field" id="realtorAddressBase" placeholder="주소 검색을 클릭하세요" readonly required>
                            <button type="button" class="btn-check" id="searchAddressBtn">주소 검색</button>
                        </div>
                    </div>
                    <div class="form-row address-detail-row">
                        <label class="form-label"></label>
                        <div class="form-input-group">
                             <input type="text" class="input-field" id="realtorAddressDetail" placeholder="나머지 상세 주소 입력 (예: 건물명, 동/호수)">
                        </div>
                    </div>
                    
                    <input type="hidden" id="realtorAddress" name="realtorAddress">

                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>공인중개사 연락처</label>
                        <div class="form-input-group">
                            <input type="tel" class="input-field" id="realtorPhone" name="realtorPhone" placeholder="'-' 없이 숫자만 입력" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>공인중개사 이메일</label>
                        <div class="form-input-group">
                            <input type="email" class="input-field" id="realtorEmail" name="realtorEmail" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>중개사 등록번호</label>
                        <div class="form-input-group">
                            <input type="text" class="input-field" id="realtorRegNum" name="realtorRegNum" 
                                   placeholder="'-' 없이 숫자만 입력" 
                                   maxlength="16" required> <button type="button" class="btn-check" id="verifyRegNumBtn">중복확인</button>
                        </div>
                    </div>
                    <div class="verification-message" id="verificationRegNumMsg"></div>
                    
                    <div class="form-row">
                        <label class="form-label"><span class="required">*</span>사업자 등록번호</label>
                        <div class="form-input-group">
                            <input type="text" class="input-field" id="businessNum" name="businessNum" placeholder="'-' 없이 숫자만 입력" required>
                            <button type="button" class="btn-check" id="verifyBusinessNumBtn">인증</button>
                        </div>
                    </div>
                    <div class="verification-message" id="verificationBusinessNumMsg"></div>

                    <div class="submit-section">
                        <button type="submit" class="submit-btn" id="submitBtn" disabled>회원가입 신청</button>
                    </div>
                </form>
            </div>

            <div class="signup-footer">
                <a href="${pageContext.request.contextPath}/auth/realtor-login">로그인</a>
                <span class="divider">|</span>
                <a href="${pageContext.request.contextPath}/auth/signup">일반 회원가입</a>
            </div>
        </div>
    </div>

    <script>
        const contextPath = '${pageContext.request.contextPath}';
        const form = document.getElementById('realtorSignupForm');
        
        // 버튼 및 메시지 요소
        const verifyBusinessNumBtn = document.getElementById('verifyBusinessNumBtn');
        const verifyRegNumBtn = document.getElementById('verifyRegNumBtn');
        const submitBtn = document.getElementById('submitBtn');
        const searchAddressBtn = document.getElementById('searchAddressBtn');
        const verificationBusinessNumMsg = document.getElementById('verificationBusinessNumMsg');
        const verificationRegNumMsg = document.getElementById('verificationRegNumMsg');

        // 입력 필드 요소
        const fields = {
            realtorId: document.getElementById('realtorId'),
            realtorPassword: document.getElementById('realtorPassword'),
            officeName: document.getElementById('officeName'),
            realtorName: document.getElementById('realtorName'),
            realtorAddress: document.getElementById('realtorAddress'), 
            realtorAddressBase: document.getElementById('realtorAddressBase'),
            realtorAddressDetail: document.getElementById('realtorAddressDetail'),
            realtorPhone: document.getElementById('realtorPhone'),
            realtorEmail: document.getElementById('realtorEmail'),
            realtorRegNum: document.getElementById('realtorRegNum'),
            businessNum: document.getElementById('businessNum')
        };

        // 인증 상태 플래그
        let isBusinessNumVerified = false;
        let isRegNumVerified = false; 

        // ----------------------- 1. 주소 검색 함수 -----------------------
        searchAddressBtn.addEventListener('click', () => {
            new daum.Postcode({
                oncomplete: function(data) {
                    let fullAddress = data.roadAddress || data.jibunAddress;
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

                    // 1. 기본 주소 필드에 주소 정보 입력
                    fields.realtorAddressBase.value = fullAddress;
                    
                    // 2. 상세 주소 필드에 포커스
                    fields.realtorAddressDetail.focus();
                    
                    // 3. 폼 유효성 체크 트리거
                    checkFormValidity();
                }
            }).open();
        });


        // ----------------------- 2. 입력 필드 이벤트 처리 -----------------------

        // 연락처: 숫자만 입력 허용
        fields.realtorPhone.addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9]/g, '');
            checkFormValidity();
        });

        // 사업자 등록번호: 숫자만 입력 허용 및 인증 초기화
        fields.businessNum.addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9]/g, ''); 
            isBusinessNumVerified = false;
            verificationBusinessNumMsg.classList.remove('success', 'error');
            verificationBusinessNumMsg.textContent = '';
            checkFormValidity();
        });
        
        // 중개사 등록번호: 입력 시 인증 초기화
        fields.realtorRegNum.addEventListener('input', function() {
            isRegNumVerified = false;
            verificationRegNumMsg.classList.remove('success', 'error');
            verificationRegNumMsg.textContent = '';
            checkFormValidity();
        });
        
        // 주소 상세 입력 시 유효성 체크
        fields.realtorAddressDetail.addEventListener('input', checkFormValidity);

        // 기타 필드: 입력 시 폼 유효성 체크
        Object.values(fields).forEach(f => {
            if (f !== fields.realtorPhone && f !== fields.businessNum && f !== fields.realtorRegNum && f !== fields.realtorAddressDetail) {
                f.addEventListener('input', checkFormValidity);
            }
        });

        // ----------------------- 3. 중복 확인/인증 이벤트 처리 -----------------------

        // 중개사 등록번호 중복 확인
        verifyRegNumBtn.addEventListener('click', e => {
            e.preventDefault();
            const regNum = fields.realtorRegNum.value.trim();
            
            if (!regNum) {
                verificationRegNumMsg.classList.add('error');
                verificationRegNumMsg.textContent = '중개사 등록번호를 입력해주세요.';
                return;
            }
            
            // 하이픈 제거 후 14자리 검사
            const cleanRegNum = regNum.replace(/[^0-9]/g, '');
            if (cleanRegNum.length !== 14) {
                 verificationRegNumMsg.classList.add('error');
                 verificationRegNumMsg.textContent = '중개사 등록번호는 14자리 숫자(하이픈 포함 가능)여야 합니다.';
                 return;
            }

            verifyRegNumBtn.disabled = true;
            verifyRegNumBtn.textContent = '확인 중...';
            
            fetch(contextPath + '/realtor/check-realtor-reg-num', { 
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                // 서버에는 하이픈 제거된 클린한 값 전송
                body: JSON.stringify({ realtorRegNum: cleanRegNum })
            })
            .then(res => res.json())
            .then(data => {
                if (data.isDuplicate) {
                    verificationRegNumMsg.classList.add('error');
                    verificationRegNumMsg.textContent = '이미 등록된 중개사 등록번호입니다.';
                    isRegNumVerified = false;
                } else {
                    verificationRegNumMsg.classList.add('success');
                    verificationRegNumMsg.textContent = '사용 가능한 중개사 등록번호입니다.';
                    isRegNumVerified = true;
                }
                checkFormValidity();
            })
            .finally(() => {
                verifyRegNumBtn.disabled = false;
                verifyRegNumBtn.textContent = '중복확인';
            });
        });


        // 사업자 등록번호 인증
        verifyBusinessNumBtn.addEventListener('click', e => {
            e.preventDefault();
            const businessNum = fields.businessNum.value.trim();
            if (!businessNum) {
                verificationBusinessNumMsg.classList.add('error');
                verificationBusinessNumMsg.textContent = '사업자 등록번호를 입력해주세요.';
                return;
            }
            // 사업자등록번호는 10자리 숫자만 유효성 검증
            if (!/^\d{10}$/.test(businessNum)) {
                verificationBusinessNumMsg.classList.add('error');
                verificationBusinessNumMsg.textContent = '사업자 등록번호는 10자리 숫자여야 합니다.';
                return;
            }
            
            verifyBusinessNumBtn.disabled = true;
            verifyBusinessNumBtn.textContent = '확인 중...';
            
            fetch(contextPath + '/realtor/check-business-num', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ businessNum })
            })
            .then(res => res.json())
            .then(data => {
                if (data.isDuplicate) {
                    verificationBusinessNumMsg.classList.add('error');
                    verificationBusinessNumMsg.textContent = '이미 등록된 사업자 등록번호입니다.';
                    isBusinessNumVerified = false;
                } else {
                    verificationBusinessNumMsg.classList.add('success');
                    verificationBusinessNumMsg.textContent = '사용 가능한 사업자 등록번호입니다.';
                    isBusinessNumVerified = true;
                }
                checkFormValidity();
            })
            .finally(() => {
                verifyBusinessNumBtn.disabled = false;
                verifyBusinessNumBtn.textContent = '인증';
            });
        });

        // ----------------------- 4. 최종 유효성 검사 및 제출 -----------------------

        function checkFormValidity() {
            // 모든 필드가 채워져야 함
            const allFields = [
                fields.realtorId, fields.realtorPassword, fields.officeName, 
                fields.realtorName, fields.realtorPhone, fields.realtorEmail,
                fields.realtorRegNum, fields.businessNum,
                fields.realtorAddressBase, fields.realtorAddressDetail
            ];
            
            const allFilled = allFields.every(f => f.value.trim() !== '');
            
            // 두 가지 인증이 모두 완료되어야 함
            submitBtn.disabled = !(allFilled && isBusinessNumVerified && isRegNumVerified);
        }

        form.addEventListener('submit', e => {
            e.preventDefault();
            
            // 폼 제출 직전에 통합 주소 필드 값 설정
            const baseAddress = fields.realtorAddressBase.value.trim();
            const detailAddress = fields.realtorAddressDetail.value.trim();
            fields.realtorAddress.value = baseAddress + (detailAddress ? ' ' + detailAddress : '');
            
            if (!isBusinessNumVerified || !isRegNumVerified) {
                alert('모든 필수 필드를 채우고 사업자 등록번호 및 중개사 등록번호 인증을 완료해주세요.');
                return;
            }
            
            // 전송 직전에 등록번호와 사업자번호의 하이픈 제거 (서버의 DB 형식에 맞춤)
            const finalRealtorRegNum = fields.realtorRegNum.value.trim().replace(/[^0-9]/g, '');
            const finalBusinessNum = fields.businessNum.value.trim().replace(/[^0-9]/g, '');
            const finalRealtorPhone = fields.realtorPhone.value.trim().replace(/[^0-9]/g, '');

            const formData = {
                realtorId: fields.realtorId.value.trim(),
                realtorPassword: fields.realtorPassword.value.trim(),
                officeName: fields.officeName.value.trim(),
                realtorName: fields.realtorName.value.trim(),
                realtorAddress: fields.realtorAddress.value.trim(), 
                realtorPhone: finalRealtorPhone, // 클린한 값 전송
                realtorEmail: fields.realtorEmail.value.trim(),
                realtorRegNum: finalRealtorRegNum,
                businessNum: finalBusinessNum
            };

            submitBtn.disabled = true;
            submitBtn.textContent = '처리 중...';

            fetch(contextPath + '/realtor/register', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData)
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    alert('회원가입 신청이 완료되었습니다.');
                    window.location.href = contextPath + '/auth/realtor-login';
                } else {
                    alert('회원가입 실패: ' + (data.message || '알 수 없는 오류'));
                }
            })
            .catch(err => {
                console.error('Error:', err);
                alert('회원가입 중 네트워크 오류가 발생했습니다.');
            })
            .finally(() => {
                submitBtn.disabled = false;
                submitBtn.textContent = '회원가입 신청';
            });
        });
    </script>
</body>
</html>