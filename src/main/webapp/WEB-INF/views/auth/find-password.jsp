<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기 - UNILAND</title>
    <style>
        /* ========================================
        UNILAND 디자인 시스템 - CSS 변수
        ======================================== */
        :root {
            --primary-purple: #667eea;
            --primary-dark: #5568d3;
            --secondary-purple: #764ba2;
            --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --text-primary: #1a1a1a;
            --text-secondary: #555;
            --text-tertiary: #666;
            --text-light: #999;
            --bg-body: #f5f5f5;
            --bg-white: #ffffff;
            --bg-light-gray: #f0f0f0;
            --border-light: #e5e5e5;
            --border-medium: #d0d0d0;
            --spacing-sm: 12px;
            --spacing-md: 20px;
            --spacing-lg: 24px;
            --spacing-xl: 32px;
            --spacing-2xl: 40px;
            --radius-md: 6px;
            --radius-lg: 8px;
            --radius-xl: 12px;
            --font-sm: 13px;
            --font-md: 14px;
            --font-base: 15px;
            --font-lg: 16px;
            --font-2xl: 24px;
        }

        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap');

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: var(--bg-body);
            font-family: 'Noto Sans KR', sans-serif;
        }

        .find-password-container {
            width: 380px;
            padding: var(--spacing-2xl);
            background-color: var(--bg-white);
            border: 1px solid var(--border-light);
            border-radius: var(--radius-xl);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            text-align: center;
        }

        .logo {
            height: 80px;
            width: auto;
            object-fit: contain;
            margin-bottom: var(--spacing-md);
        }

        .title {
            font-size: var(--font-2xl);
            font-weight: 700;
            margin-bottom: 10px;
            color: var(--text-primary);
        }

        .description {
            font-size: var(--font-md);
            color: var(--text-tertiary);
            margin-bottom: var(--spacing-xl);
        }

        .tab-menu {
            display: flex;
            border-bottom: 2px solid var(--border-light);
            margin-bottom: var(--spacing-lg);
        }

        .tab-item {
            flex: 1;
            padding: var(--spacing-sm);
            cursor: pointer;
            font-size: var(--font-base);
            font-weight: 500;
            color: var(--text-light);
            border-bottom: 3px solid transparent;
            transition: all 0.2s ease-in-out;
        }

        .tab-item.active {
            color: var(--primary-purple);
            border-bottom-color: var(--primary-purple);
        }
        
        .tab-content { display: none; }
        .tab-content.active { display: block; }
        
        .input-field {
            width: 100%;
            padding: 14px;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-lg);
            font-size: var(--font-base);
            box-sizing: border-box;
            margin-bottom: var(--spacing-md);
        }

        .input-group {
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
            margin-bottom: var(--spacing-md);
        }
        
        .input-group input {
            flex: 1;
            width: 100%;
            padding: 14px;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-lg);
            font-size: var(--font-base);
            box-sizing: border-box;
        }

        .input-field::placeholder,
        .input-group input::placeholder {
            color: var(--text-light);
        }

        .input-group button {
            padding: 14px 15px;
            background-color: var(--bg-light-gray);
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-lg);
            cursor: pointer;
            font-size: var(--font-md);
            color: var(--text-secondary);
            font-weight: 500;
            white-space: nowrap;
        }
        
        .main-button {
            width: 100%;
            padding: 15px;
            background-color: var(--primary-purple);
            color: var(--bg-white);
            border: none;
            border-radius: var(--radius-lg);
            font-size: var(--font-lg);
            font-weight: 700;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.2s;
        }

        .main-button:hover {
            background-color: var(--primary-dark);
        }

        .sub-links {
            margin-top: var(--spacing-lg);
            font-size: var(--font-md);
        }

        .sub-links a {
            color: var(--text-tertiary);
            text-decoration: none;
        }
        
        .sub-links a:hover {
            text-decoration: underline;
        }

        .sub-links span {
            color: var(--border-medium);
            margin: 0 var(--spacing-sm);
        }

        .error-message {
            background-color: #fee;
            border: 1px solid #fcc;
            color: #c33;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 14px;
        }

        .success-message {
            background-color: #efe;
            border: 1px solid #cfc;
            color: #3c3;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 14px;
        }

        .user-info {
            background-color: #f0f0f0;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: left;
        }

        .user-info p {
            margin: 8px 0;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="find-password-container">
        <a href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="UNILAND" class="logo">
        </a>
        
        <h2 class="title">비밀번호 찾기</h2>
        <p class="description">가입 시 등록한 정보로 본인인증을 진행해 주세요.</p>

        <c:if test="${not empty errorMsg}">
            <div class="error-message">${errorMsg}</div>
        </c:if>
        <c:if test="${not empty successMsg}">
            <div class="success-message">${successMsg}</div>
        </c:if>

        <!-- 회원 정보 출력 -->
        <c:if test="${not empty user or not empty realtor}">
            <div class="user-info">
                <p><strong>회원 정보를 찾았습니다!</strong></p>
                <c:if test="${not empty user}">
                    <p>회원구분: 일반회원</p>
                    <p>아이디: ${user.userId}</p>
                    <p>이름: ${user.userName}</p>
                    <p style="color: #667eea; font-weight: bold;">비밀번호: ${user.userPassword}</p>
                </c:if>
                <c:if test="${not empty realtor}">
                    <p>회원구분: 중개사</p>
                    <p>아이디: ${realtor.realtorId}</p>
                    <p>이름: ${realtor.realtorName}</p>
                    <p style="color: #667eea; font-weight: bold;">비밀번호: ${realtor.realtorPassword}</p>
                </c:if>
                <p style="font-size: 12px; color: #999; margin-top: 10px;">※ 보안을 위해 로그인 후 비밀번호를 변경해주세요.</p>
            </div>
            <a href="${pageContext.request.contextPath}/auth/login" class="main-button" style="display:block; width:100%; text-decoration:none; text-align:center; box-sizing:border-box;">로그인하러 가기</a>
        </c:if>

        <!-- 회원 정보 미발견 시 -->
        <c:if test="${empty user and empty realtor}">
            <div class="tab-menu">
                <div class="tab-item active" onclick="switchTab('email')">이메일로 찾기</div>
                <div class="tab-item" onclick="switchTab('phone')">휴대폰으로 찾기</div>
            </div>

            <div id="email-find" class="tab-content active">
                <form action="${pageContext.request.contextPath}/auth/find-password" method="post" onsubmit="return validateForm(event, 'email')">
                    <input type="hidden" name="searchType" value="email">
                    <input type="text" name="userId" placeholder="아이디" class="input-field" required>
                    <input type="text" name="userName" placeholder="이름" class="input-field" required>
                    <div class="input-group">
                        <input type="email" name="userEmail" placeholder="이메일 주소" required>
                        <button type="button" onclick="sendVerificationCode('email')">인증번호 받기</button>
                    </div>
                    <input type="text" placeholder="인증번호 6자리" class="input-field" required>
                    <button type="submit" class="main-button">다음</button>
                </form>
            </div>

            <div id="phone-find" class="tab-content">
                <form action="${pageContext.request.contextPath}/auth/find-password" method="post" onsubmit="return validateForm(event, 'phone')">
                    <input type="hidden" name="searchType" value="phone">
                    <input type="text" name="userId" placeholder="아이디" class="input-field" required>
                    <input type="text" name="userName" placeholder="이름" class="input-field" required>
                    <div class="input-group">
                        <input type="tel" name="userPhone" placeholder="휴대폰 번호 ('-' 제외)" required>
                        <button type="button" onclick="sendVerificationCode('phone')">인증번호 받기</button>
                    </div>
                    <input type="text" placeholder="인증번호 6자리" class="input-field" required>
                    <button type="submit" class="main-button">다음</button>
                </form>
            </div>
        </c:if>
        
        <div class="sub-links">
            <a href="${pageContext.request.contextPath}/auth/login">로그인</a>
            <span>|</span>
            <a href="${pageContext.request.contextPath}/auth/signup">회원가입</a>
        </div>
    </div>

    <script>
        let generatedCode = null;

        function switchTab(tabName) {
            document.querySelectorAll('.tab-item').forEach(item => item.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
            event.currentTarget.classList.add('active');
            document.getElementById(tabName + '-find').classList.add('active');
        }

        function sendVerificationCode(type) {
            const emailInput = document.querySelector('#email-find input[name="userEmail"]');
            const phoneInput = document.querySelector('#phone-find input[name="userPhone"]');

            if (type === 'email' && (!emailInput || !emailInput.value)) {
                alert('이메일 주소를 입력해주세요.');
                return;
            }
            if (type === 'phone' && (!phoneInput || !phoneInput.value)) {
                alert('휴대폰 번호를 입력해주세요.');
                return;
            }

            generatedCode = Math.floor(100000 + Math.random() * 900000).toString();
            alert('인증번호가 발송되었습니다.\n(테스트용 인증번호: ' + generatedCode + ')');
        }

        function validateForm(event, type) {
            const codeInput = event.target.querySelector('input[placeholder="인증번호 6자리"]');
            if (generatedCode && codeInput.value !== generatedCode) {
                event.preventDefault();
                alert('인증번호가 일치하지 않습니다.');
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
