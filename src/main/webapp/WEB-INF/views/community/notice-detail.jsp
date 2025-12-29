<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${notice.noticeSubject} - UNILAND</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            color: #1a1a1a;
            background-color: #f5f5f5;
            line-height: 1.8;
        }

        /* 뒤로가기 버튼 */
        .btn-back-top {
            padding: 9px 20px;
            background: white;
            color: #667eea;
            border: 1px solid #d0d0d0;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin: 20px 0;
            text-decoration: none;
        }

        .btn-back-top:hover {
            background: #f7fafc;
            border-color: #667eea;
        }

        /* 메인 컨테이너 */
        .main-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 24px;
        }

        /* 게시글 컨테이너 */
        .post-container {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-bottom: 20px;
        }

        /* 게시글 헤더 */
        .post-header {
            padding-bottom: 30px;
            border-bottom: 2px solid #e5e5e5;
            margin-bottom: 30px;
        }

        .badge-container {
            display: flex;
            gap: 8px;
            margin-bottom: 16px;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-important {
            background: #fed7d7;
            color: #c53030;
        }

        .badge-new {
            background: #c6f6d5;
            color: #22543d;
        }

        .post-title {
            font-size: 32px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 24px;
            line-height: 1.4;
        }

        .post-meta {
            display: flex;
            gap: 24px;
            padding-top: 20px;
            border-top: 1px solid #e5e5e5;
            font-size: 14px;
            color: #666;
        }

        .post-meta span {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .post-meta i {
            color: #999;
        }

        /* 게시글 본문 */
        .post-content {
            padding-bottom: 30px;
            margin-bottom: 30px;
        }

        .content-body {
            font-size: 16px;
            line-height: 1.8;
            color: #333;
            white-space: pre-line;
            min-height: 200px;
        }

        /* 버튼 영역 */
        .action-buttons {
            padding-top: 30px;
            border-top: 2px solid #e5e5e5;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            border: none;
        }

        .btn-list {
            background: #f0f0f0;
            color: #333;
        }

        .btn-list:hover {
            background: #e0e0e0;
        }

        .btn-admin {
            background: #718096;
            color: white;
        }

        .btn-admin:hover {
            background: #4a5568;
        }

        .btn-edit {
            background: #667eea;
            color: white;
        }

        .btn-edit:hover {
            background: #5568d3;
        }

        .btn-delete {
            background: #f56565;
            color: white;
        }

        .btn-delete:hover {
            background: #e53e3e;
        }

        .left-buttons, .right-buttons {
            display: flex;
            gap: 10px;
        }

        /* 알림 메시지 */
        .alert {
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 10px;
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

        @media (max-width: 768px) {
            .post-container {
                padding: 24px;
            }

            .post-title {
                font-size: 24px;
            }

            .post-meta {
                flex-direction: column;
                gap: 12px;
            }

            .action-buttons {
                flex-direction: column;
                gap: 12px;
            }

            .left-buttons, .right-buttons {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="main-container">
        <!-- 뒤로가기 버튼 -->
        <a href="${pageContext.request.contextPath}/community/notice" class="btn-back-top">
            <i class="fa-solid fa-arrow-left"></i> 공지사항 목록
        </a>

        <!-- 메시지 출력 -->
        <c:if test="${not empty message}">
            <div class="alert alert-success">
                <i class="fa-solid fa-circle-check"></i>
                ${message}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fa-solid fa-circle-exclamation"></i>
                ${error}
            </div>
        </c:if>

        <!-- 게시글 컨테이너 -->
        <div class="post-container">
            <!-- 게시글 헤더 -->
            <div class="post-header">
                <div class="badge-container">
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
                </div>

                <h1 class="post-title">${notice.noticeSubject}</h1>

                <div class="post-meta">
                    <span>
                        <i class="fa-solid fa-user"></i>
                        ${notice.noticeWriter}
                    </span>
                    <span>
                        <i class="fa-solid fa-calendar"></i>
                        <fmt:formatDate value="${notice.noticeCreateat}" pattern="yyyy.MM.dd HH:mm"/>
                    </span>
                    <span>
                        <i class="fa-solid fa-eye"></i>
                        ${notice.viewCount}
                    </span>
                </div>
            </div>

            <!-- 게시글 본문 -->
            <div class="post-content">
                <div class="content-body">
                    ${notice.noticeContent}
                </div>
            </div>

            <!-- 버튼 영역 -->
            <div class="action-buttons">
                <div class="left-buttons">
                    <a href="${pageContext.request.contextPath}/community/notice" class="btn btn-list">
                        <i class="fa-solid fa-list"></i> 목록으로
                    </a>
                    <c:if test="${not empty sessionScope.loginUser && (sessionScope.loginUser.userId == 'admin')}">
                        <a href="${pageContext.request.contextPath}/admin/content-management" class="btn btn-admin">
                            <i class="fa-solid fa-gear"></i> 관리자 페이지
                        </a>
                    </c:if>
                </div>

                <c:if test="${not empty sessionScope.loginUser && (sessionScope.loginUser.userId == 'admin')}">
                    <div class="right-buttons">
                        <a href="${pageContext.request.contextPath}/community/notice-update/${notice.noticeNo}" class="btn btn-edit">
                            <i class="fa-solid fa-pen"></i> 수정
                        </a>
                        <form action="${pageContext.request.contextPath}/community/notice/delete/${notice.noticeNo}" method="post" style="display:inline;">
                            <button type="submit" class="btn btn-delete" onclick="return confirm('정말 삭제하시겠습니까?')">
                                <i class="fa-solid fa-trash"></i> 삭제
                            </button>
                        </form>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
