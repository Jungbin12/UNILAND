<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>
    <div class="header-container">
        <div class="header-left">
            <a href="${pageContext.request.contextPath}/realtor/realtor-dashboard" class="logo">
                <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="UNILAND">
            </a>
            
            <%-- 지도검색 관련 c:choose 블록 제거됨 --%>
        </div>
        <div class="auth-buttons">
            <c:choose>
               <c:when test="${not empty sessionScope.loginRealtor}">
                    <a href="${pageContext.request.contextPath}/realtor/realtor-mypage" class="btn-mypage">
                        <i class="fa-solid fa-user"></i> ${loginRealtor.realtorName} 중개사님
                    </a>
                    <button class="btn-logout" onclick="realtorLogout()">
                        <i class="fa-solid fa-right-from-bracket"></i> 로그아웃
                    </button>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/realtor/realtor-login" class="btn-login">
                        <i class="fa-solid fa-right-to-bracket"></i> 중개사 로그인
                    </a>
                    <a href="${pageContext.request.contextPath}/realtor/realtor-signup" class="btn-signup">
                        <i class="fa-solid fa-user-plus"></i> 중개사 회원가입
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<style>
    /* ⚠️ 주의: CSS는 요청에 따라 절대 수정하지 않았습니다. */
    /* 헤더 */
    header {
        background: white;
        border-bottom: 1px solid #e5e5e5;
        padding: 18px 0;
        position: sticky;
        top: 0;
        z-index: 100;
    }

    .header-container {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 24px;
    }

    .header-left {
        display: flex;
        align-items: center;
        gap: 32px;
    }

    .logo {
        display: flex;
        align-items: center;
        gap: 12px;
        cursor: pointer;
        text-decoration: none;
    }

    .logo img {
        height: 60px;
        object-fit: contain;
        object-position: center;
    }

    .header-map-btn {
        display: flex;
        align-items: center;
        gap: 6px;
        padding: 9px 18px;
        background: white;
        color: #667eea;
        border: 1px solid #d0d0d0;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.2s;
        text-decoration: none;
    }

    .header-map-btn:hover {
        background: #fafafa;
        border-color: #667eea;
    }

    .auth-buttons {
        display: flex;
        gap: 12px;
    }

    .auth-buttons a, .auth-buttons button {
        padding: 9px 20px;
        background: none;
        border: none;
        border-radius: 3px;
        cursor: pointer;
        font-size: 14px;
        font-weight: 500;
        transition: all 0.2s;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        color: #555;
    }

    .auth-buttons a:hover, .auth-buttons button:hover {
        color: #667eea;
        background: #f5f5f5;
    }

    .btn-signup {
        color: #667eea;
    }

    .btn-login {
        color: #555;
    }

    .btn-mypage {
        color: #667eea;
    }

    .btn-logout {
        color: #f56565;
    }

    .btn-logout:hover {
        color: #e53e3e;
        background: #fee;
    }
</style>

<script>
    // 기존 logout 함수는 일반 사용자용입니다.
    // 중개사 전용 로그아웃 함수를 추가하고 경로를 변경합니다.
    function realtorLogout() {
        if (confirm('로그아웃 하시겠습니까?')) {
            location.href = '${pageContext.request.contextPath}/realtor/logout'; // 중개사 로그아웃 경로
        }
    }
</script>