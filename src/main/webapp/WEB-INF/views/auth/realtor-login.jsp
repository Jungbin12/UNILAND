<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>중개사 로그인 - UNILAND</title>

    <!-- ✅ 기존 CSS 그대로 유지 -->
    <style>
        :root {
            --primary-purple: #667eea;
            --primary-dark: #5568d3;
            --secondary-purple: #764ba2;
            --text-primary: #1a1a1a;
            --text-secondary: #555;
            --text-tertiary: #666;
            --text-light: #999;
            --bg-body: #f5f5f5;
            --bg-white: #ffffff;
            --border-light: #e5e5e5;
            --border-medium: #d0d0d0;
            --spacing-sm: 12px;
            --spacing-md: 20px;
            --spacing-lg: 24px;
            --spacing-xl: 32px;
            --spacing-2xl: 40px;
            --radius-md: 6px;
            --radius-lg: 8px;
            --font-sm: 12.5px;
            --font-md: 14px;
            --font-base: 15px;
            --font-lg: 16px;
            --font-2xl: 24px;
            --font-3xl: 32px;
        }

        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: var(--bg-body);
        }

        .main-container {
            max-width: 420px;
            margin: 80px auto;
            padding: var(--spacing-md);
        }

        .login-card {
            background: var(--bg-white);
            border-radius: var(--radius-lg);
            padding: var(--spacing-2xl);
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            text-align: center;
        }

        .login-logo {
            margin-bottom: 10px;
        }

        .login-logo img {
            height: 80px;
            object-fit: contain;
        }

        .login-subtitle {
            color: var(--text-light);
            font-size: var(--font-md);
            margin-bottom: var(--spacing-2xl);
        }

        .input-group {
            margin-bottom: var(--spacing-md);
        }

        .input-field {
            width: 100%;
            padding: 14px;
            border: 1px solid var(--border-light);
            border-radius: var(--radius-md);
            font-size: var(--font-base);
            outline: none;
            transition: border-color 0.3s;
        }

        .input-field:focus {
            border-color: var(--primary-purple);
        }

        .input-field::placeholder {
            color: var(--text-light);
        }

        .login-btn {
            width: 100%;
            padding: 14px;
            background: var(--primary-purple);
            color: var(--bg-white);
            border: none;
            border-radius: var(--radius-md);
            font-size: var(--font-lg);
            font-weight: 500;
            cursor: pointer;
            margin-top: 10px;
            transition: background 0.3s;
        }

        .login-btn:hover {
            background: var(--primary-dark);
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            margin: var(--spacing-md) 0;
            font-size: var(--font-md);
            color: var(--text-secondary);
        }

        .checkbox-group input {
            margin-right: 8px;
        }

        .login-footer {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: var(--spacing-md);
            margin-top: var(--spacing-xl);
            font-size: var(--font-sm);
        }

        .login-footer a {
            color: var(--text-tertiary);
            text-decoration: none;
            transition: color 0.2s;
        }

        .login-footer a:hover {
            color: var(--primary-purple);
        }

        .login-footer .divider {
            color: var(--border-light);
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="login-card">
            <div class="login-logo">
            	<a href="${pageContext.request.contextPath}/">
	                <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="UNILAND">
            	</a>
            </div>
            <div class="login-subtitle">중개사 로그인 페이지</div>

            <!-- ✅ 로그인 실패 시 alert 띄우기 -->
            <c:if test="${not empty loginError}">
                <script>
                    alert("${loginError}");
                </script>
            </c:if>

            <form action="${pageContext.request.contextPath}/realtor/realtor-login" method="post">
                <div class="input-group">
                    <input type="text" name="realtorId" class="input-field" placeholder="중개사 아이디를 입력해주세요" required>
                </div>
                <div class="input-group">
                    <input type="password" name="password" class="input-field" placeholder="비밀번호를 입력해주세요" required>
                </div>
                <div class="input-group">
                    <input type="text" name="businessNumber" class="input-field" placeholder="사업자등록번호를 입력해주세요" required>
                </div>

                <div class="checkbox-group">
                    <input type="checkbox" name="remember" id="remember">
                    <label for="remember">로그인 상태 유지</label>
                </div>

                <button type="submit" class="login-btn">중개사 로그인</button>
            </form>

            <div class="login-footer">
                <a href="${pageContext.request.contextPath}/auth/find-password">비밀번호 찾기</a>
                <span class="divider">|</span>
                <a href="${pageContext.request.contextPath}/auth/signup-realtor">회원가입</a>
                <span class="divider">|</span>
                <a href="${pageContext.request.contextPath}/auth/login">일반 회원 로그인</a>
            </div>
        </div>
    </div>
</body>
</html>
