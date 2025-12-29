<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>${pageTitle != null ? pageTitle : 'UNILAND 관리자 페이지'}</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
      background-color: #f5f5f5;
      color: #1a1a1a;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    /* 헤더 */
    header {
      background: white;
      border-bottom: 1px solid #e5e5e5;
      padding: 18px 0;
      position: sticky;
      top: 0;
      z-index: 200;
    }
    .header-container {
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 24px;
    }
    .logo img {
      height: 60px;
      object-fit: contain;
      object-position: center;
      cursor: pointer;
    }

    .auth-buttons {
      display: flex;
      gap: 12px;
    }

    .auth-buttons span, .auth-buttons button {
      padding: 9px 20px;
      background: none;
      border: none;
      border-radius: 3px;
      cursor: pointer;
      font-size: 14px;
      font-weight: 500;
      transition: all 0.2s;
      display: inline-flex;
      align-items: center;
      gap: 6px;
      color: #555;
    }

    .auth-buttons span:hover, .auth-buttons button:hover {
      color: #667eea;
      background: #f5f5f5;
    }

    .admin-name {
      color: #667eea;
    }

    .btn-logout {
      color: #f56565;
    }

    .btn-logout:hover {
      color: #e53e3e;
      background: #fee;
    }

    /* 레이아웃 */
    .admin-container { flex: 1; display: flex; }

    /* 사이드바 */
    .sidebar {
      width: 240px;
      background: #ffffff;
      border-right: 1px solid #e5e5e5;
      padding: 24px 0;
      position: fixed;
      top: 96px;
      left: 0;
      height: calc(100vh - 96px);
      overflow-y: auto;
      z-index: 100;
    }
    .sidebar h3 {
      text-align: center;
      color: #667eea;
      margin-bottom: 20px;
      font-size: 18px;
      font-weight: 700;
    }
    .sidebar ul { list-style: none; }
    .sidebar li {
      padding: 14px 24px;
      color: #333;
      font-weight: 500;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 10px;
      transition: all 0.2s;
    }
    .sidebar li:hover { background: #f0f2ff; color: #667eea; }
    .sidebar li.active { background: #e6e8ff; color: #5568d3; font-weight: 600; }

    /* 메인 콘텐츠 */
    .main-content {
      flex: 1;
      margin-left: 240px;
      padding: 32px;
      overflow-y: auto;
    }
  </style>
</head>

<body>
  <!-- 헤더 -->
  <header>
    <div class="header-container">
      <div class="logo">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="UNILAND 관리자">
      </div>
      <div class="auth-buttons">
        <c:if test="${not empty sessionScope.loginUser}">
          <span class="admin-name"><i class="fa-solid fa-user-shield"></i> ${loginUser.userName}님</span>
          <button class="btn-logout" onclick="logout()">
            <i class="fa-solid fa-right-from-bracket"></i> 로그아웃
          </button>
        </c:if>
      </div>
    </div>
  </header>

  <!-- 메인 -->
  <div class="admin-container">
    <!-- 사이드바 -->
    <aside class="sidebar">
      <h3>관리 메뉴</h3>
      <ul>
        <li class="${currentPage == 'dashboard' ? 'active' : ''}"><i class="fa-solid fa-chart-line"></i> 대시보드</li>
        <li class="${currentPage == 'user-management' ? 'active' : ''}"><i class="fa-solid fa-users"></i> 회원관리</li>
        <li class="${currentPage == 'property-management' ? 'active' : ''}"><i class="fa-solid fa-building"></i> 매물관리</li>
        <li class="${currentPage == 'content-management' ? 'active' : ''}"><i class="fa-solid fa-bullhorn"></i> 공지사항관리</li>
        <li class="${currentPage == 'inquiry-management' ? 'active' : ''}"><i class="fa-solid fa-envelope"></i> 문의관리</li>
        <li class="${currentPage == 'realtor-approval' ? 'active' : ''}"><i class="fa-solid fa-user-check"></i> 중개사 승인</li>
      </ul>
    </aside>

    <!-- 메인 콘텐츠 시작 -->
    <main class="main-content">
