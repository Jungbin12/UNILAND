<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${guide.guideTitle} - UNILAND</title>
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
        .btn-back {
            padding: 9px 20px;
            background: white;
            color: #667eea;
            border: 1px solid #d0d0d0;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 20px 0;
        }

        .btn-back:hover {
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

        .post-category {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 16px;
        }

        .post-category.contract {
            background: #e0e7ff;
            color: #667eea;
        }

        .post-category.moving {
            background: #feebc8;
            color: #c05621;
        }

        .post-category.life {
            background: #c6f6d5;
            color: #22543d;
        }

        .post-category.area {
            background: #bee3f8;
            color: #2c5282;
        }

        .post-category.qna {
            background: #fed7d7;
            color: #c53030;
        }

        .post-title {
            font-size: 32px;
            font-weight: 700;
            color: #1a1a1a;
            line-height: 1.4;
            margin-bottom: 0; /* 마진을 부모 컨테이너로 이동 */
        }

        /* ✅ 제목과 버튼을 묶는 컨테이너 CSS 추가 */
        .post-title-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px; /* 기존 post-title의 마진 */
        }

        .post-author-actions {
            display: flex;
            gap: 10px;
            flex-shrink: 0; /* 버튼이 줄어들지 않도록 */
        }

        .btn-author-action {
            padding: 8px 14px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .btn-author-action.btn-edit {
            background-color: #f0f0f0;
            color: #333;
        }
        .btn-author-action.btn-edit:hover {
            background-color: #e0e0e0;
        }
        
        .btn-author-action.btn-delete {
            background-color: #fed7d7;
            color: #c53030;
        }
        .btn-author-action.btn-delete:hover {
            background-color: #fecaca;
        }

        .post-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 20px;
            border-top: 1px solid #e5e5e5;
        }

        .post-author-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .author-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
            font-weight: 700;
        }

        .author-details {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .author-name {
            font-size: 15px;
            font-weight: 600;
            color: #1a1a1a;
        }

        .post-date {
            font-size: 13px;
            color: #999;
        }

        .post-stats {
            display: flex;
            gap: 20px;
            font-size: 14px;
            color: #666;
        }

        .post-stats span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* 게시글 내용 */
        .post-content {
            padding-bottom: 0;
            margin-bottom: 0;
            white-space: pre-line; /* DB는 \n을 일반 공백 처리하기 때문에 개행 문제 시 */
        }

        .post-body {
            font-size: 16px;
            color: #333;
            line-height: 1.8;
        }

        .post-body h2 {
            font-size: 24px;
            font-weight: 700;
            color: #1a1a1a;
            margin: 40px 0 20px 0;
            padding-bottom: 12px;
            border-bottom: 2px solid #e5e5e5;
        }

        .post-body h3 {
            font-size: 20px;
            font-weight: 600;
            color: #1a1a1a;
            margin: 30px 0 15px 0;
        }

        .post-body p {
            margin-bottom: 20px;
        }

        .post-body ul,
        .post-body ol {
            margin: 20px 0;
            padding-left: 30px;
        }

        .post-body li {
            margin-bottom: 12px;
        }

        .post-body strong {
            color: #667eea;
            font-weight: 600;
        }

        .highlight-box {
            background: #f7fafc;
            border-left: 4px solid #667eea;
            padding: 20px;
            margin: 25px 0;
            border-radius: 8px;
        }

        .highlight-box p {
            margin-bottom: 0;
        }

        /* 액션 버튼 */
        .post-actions {
            padding: 30px 0;
            border-top: 2px solid #e5e5e5;
            border-bottom: 2px solid #e5e5e5;
            margin: 30px 0;
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .btn-action {
            padding: 12px 28px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-like {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-like:hover {
            background: #f7fafc;
        }

        .btn-like.active {
            background: #667eea;
            color: white;
        }

        .btn-share {
            background: white;
            color: #4a5568;
            border: 2px solid #e2e8f0;
        }

        .btn-share:hover {
            background: #f7fafc;
        }

        /* 댓글 섹션 */
        .comments-section {
            padding: 0;
            margin-bottom: 30px;
        }

        .comments-header {
            font-size: 20px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .comment-count {
            color: #667eea;
        }

        /* 댓글 작성 */
        .comment-form {
            margin-bottom: 30px;
            padding-bottom: 30px;
            border-bottom: 2px solid #e5e5e5;
        }

        .comment-textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            font-family: inherit;
            resize: vertical;
            min-height: 120px;
            transition: border-color 0.2s;
        }

        .comment-textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .comment-form-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 12px;
        }

        .comment-info {
            font-size: 13px;
            color: #999;
        }

        .btn-comment-submit {
            padding: 10px 24px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-comment-submit:hover {
            background: #5568d3;
        }

        /* 댓글 리스트 */
        .comment-list {
            list-style: none;
        }

        .comment-item {
            padding: 20px 0;
            border-bottom: 1px solid #e5e5e5;
        }

        .comment-item:last-child {
            border-bottom: none;
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .comment-author-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .comment-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 16px;
            font-weight: 700;
        }

        .comment-author {
            font-size: 14px;
            font-weight: 600;
            color: #1a1a1a;
        }

        .comment-date {
            font-size: 13px;
            color: #999;
            margin-left: 8px;
        }

        .comment-actions {
            display: flex;
            gap: 10px;
        }

        .btn-comment-action {
            background: none;
            border: none;
            color: #999;
            font-size: 13px;
            cursor: pointer;
            padding: 4px 8px;
            transition: color 0.2s;
        }

        .btn-comment-action:hover {
            color: #667eea;
        }

        /* 가이드 댓글 좋아요 버튼 활성화 스타일 */
        .btn-comment-action.guide-comment-like.liked {
            color: #667eea;
            font-weight: 600;
        }

        .btn-comment-action.guide-comment-like.liked i {
            color: #667eea;
        }

        .btn-comment-action.guide-comment-like:hover {
            color: #667eea;
        }

        .btn-comment-action.guide-comment-like i {
            transition: color 0.2s;
        }

        .comment-body {
            font-size: 14px;
            color: #333;
            line-height: 1.6;
            padding-left: 52px;
        }

        /* 이전/다음 글 */
        .post-navigation {
            padding: 30px 0 0 0;
            border-top: 2px solid #e5e5e5;
            margin-bottom: 0;
        }

        .nav-title {
            font-size: 16px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 20px;
        }

        .nav-item {
            padding: 15px 0;
            border-bottom: 1px solid #e5e5e5;
            cursor: pointer;
            transition: all 0.2s;
        }

        .nav-item:hover {
            color: #667eea;
            padding-left: 10px;
        }

        .nav-item:last-child {
            border-bottom: none;
        }

        .nav-label {
            font-size: 13px;
            color: #999;
            margin-bottom: 5px;
        }

        .nav-post-title {
            font-size: 15px;
            font-weight: 500;
            color: #1a1a1a;
        }

        .nav-item:hover .nav-post-title {
            color: #667eea;
        }

        /* 목록 버튼 */
        .btn-list {
            width: 100%;
            padding: 14px;
            background: white;
            color: #4a5568;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-list:hover {
            background: #f7fafc;
            border-color: #667eea;
            color: #667eea;
        }
        
        /* ✅ 댓글 수정 폼을 위한 스타일 추가 */
        .comment-edit-form textarea { margin-bottom: 8px; font-size: 14px; }
        .comment-edit-form button { font-size: 13px; }

        /* 반응형 */
        @media (max-width: 768px) {
            .post-container {
                padding: 24px;
            }

            /* ✅ 반응형 CSS 추가 */
            .post-title-container {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            .post-author-actions {
                width: 100%;
                justify-content: flex-end;
            }
            .post-title {
                font-size: 24px;
            }
            /* ✅ 반응형 CSS 끝 */


            .post-meta {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }

            .post-actions {
                padding: 20px;
            }

            .comment-body {
                padding-left: 0;
                margin-top: 10px;
            }
        }
        
        /* ✅ 공유하기 모달 CSS 추가 */
        .modal-overlay {
            display: none; /* 기본 숨김 */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal-overlay.show {
            display: flex;
        }

        .modal-content {
            background: white;
            padding: 24px 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            width: 90%;
            max-width: 500px;
            position: relative;
            animation: modal-fade-in 0.3s ease-out;
        }
        
        @keyframes modal-fade-in {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .modal-close {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 28px;
            font-weight: bold;
            color: #aaa;
            cursor: pointer;
            line-height: 1;
        }
        .modal-close:hover {
            color: #333;
        }

        .modal-content h3 {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 12px;
            text-align: center;
            color: #1a1a1a;
        }
        
        .modal-content p {
            font-size: 14px;
            color: #666;
            text-align: center;
            margin-bottom: 20px;
        }

        .share-url-container {
            display: flex;
            gap: 10px;
        }

        .share-url-container input[type="text"] {
            flex-grow: 1;
            padding: 10px 12px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            background: #f7fafc;
            color: #333;
        }
        
        .share-url-container input[type="text"]:focus {
            outline: none;
            border-color: #667eea;
        }

        .share-url-container button {
            padding: 10px 20px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            flex-shrink: 0; /* 버튼 크기 고정 */
        }
        
        .share-url-container button:hover {
            background: #5a6dcb;
        }
        
        .share-url-container button:disabled {
            background: #c6f6d5;
            color: #22543d;
            cursor: default;
        }
        /* ✅ 공유하기 모달 CSS 끝 */
    </style>
</head>
<body>
	<!-- 헤더 포함 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>

	<!-- 메인 컨테이너 -->
	<div class="main-container">
		<!-- 뒤로가기 버튼 -->
		<button class="btn-back" onclick="location.href='${pageContext.request.contextPath}/community/guide'">
            <i class="fa-solid fa-arrow-left"></i> 목록으로
        </button>

		<!-- 게시글 컨테이너 -->
		<div class="post-container">
			<!-- 게시글 헤더 -->
			<div class="post-header">
		    <c:choose>
		        <c:when test="${guide.guideCategory eq 'contract'}">
		            <span class="post-category contract">
		                <i class="fa-solid fa-file-contract"></i> 계약 팁
		            </span>
		        </c:when>
		        <c:when test="${guide.guideCategory eq 'moving'}">
		            <span class="post-category moving">
		                <i class="fa-solid fa-truck-moving"></i> 이사 팁
		            </span>
		        </c:when>
		        <c:when test="${guide.guideCategory eq 'life'}">
		            <span class="post-category life">
		                <i class="fa-solid fa-house-user"></i> 생활 팁
		            </span>
		        </c:when>
		        <c:when test="${guide.guideCategory eq 'area'}">
		            <span class="post-category area">
		                <i class="fa-solid fa-map-location-dot"></i> 동네 정보
		            </span>
		        </c:when>
		        <c:when test="${guide.guideCategory eq 'qna'}">
		            <span class="post-category qna">
		                <i class="fa-solid fa-question-circle"></i> 질문/답변
		            </span>
		        </c:when>
		        <c:otherwise>
		            <span class="post-category contract">
		                <i class="fa-solid fa-file-contract"></i> ${guide.categoryName}
		            </span>
		        </c:otherwise>
		    </c:choose>

            <div class="post-title-container">
		        <h1 class="post-title">${guide.guideTitle}</h1>

                <c:if test="${sessionScope.loginUser.userId == guide.userId}">
                    <div class="post-author-actions">
                        <button class="btn-author-action btn-edit" 
                                onclick="location.href='${pageContext.request.contextPath}/community/guide/edit/${guide.guideNo}'">
                            <i class="fa-solid fa-pen"></i> 수정
                        </button>
                        <button class="btn-author-action btn-delete" onclick="deletePost()">
                            <i class="fa-solid fa-trash"></i> 삭제
                        </button>
                    </div>
                </c:if>
            </div>
            <div class="post-meta">
		        <div class="post-author-info">
		            <div class="author-avatar">
		                ${guide.userId.substring(0, 1)}
		            </div>
		            <div class="author-details">
		                <span class="author-name">
		                    ${guide.userId}
		                </span>
		                <span class="post-date">
		                    <fmt:formatDate value="${guide.writeDate}" pattern="yyyy.MM.dd"/>
		                </span>
		            </div>
		        </div>
		        <div class="post-stats">
		            <span><i class="fa-solid fa-eye"></i> ${guide.viewCount}</span>
		            <span><i class="fa-solid fa-heart"></i> ${likeCount}</span>
		            <span><i class="fa-solid fa-comment"></i> ${guide.commentCount}</span>
		        </div>
		    </div>
			</div>

			<!-- 게시글 내용 -->
			<!-- white-space: pre-line을 사용하면 JSP 소스 코드에 있는 줄바꿈까지 그대로 화면에 나오기 때문에
					개행을 없애려면 JSP 소스 코드에서 태그들을 모두 한 줄로 붙여 써야 함 -->
			<div class="post-content"><div class="post-body">${guide.guideContent}</div></div>

			<!-- 좋아요,공유하기 액션 버튼 -->
			<div class="post-actions">
            <button class="btn-action btn-like ${isLiked ? 'active' : ''}" onclick="toggleLike()">
                <i class="${isLiked ? 'fa-solid' : 'fa-regular'} fa-heart"></i>
                <span id="likeText">좋아요 (${likeCount})</span>
            </button>
            <button class="btn-action btn-share" onclick="sharePost()">
                <i class="fa-solid fa-share-nodes"></i>
                공유하기
            </button>
			</div>

			<!-- 댓글 섹션 -->
			<div class="comments-section">
            <h3 class="comments-header">
                <i class="fa-solid fa-comments"></i>
                댓글 <span class="comment-count">${guide.commentCount}</span>
            </h3>
            
			<!-- 댓글 작성 -->
			<div class="comment-form">
                <form action="${pageContext.request.contextPath}/community/guide/${guide.guideNo}/comment" method="post">
                    <textarea class="comment-textarea" name="content" placeholder="댓글을 입력하세요..." id="commentInput"></textarea>
                    <div class="comment-form-footer">
                        <span class="comment-info">
                            <c:choose>
                                <c:when test="${not empty sessionScope.loginUser}">
                                    ${sessionScope.loginUser.userId}님으로 댓글 작성
                                </c:when>
                                <c:otherwise>
                                    로그인 후 댓글을 작성할 수 있습니다.
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <button type="submit" class="btn-comment-submit" onclick="return submitComment()">
                            댓글 등록
                        </button>
                    </div>
                </form>
            </div>

			<!-- 댓글 리스트 -->
			<ul class="comment-list">
                <c:choose>
                    <c:when test="${not empty comments}">
                        <c:forEach var="comment" items="${comments}">
                            
                            <%-- ✅ 각 댓글 항목에 고유 ID 추가 --%>
                            <li class="comment-item" id="comment-item-${comment.commentId}">                   
                            
                                <div class="comment-header">
                                    <div class="comment-author-info">
                                        <div class="comment-avatar">${comment.userId.substring(0, 1)}</div>
                                        <div>
                                            <span class="comment-author">${comment.userId}</span>
                                            <span class="comment-date"><fmt:formatDate value="${comment.createdAt}" pattern="yyyy.MM.dd HH:mm"/></span>
                                        </div>
                                    </div>
                                    <%-- ✅ 댓글 액션 버튼 영역 ID 추가 --%>
                                    <div class="comment-actions" id="comment-actions-${comment.commentId}">
										<button class="btn-comment-action guide-comment-like ${comment.liked ? 'liked' : ''}" data-comment-id="${comment.commentId}" onclick="toggleGuideCommentLike(event)"><i class="${comment.liked ? 'fa-solid' : 'fa-regular'} fa-heart"></i> 좋아요 <span class="guide-comment-like-count" data-comment-id="${comment.commentId}">(${comment.likeCount})</span></button>
                                        <c:if test="${sessionScope.loginUser.userId == comment.userId}">
                                            <%-- ✅ 이 버튼은 이제 ${escapedContent} 변수를 올바르게 참조합니다. --%>
							                <button class="btn-comment-action btn-edit-comment" onclick="showEditForm(${comment.commentId})">수정</button>
							                <button class="btn-comment-action btn-delete-comment" onclick="deleteComment(${comment.commentId})">삭제</button>
                                        </c:if>
                                    </div>
                                </div>
                                <%-- ✅ 기존 댓글 내용 영역 ID 부여 --%>
                                <div class="comment-body" id="comment-content-${comment.commentId}" style="white-space: pre-line;"><c:out value="${comment.content}"/></div>

                                <%-- ✅ 숨겨진 수정 폼 영역 추가 --%>
                                <div class="comment-edit-form" id="comment-edit-form-${comment.commentId}" style="display: none; padding-left: 52px; margin-top: 10px;">
                                    <textarea id="comment-edit-textarea-${comment.commentId}" class="comment-textarea" style="min-height: 80px;"></textarea>
                                    <div style="text-align: right; margin-top: 8px;">
                                        <button class="btn-comment-action" style="color: #667eea; font-weight: 600;" onclick="saveCommentEdit(${comment.commentId})">저장</button>
                                        <button class="btn-comment-action" onclick="hideEditForm(${comment.commentId})">취소</button>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <li style="text-align: center; padding: 40px 0; color: #999;">첫 번째 댓글을 작성해보세요!</li>
                    </c:otherwise>
                </c:choose>
            </ul>
			</div>

			<!-- 이전/다음 글 -->
			<c:if test="${not empty prevGuide || not empty nextGuide}">
            <div class="post-navigation">
                <h3 class="nav-title">다른 글 보기</h3>
                <c:if test="${not empty nextGuide}">
                    <div class="nav-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/${nextGuide.guideNo}'">
                        <div class="nav-label">
                            <i class="fa-solid fa-chevron-up"></i> 다음 글
                        </div>
                        <div class="nav-post-title">${nextGuide.guideTitle}</div>
                    </div>
                </c:if>
                <c:if test="${not empty prevGuide}">
                    <div class="nav-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/${prevGuide.guideNo}'">
                        <div class="nav-label">
                            <i class="fa-solid fa-chevron-down"></i> 이전 글
                        </div>
                        <div class="nav-post-title">${prevGuide.guideTitle}</div>
                    </div>
                </c:if>
            </div>
			</c:if>
		</div>

		<!-- 목록 버튼 -->
		<button class="btn-list" onclick="location.href='${pageContext.request.contextPath}/community/guide'">
            <i class="fa-solid fa-list"></i> 목록으로 돌아가기
        </button>
    </div>

    <div id="shareModal" class="modal-overlay">
        <div class="modal-content">
            <span class="modal-close">&times;</span>
            <h3>링크 공유하기</h3>
            <p>이 링크를 복사해서 공유하세요.</p>
            <div class="share-url-container">
                <input type="text" id="shareUrlInput" value="" readonly>
                <button id="copyUrlButton">복사</button>
            </div>
        </div>
    </div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

    <script>
        // 좋아요 토글
        let isLiked = ${isLiked};
        let likeCount = ${likeCount};

        function toggleLike() {
            const isLoggedIn = ${not empty sessionScope.loginUser};

            if (!isLoggedIn) {
                if (confirm('로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?')) {
                    window.location.href = '${pageContext.request.contextPath}/auth/login';
                }
                return;
            }

            const btn = document.querySelector('.btn-like');
            const icon = btn.querySelector('i');
            const text = document.getElementById('likeText');

			// AJAX로 좋아요 처리
            fetch('${pageContext.request.contextPath}/community/guide/${guide.guideNo}/like', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    isLiked = data.isLiked;
                    likeCount = data.likeCount;

                    if (isLiked) {
                        icon.className = 'fa-solid fa-heart';
                        btn.classList.add('active');
                    } else {
                        icon.className = 'fa-regular fa-heart';
                        btn.classList.remove('active');
                    }
                    text.textContent = '좋아요 (' + likeCount + ')';
                    
					// 상단 post-stats의 좋아요 수 실시간 업데이트
                    const statsHeart = document.querySelector('.post-stats span:nth-child(2)');
                    if (statsHeart) {
                        statsHeart.innerHTML = '<i class="fa-solid fa-heart"></i> ' + likeCount;
                    }
                }
            })
            .catch(err => console.error('좋아요 처리 실패:', err));
        }

        // ✅ 수정된 가이드 댓글 좋아요 토글 함수
        function toggleGuideCommentLike(event) {
            const isLoggedIn = ${not empty sessionScope.loginUser};
            
            if (!isLoggedIn) {
                if (confirm('로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?')) {
                    window.location.href = '${pageContext.request.contextPath}/auth/login';
                }
                return;
            }
            
            // 버튼에서 commentId 가져오기
            const btn = event.target.closest('.btn-comment-action');
            const commentId = btn.getAttribute('data-comment-id');
            
            // commentId 검증
            if (!commentId || commentId === 'undefined' || commentId === 'null') {
                console.error('commentId가 유효하지 않습니다:', commentId);
                alert('댓글 정보를 찾을 수 없습니다.');
                return;
            }
            
            fetch('${pageContext.request.contextPath}/community/guide/comment/' + commentId + '/like', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // 좋아요 수 업데이트
                    const likeCountSpan = document.querySelector('.guide-comment-like-count[data-comment-id="' + commentId + '"]');
                    if (likeCountSpan) {
                        likeCountSpan.textContent = '(' + data.likeCount + ')';
                    }
                    
                    // 버튼 스타일 변경
                    const icon = btn.querySelector('i');
                    
                    if (data.isLiked) {
                        icon.className = 'fa-solid fa-heart';
                        btn.classList.add('liked');
                    } else {
                        icon.className = 'fa-regular fa-heart';
                        btn.classList.remove('liked');
                    }
                } else {
                    alert(data.message || '가이드 댓글 좋아요 처리에 실패했습니다.');
                }
            })
            .catch(err => {
                console.error('가이드 댓글 좋아요 처리 실패:', err);
                alert('가이드 댓글 좋아요 처리 중 오류가 발생했습니다.');
            });
        }

        // ✅ 공유하기 함수를 새 모달창을 띄우는 코드로 교체
        // 공유하기
        function sharePost() {
            const url = window.location.href;
            
            // 1. 모달 안의 input에 URL 설정
            const urlInput = document.getElementById('shareUrlInput');
            urlInput.value = url;
            
            // 2. 모달 보이기
            document.getElementById('shareModal').classList.add('show');
            
            // 3. 버튼 텍스트 초기화
            const copyBtn = document.getElementById('copyUrlButton');
            copyBtn.textContent = '복사';
            copyBtn.disabled = false;
        }

        // ✅ 공유 모달을 위한 새 함수 2개 추가
        // 모달 닫기
        function closeShareModal() {
            document.getElementById('shareModal').classList.remove('show');
        }

        // 모달 안의 '복사' 버튼 클릭 시
        function copyUrlFromModal() {
            const urlInput = document.getElementById('shareUrlInput');
            const copyBtn = document.getElementById('copyUrlButton');

            // input의 텍스트를 클립보드로 복사
            navigator.clipboard.writeText(urlInput.value).then(() => {
                // 성공 피드백
                copyBtn.textContent = '복사 완료!';
                copyBtn.disabled = true;

            }).catch(err => {
                console.error('URL 복사 실패:', err);
                alert('URL 복사에 실패했습니다.');
            });
        }


        // 댓글 작성
        function submitComment() {
            const isLoggedIn = ${not empty sessionScope.loginUser};
            const commentInput = document.getElementById('commentInput');

            if (!isLoggedIn) {
                if (confirm('로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?')) {
                    window.location.href = '${pageContext.request.contextPath}/auth/login';
                }
                return false;
            }

            const content = commentInput.value.trim();

            if (content === '') {
                alert('댓글 내용을 입력해주세요.');
                commentInput.focus();
                return false;
            }

            return true;
        }

        // 댓글 삭제
        function deleteComment(commentId) {
            if (!confirm('댓글을 삭제하시겠습니까?')) {
                return;
            }

            fetch('${pageContext.request.contextPath}/community/guide/${guide.guideNo}/comment/' + commentId, {
                method: 'DELETE'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('댓글이 삭제되었습니다.');
                    
					// 댓글 수 실시간 업데이트
                    const commentCountElem = document.querySelector('.comment-count');
                    const statsComment = document.querySelector('.post-stats span:nth-child(3)');
                    if (commentCountElem && statsComment) {
                        let currentCount = parseInt(commentCountElem.textContent);
                        commentCountElem.textContent = currentCount - 1;
                        statsComment.innerHTML = '<i class="fa-solid fa-comment"></i> ' + (currentCount - 1);
                    }
                    
                    location.reload();
                } else {
                    alert('댓글 삭제에 실패했습니다.');
                }
            })
            .catch(err => console.error('댓글 삭제 실패:', err));
        }

        // ✅ 게시글 삭제 함수 추가
        function deletePost() {
            if (!confirm('게시글을 정말 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.')) {
                return;
            }

            fetch('${pageContext.request.contextPath}/community/guide/${guide.guideNo}', {
                method: 'DELETE'
            })
            .then(response => response.json()) // 서버에서 { "success": true } 형태의 응답을 기대
            .then(data => {
                if (data.success) {
                    alert('게시글이 삭제되었습니다.');
                    // 성공 시 목록 페이지로 리디렉션
                    location.href = '${pageContext.request.contextPath}/community/guide';
                } else {
                    alert(data.message || '게시글 삭제에 실패했습니다.');
                }
            })
            .catch(err => {
                console.error('게시글 삭제 실패:', err);
                alert('게시글 삭제 처리 중 오류가 발생했습니다.');
            });
        }

        // ✅ 댓글 수정 폼 보이기
        function showEditForm(commentId) {
            // 기존 댓글 내용 숨기기
            document.getElementById('comment-content-' + commentId).style.display = 'none';
            // 댓글 액션 버튼 숨기기
            document.getElementById('comment-actions-' + commentId).style.display = 'none';
            
            // 수정 폼 보이기
            const editForm = document.getElementById('comment-edit-form-' + commentId);
            editForm.style.display = 'block';
            
            // textarea에 기존 내용 채우기
            const originalContent = document.getElementById('comment-content-' + commentId).textContent;
            const textarea = document.getElementById('comment-edit-textarea-' + commentId);
            textarea.value = originalContent;
            textarea.focus();
        }

        // ✅ 댓글 수정 폼 숨기기 (취소)
        function hideEditForm(commentId) {
            // 기존 댓글 내용 다시 보이기
            document.getElementById('comment-content-' + commentId).style.display = 'block';
            // 댓글 액션 버튼 다시 보이기
            document.getElementById('comment-actions-' + commentId).style.display = 'flex';
            
            // 수정 폼 숨기기
            document.getElementById('comment-edit-form-' + commentId).style.display = 'none';
        }

        // ✅ 댓글 수정 저장
        function saveCommentEdit(commentId) {
            const textarea = document.getElementById('comment-edit-textarea-' + commentId);
            const newContent = textarea.value.trim();

            if (newContent === '') {
                alert('댓글 내용을 입력해주세요.');
                textarea.focus();
                return;
            }

            fetch('${pageContext.request.contextPath}/community/guide/${guide.guideNo}/comment/' + commentId, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ content: newContent })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('댓글이 수정되었습니다.');
                    
                    // 화면 업데이트
                    const contentDiv = document.getElementById('comment-content-' + commentId);
                    contentDiv.textContent = newContent;
                    
                    // 수정 폼 숨기고 원래 댓글 보이기
                    hideEditForm(commentId);
                } else {
                    alert(data.message || '댓글 수정에 실패했습니다.');
                }
            })
            .catch(err => {
                console.error('댓글 수정 실패:', err);
                alert('댓글 수정 처리 중 오류가 발생했습니다.');
            });
        }

        // 엔터키로 댓글 작성 (Shift + Enter는 줄바꿈)
        document.getElementById('commentInput').addEventListener('keydown', function(e) {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                if (submitComment()) {
                    document.querySelector('.comment-form form').submit();
                }
            }
        });
        
        // ✅ 공유 모달 이벤트 리스너 추가
        const modal = document.getElementById('shareModal');
        const closeBtn = document.querySelector('.modal-close');
        const copyBtn = document.getElementById('copyUrlButton');

        // 'X' 버튼 클릭 시 닫기
        closeBtn.addEventListener('click', closeShareModal);
        
        // '복사' 버튼 클릭 시 복사
        copyBtn.addEventListener('click', copyUrlFromModal);

        // 모달 배경 클릭 시 닫기
        modal.addEventListener('click', function(e) {
            // 클릭된 요소가 modal-overlay 자신일 때만 닫기
            if (e.target === modal) {
                closeShareModal();
            }
        });

    </script>
</body>
</html>