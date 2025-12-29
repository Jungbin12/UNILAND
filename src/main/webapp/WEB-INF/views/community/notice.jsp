<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 - UNILAND</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 기본 스타일 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            color: #1a1a1a;
            background-color: #f5f5f5;
            line-height: 1.6;
        }

        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 24px;
        }

        .page-header {
            text-align: center;
            margin-bottom: 50px;
        }

        .page-title {
            font-size: 36px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 12px;
        }

        .page-subtitle {
            font-size: 16px;
            color: #666;
        }

        .content-wrapper {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            padding: 30px;
        }


        .controls {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e5e5e5;
        }

        .btn-write {
            padding: 12px 24px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-write:hover {
            background: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(102, 126, 234, 0.3);
        }

        .alert {
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-size: 14px;
        }

        .alert-error {
            background: #ffe8e8;
            color: #f56565;
            border: 1px solid #f56565;
        }

        .alert-success {
            background: #e8f5e9;
            color: #48bb78;
            border: 1px solid #48bb78;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table thead {
            background: #f7fafc;
            border-bottom: 2px solid #e5e5e5;
        }

        table th, table td {
            padding: 16px;
            text-align: center;
            border-bottom: 1px solid #e5e5e5;
        }

        table th {
            font-weight: 600;
            color: #4a5568;
            font-size: 14px;
        }

        table td {
            color: #2d3748;
            font-size: 14px;
        }

        table tbody tr {
            cursor: pointer;
            transition: all 0.2s;
        }

        table tbody tr:hover {
            background: #f7fafc;
        }

        .notice-title {
            text-align: left !important;
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 500;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
            white-space: nowrap;
        }

        .badge-important {
            background: #fed7d7;
            color: #c53030;
        }

        .badge-new {
            background: #c6f6d5;
            color: #22543d;
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
        }

        .empty-icon {
            font-size: 80px;
            margin-bottom: 20px;
            opacity: 0.3;
        }

        .empty-state h3 {
            font-size: 24px;
            color: #2d3748;
            margin-bottom: 10px;
        }

        .empty-state p {
            color: #718096;
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 28px;
            }

            table th, table td {
                padding: 12px 8px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="main-container">
        <div class="page-header">
            <h1 class="page-title"><i class="fa-solid fa-bullhorn" style="color: #1a1a1a;"></i> 공지사항</h1>
            <p class="page-subtitle">UNILAND의 새로운 소식과 중요한 공지를 확인하세요</p>
        </div>

        <div class="content-wrapper">

            <!-- 에러 메시지 -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fa-solid fa-circle-exclamation"></i> ${error}
                </div>
            </c:if>

            <!-- 성공 메시지 -->
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    <i class="fa-solid fa-circle-check"></i> ${message}
                </div>
            </c:if>

            <!-- 상단 컨트롤 -->
            <c:if test="${not empty sessionScope.loginUser && (sessionScope.loginUser.userId == 'admin')}">
                <div class="controls">
                    <a href="${pageContext.request.contextPath}/community/notice-write" class="btn-write">
                        <i class="fa-solid fa-pencil"></i> 공지사항 작성
                    </a>
                </div>
            </c:if>

            <!-- 공지사항 목록 -->
            <c:choose>
                <c:when test="${not empty noticeList}">
                    <table>
                        <thead>
                            <tr>
                                <th style="width: 10%">번호</th>
                                <th style="width: 50%">제목</th>
                                <th style="width: 15%">작성자</th>
                                <th style="width: 10%">조회수</th>
                                <th style="width: 15%">작성일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="notice" items="${noticeList}">
                                <tr onclick="location.href='${pageContext.request.contextPath}/community/notice/${notice.noticeNo}'">
                                    <td>${notice.noticeNo}</td>
                                    <td class="notice-title">
                                        <div style="display: flex; align-items: center; gap: 8px;">
                                            <c:if test="${notice.noticeImportant == 'Y'}">
                                                <span class="badge badge-important">
                                                    <i class="fa-solid fa-exclamation"></i> 중요
                                                </span>
                                            </c:if>
                                            <c:if test="${notice.noticeIsnew == 'Y'}">
                                                <span class="badge badge-new">
                                                    <i class="fa-solid fa-star"></i> NEW
                                                </span>
                                            </c:if>
                                            <span>${notice.noticeSubject}</span>
                                        </div>
                                    </td>
                                    <td>${notice.noticeWriter}</td>
                                    <td><i class="fa-solid fa-eye" style="color: #999; margin-right: 4px;"></i>${notice.viewCount}</td>
                                    <td><fmt:formatDate value="${notice.noticeCreateat}" pattern="yyyy-MM-dd"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-icon">📢</div>
                        <h3>등록된 공지사항이 없습니다</h3>
                        <p>새로운 공지사항을 기다려주세요!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>