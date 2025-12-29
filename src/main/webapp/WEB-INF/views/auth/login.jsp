<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 - UNILAND</title>
    <style>
        /* ========================================
        UNILAND 디자인 시스템 - CSS 변수
        ======================================== */
        :root {
            /* 메인 컬러 */
            --primary-purple: #667eea;
            --primary-dark: #5568d3;
            --secondary-purple: #764ba2;

            /* 텍스트 컬러 */
            --text-primary: #1a1a1a;
            --text-secondary: #555;
            --text-tertiary: #666;
            --text-light: #999;

            /* 배경 컬러 */
            --bg-body: #f5f5f5;
            --bg-white: #ffffff;

            /* 테두리 컬러 */
            --border-light: #e5e5e5;
            --border-medium: #d0d0d0;

            /* 간격 (Spacing) */
            --spacing-sm: 12px;
            --spacing-md: 20px;
            --spacing-lg: 24px;
            --spacing-xl: 32px;
            --spacing-2xl: 40px;
            --spacing-4xl: 60px;

            /* 모서리 반경 (Border Radius) */
            --radius-md: 6px;
            --radius-lg: 8px;

            /* 폰트 크기 (Font Size) */
            --font-sm: 13px;
            --font-md: 14px;
            --font-base: 15px;
            --font-lg: 16px;
            --font-2xl: 24px;
            --font-3xl: 32px;
        }

        /* ========================================
        스타일 초기화 및 기본 설정
        ======================================== */
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

        /* ========================================
        컴포넌트 스타일 (디자인 시스템 적용)
        ======================================== */
        /* 메인 컨텐츠 */
        .main-container {
            max-width: 420px; /* 로그인 카드에 맞춰 너비 조정 */
            margin: 80px auto;
            padding: var(--spacing-md);
        }

        .login-card {
            background: var(--bg-white);
            border-radius: var(--radius-lg);
            padding: var(--spacing-2xl) var(--spacing-2xl);
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

        .social-divider {
            display: flex;
            align-items: center;
            margin: var(--spacing-xl) 0;
            color: var(--text-light);
            font-size: var(--font-md);
        }

        .social-divider::before,
        .social-divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: var(--border-light);
        }

        .social-divider::before { margin-right: 15px; }
        .social-divider::after { margin-left: 15px; }

        .social-login {
            display: flex;
            gap: var(--spacing-md);
            justify-content: center;
        }

        .social-btn {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: 1px solid var(--border-light);
            background: var(--bg-white);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .social-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

		.login-footer {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    gap: 15px;
		    margin-top: var(--spacing-xl);
		    font-size: var(--font-md);
		}
		
		.login-footer a {
		    color: var(--text-tertiary);
		    text-decoration: none;
		    transition: color 0.2s;
		    white-space: nowrap;
		}
		
		.login-footer a:hover {
		    color: var(--primary-purple);
		}
		
		.divider {
		    color: var(--text-light);
		    font-weight: 300;
		}

        .error-message {
            color: #f56565;
            font-size: 14px;
            margin-bottom: 20px;
            display: ${not empty error ? 'block' : 'none'};
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
            <div class="login-subtitle">대학교 부동산 임대 플랫폼</div>

            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/auth/login" method="post">
                <input type="hidden" name="redirectUrl" value="${redirectUrl}">
                <div class="input-group">
                    <input type="text" name="userId" class="input-field" placeholder="아이디를 입력해주세요" required>
                </div>
                <div class="input-group">
                    <input type="password" name="userPassword" class="input-field" placeholder="비밀번호를 입력해주세요" required>
                </div>

                <div class="checkbox-group">
                    <input type="checkbox" name="remember" id="remember">
                    <label for="remember">로그인 상태 유지</label>
                </div>

                <button type="submit" class="login-btn">로그인</button>
            </form>

            <div class="social-divider">소셜 로그인</div>

            <div class="social-login">
                <button class="social-btn" title="Google"><img src="https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_%22G%22_logo.svg" alt="Google" width="24"></button>
                <button class="social-btn" title="Kakao"><img src="https://www.kakaocorp.com/page/favicon.ico" alt="Kakao" width="24"></button>
                <button class="social-btn" title="Naver"><img src="https://logoproject.naver.com/favicon.ico" alt="Naver" width="24"></button>
            </div>

            <div class="login-footer">
                <a href="${pageContext.request.contextPath}/auth/find-password">비밀번호 찾기</a>
                <span class="divider">|</span>
                <a href="${pageContext.request.contextPath}/auth/signup">회원가입</a>
                <span class="divider">|</span>
                <a href="${pageContext.request.contextPath}/auth/realtor-login">중개사 로그인</a>
            </div>
        </div>
    </div>
</body>
</html>
