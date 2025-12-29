<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 푸터 -->
<footer>
    <div class="footer-container">
        <div class="footer-content">
            <div class="footer-section">
                <div class="footer-logo">
                    <img src="${pageContext.request.contextPath}/assets/images/footerlogo.png" alt="UNILAND">
                </div>
                <p>대학생을 위한 맞춤형 부동산 중개 플랫폼</p>
                <p style="margin-top: 20px;">
                    서울특별시 남대문로 120<br>
                    사업자등록번호: 123-45-67890<br>
                    통신판매업신고: 2024-서울강남-00000
                </p>
            </div>
            <div class="footer-section">
                <h4>서비스</h4>
                <a href="${pageContext.request.contextPath}/map">지도에서 매물 찾기</a>
                <a href="${pageContext.request.contextPath}/community/guide">자취 가이드</a>
                <a href="${pageContext.request.contextPath}/mypage">마이페이지</a>
            </div>
            <div class="footer-section">
                <h4>고객지원</h4>
                <a href="${pageContext.request.contextPath}/community/notice">공지사항</a>
                <a href="${pageContext.request.contextPath}/auth/find-password">비밀번호 찾기</a>
            </div>
            <div class="footer-section">
                <h4>중개사</h4>
                <a href="${pageContext.request.contextPath}/auth/signup-realtor">중개사 회원가입</a>
                <a href="${pageContext.request.contextPath}/auth/realtor-login">중개사 로그인</a>
                <p style="margin-top: 20px;">
                    고객센터: 1588-0000<br>
                    평일 09:00 - 18:00
                </p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2025 UNILAND. All rights reserved.</p>
        </div>
    </div>
</footer>

<style>
    /* 푸터 */
    footer {
        background: #2a2a2a;
        color: #999;
        padding: 56px 0 32px;
        margin-top: 80px;
        border-top: 1px solid #3a3a3a;
    }

    .footer-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 24px;
    }

    .footer-content {
        display: grid;
        grid-template-columns: 2fr 1fr 1fr 1fr;
        gap: 48px;
        margin-bottom: 40px;
    }

    .footer-section h4 {
        color: #e5e5e5;
        margin-bottom: 20px;
        font-size: 15px;
        font-weight: 600;
    }

    .footer-section p,
    .footer-section a {
        color: #999;
        line-height: 2;
        text-decoration: none;
        display: block;
        transition: color 0.2s;
        font-size: 14px;
    }

    .footer-section a:hover {
        color: #667eea;
    }

    .footer-bottom {
        border-top: 1px solid #3a3a3a;
        padding-top: 28px;
        text-align: center;
        font-size: 13px;
        color: #777;
    }

    .footer-logo {
        margin-bottom: 12px;
    }

    .footer-logo img {
        height: 70px;
        object-fit: contain;
        object-position: left;
    }
</style>
