<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자취 가이드 - UNILAND</title>
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

        .category-tabs {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-bottom: 30px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .category-tab {
            padding: 12px 24px;
            border: 2px solid #e5e7eb;
            background: white;
            color: #6b7280;
            border-radius: 12px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .category-tab:hover {
            border-color: #667eea;
            color: #667eea;
            background: #f9fafb;
            transform: translateY(-1px);
        }

        .category-tab.active {
            background: #667eea;
            color: white;
            border-color: #667eea;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.25);
        }

        .content-wrapper {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            padding: 30px;
        }

        .controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e5e5e5;
        }

        .search-box {
            display: flex;
            gap: 10px;
            flex: 1;
            max-width: 500px;
        }

        .search-input {
            flex: 1;
            padding: 12px 18px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.2s;
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
        }

        .btn-search {
            padding: 12px 24px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-search:hover {
            background: #5568d3;
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
        }

        .btn-write:hover {
            background: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(102, 126, 234, 0.3);
        }

        .post-list {
            list-style: none;
        }

        .post-item {
            padding: 24px 0;
            border-bottom: 1px solid #e5e5e5;
            cursor: pointer;
            transition: background 0.2s;
        }

        .post-item:hover {
            background: #f7fafc;
            margin: 0 -30px;
            padding: 24px 30px;
        }

        .post-item:last-child {
            border-bottom: none;
        }

        .post-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 12px;
        }

        .post-left {
            flex: 1;
        }

        .post-category {
            display: inline-block;
            background: #e0e7ff;
            color: #667eea;
            padding: 4px 12px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 8px;
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
            font-size: 18px;
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 8px;
            line-height: 1.4;
        }

        .post-title:hover {
            color: #667eea;
        }

        .post-preview {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .post-meta {
            display: flex;
            gap: 20px;
            margin-top: 12px;
            font-size: 13px;
            color: #999;
        }

        .post-meta span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .post-badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            background: #fff5f5;
            color: #f56565;
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            margin-left: 8px;
        }

        .post-badge.hot {
            background: #fed7d7;
            color: #c53030;
        }

        .popular-section {
            background: #f7fafc;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }

        .popular-title {
            font-size: 16px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .popular-list {
            list-style: none;
        }

        .popular-item {
            padding: 12px 0;
            border-bottom: 1px solid #e2e8f0;
            cursor: pointer;
            transition: all 0.2s;
        }

        .popular-item:hover {
            color: #667eea;
        }

        .popular-item:last-child {
            border-bottom: none;
        }

        .popular-number {
            display: inline-block;
            width: 28px;
            height: 28px;
            background: #667eea;
            color: white;
            border-radius: 8px;
            text-align: center;
            line-height: 28px;
            font-size: 13px;
            font-weight: 700;
            margin-right: 12px;
        }

        .popular-item-title {
            font-size: 14px;
            font-weight: 500;
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
        
        /* [추가] 페이징 바 스타일 */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 40px;
            gap: 8px;
        }
        .page-link {
            display: block;
            padding: 8px 14px;
            border: 1px solid #e2e8f0;
            background: white;
            color: #4a5568;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            transition: all 0.2s;
        }
        .page-link:hover {
            border-color: #667eea;
            color: #667eea;
        }
        .page-link.active {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }


        @media (max-width: 768px) {
            .controls {
                flex-direction: column;
                gap: 15px;
            }

            .search-box {
                max-width: 100%;
            }

            .post-title {
                font-size: 16px;
            }

            .category-tabs {
                justify-content: flex-start;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="main-container">
        <div class="page-header">
            <h1 class="page-title"><i class="fa-solid fa-book-open" style="color: #1a1a1a;"></i> 자취 가이드</h1>
            <p class="page-subtitle">처음 자취하는 대학생을 위한 꿀팁 모음</p>
        </div>

        <!-- 인기글 섹션 -->
        <c:if test="${not empty popularGuides}">
        <div class="popular-section">
            <h3 class="popular-title">
                <i class="fa-solid fa-star" style="color: #fbbf24;"></i>
                인기 게시글 TOP 5
            </h3>
            <ul class="popular-list">
                <c:forEach var="popular" items="${popularGuides}" varStatus="status">
                <li class="popular-item"
                    onclick="location.href='${pageContext.request.contextPath}/community/guide/${popular.guideNo}'">
                    <span class="popular-number">${status.index + 1}</span>
                    <span class="popular-item-title">${popular.guideTitle}</span>
                </li>
                </c:forEach>
            </ul>
        </div>
        </c:if>

        <!-- 카테고리 탭 -->
        <div class="category-tabs">
            <button class="category-tab ${empty category or category eq 'all' ? 'active' : ''}"
                    onclick="filterCategory('all')">
                <i class="fa-solid fa-grip"></i> 전체
            </button>
            <button class="category-tab ${category eq 'contract' ? 'active' : ''}"
                    onclick="filterCategory('contract')">
                <i class="fa-solid fa-file-signature"></i> 계약 팁
            </button>
            <button class="category-tab ${category eq 'moving' ? 'active' : ''}"
                    onclick="filterCategory('moving')">
                <i class="fa-solid fa-boxes-packing"></i> 이사 팁
            </button>
            <button class="category-tab ${category eq 'life' ? 'active' : ''}"
                    onclick="filterCategory('life')">
                <i class="fa-solid fa-lightbulb"></i> 생활 팁
            </button>
            <button class="category-tab ${category eq 'area' ? 'active' : ''}"
                    onclick="filterCategory('area')">
                <i class="fa-solid fa-location-dot"></i> 동네 정보
            </button>
            <button class="category-tab ${category eq 'qna' ? 'active' : ''}"
                    onclick="filterCategory('qna')">
                <i class="fa-solid fa-circle-question"></i> 질문/답변
            </button>
        </div>

        <div class="content-wrapper">
            <!-- 상단 컨트롤 -->
            <div class="controls">
                <form action="${pageContext.request.contextPath}/community/guide" method="get" class="search-box">
                    <c:if test="${not empty category and category ne 'all'}">
                        <input type="hidden" name="category" value="${category}">
                    </c:if>
                    <input type="text" name="keyword" class="search-input"
                           placeholder="검색어를 입력하세요" value="${keyword}">
                    <button type="submit" class="btn-search">
                        <i class="fa-solid fa-search"></i> 검색
                    </button>
                </form>
                <button class="btn-write" onclick="checkLoginAndWrite()">
                    <i class="fa-solid fa-pencil"></i> 글쓰기
                </button>
            </div>

            <!-- 게시글 리스트 -->
            <ul class="post-list">
                <c:choose>
                    <c:when test="${not empty guideList}">
                        <c:forEach var="guide" items="${guideList}">
                            <li class="post-item" 
                                onclick="location.href='${pageContext.request.contextPath}/community/guide/${guide.guideNo}'">
                                <div class="post-header">
                                    <div class="post-left">
                                        <span class="post-category ${guide.guideCategory}">
                                            <c:choose>
                                                <c:when test="${guide.guideCategory eq 'contract'}">
                                                    <i class="fa-solid fa-file-signature"></i> 계약 팁
                                                </c:when>
                                                <c:when test="${guide.guideCategory eq 'moving'}">
                                                    <i class="fa-solid fa-boxes-packing"></i> 이사 팁
                                                </c:when>
                                                <c:when test="${guide.guideCategory eq 'life'}">
                                                    <i class="fa-solid fa-lightbulb"></i> 생활 팁
                                                </c:when>
                                                <c:when test="${guide.guideCategory eq 'area'}">
                                                    <i class="fa-solid fa-location-dot"></i> 동네 정보
                                                </c:when>
                                                <c:when test="${guide.guideCategory eq 'qna'}">
                                                    <i class="fa-solid fa-circle-question"></i> 질문/답변
                                                </c:when>
                                                <c:otherwise>${guide.guideCategory}</c:otherwise>
                                            </c:choose>
                                        </span>
                                        <c:if test="${guide.isHot eq 'Y'}">
                                            <span class="post-badge hot">
                                                <i class="fa-solid fa-fire"></i> HOT
                                            </span>
                                        </c:if>
                                        <h3 class="post-title">${guide.guideTitle}</h3>
                                        <p class="post-preview">
                                            <c:set var="content" value="${fn:replace(guide.guideContent, '<p>', '')}" />
                                            <c:set var="content" value="${fn:replace(content, '</p>', ' ')}" />
                                            <c:set var="content" value="${fn:replace(content, '<br>', ' ')}" />
                                            <c:set var="content" value="${fn:replace(content, '<h3>', '')}" />
                                            <c:set var="content" value="${fn:replace(content, '</h3>', ' ')}" />
                                            <c:set var="content" value="${fn:replace(content, '<ul>', '')}" />
                                            <c:set var="content" value="${fn:replace(content, '</ul>', '')}" />
                                            <c:set var="content" value="${fn:replace(content, '<li>', '')}" />
                                            <c:set var="content" value="${fn:replace(content, '</li>', ' ')}" />
                                            <c:choose>
                                                <c:when test="${fn:length(content) > 100}">
                                                    ${fn:substring(content, 0, 100)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${content}
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                                <div class="post-meta">
                                    <span><i class="fa-solid fa-user"></i> ${guide.userId}</span> 
                                    <span><i class="fa-solid fa-calendar"></i> 
                                        <fmt:formatDate value="${guide.writeDate}" pattern="yyyy.MM.dd"/>
                                    </span>
                                    <span><i class="fa-solid fa-eye"></i> ${guide.viewCount}</span>
                                    <span><i class="fa-solid fa-heart"></i> ${guide.likeCount}</span>
                                    <span><i class="fa-solid fa-comment"></i> ${guide.commentCount}</span>
                                </div>
                            </li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-icon">📭</div>
                            <h3>게시글이 없습니다</h3>
                            <p>첫 번째 게시글을 작성해보세요!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </ul>

            <!-- [추가] 페이징 바 -->
            <c:if test="${not empty guideList}">
            <div class="pagination">
                <!-- 이전 페이지 그룹으로 이동 -->
                <c:if test="${startPage > 1}">
                    <a href="${pageContext.request.contextPath}/community/guide?page=${startPage - 1}&category=${category}&keyword=${keyword}" class="page-link">&laquo;</a>
                </c:if>
                <!-- 이전 페이지로 이동 -->
                <c:if test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/community/guide?page=${currentPage - 1}&category=${category}&keyword=${keyword}" class="page-link">&lt;</a>
                </c:if>
    
                <!-- 페이지 번호 목록 -->
                <c:forEach var="p" begin="${startPage}" end="${endPage}">
                    <a href="${pageContext.request.contextPath}/community/guide?page=${p}&category=${category}&keyword=${keyword}"
                       class="page-link ${currentPage == p ? 'active' : ''}">${p}</a>
                </c:forEach>
    
                <!-- 다음 페이지로 이동 -->
                <c:if test="${currentPage < maxPage}">
                    <a href="${pageContext.request.contextPath}/community/guide?page=${currentPage + 1}&category=${category}&keyword=${keyword}" class="page-link">&gt;</a>
                </c:if>
                <!-- 다음 페이지 그룹으로 이동 -->
                <c:if test="${endPage < maxPage}">
                     <a href="${pageContext.request.contextPath}/community/guide?page=${endPage + 1}&category=${category}&keyword=${keyword}" class="page-link">&raquo;</a>
                </c:if>
            </div>
            </c:if>

        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

    <script>
        let currentCategory = '${category}' || 'all';
        let currentKeyword = '${keyword}' || '';
        let currentPage = ${currentPage} || 1;

        // 카테고리 필터 (AJAX)
        function filterCategory(category) {
            currentCategory = category;
            currentPage = 1; // 카테고리 변경 시 첫 페이지로
            loadGuideList();

            // 카테고리 탭 활성화 상태 업데이트
            document.querySelectorAll('.category-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            event.target.classList.add('active');
        }

        // 페이지 변경 (AJAX)
        function changePage(page) {
            currentPage = page;
            loadGuideList();
        }

        // AJAX로 가이드 목록 로드
        function loadGuideList() {
            const contentWrapper = document.querySelector('.content-wrapper');

            // 로딩 효과
            contentWrapper.style.opacity = '0.5';
            contentWrapper.style.transition = 'opacity 0.3s';

            let url = '${pageContext.request.contextPath}/community/guide/ajax?category=' + currentCategory + '&page=' + currentPage;
            if (currentKeyword) {
                url += '&keyword=' + encodeURIComponent(currentKeyword);
            }

            fetch(url)
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        renderGuideList(data);
                        renderPagination(data);

                        // 부드�운 전환
                        contentWrapper.style.opacity = '1';

                        // URL 업데이트 (뒤로가기 지원)
                        const newUrl = '${pageContext.request.contextPath}/community/guide?category=' + currentCategory + '&page=' + currentPage + (currentKeyword ? '&keyword=' + encodeURIComponent(currentKeyword) : '');
                        history.pushState({category: currentCategory, page: currentPage, keyword: currentKeyword}, '', newUrl);
                    } else {
                        alert(data.message || '게시글 목록을 불러오는데 실패했습니다.');
                        contentWrapper.style.opacity = '1';
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('게시글 목록을 불러오는데 실패했습니다.');
                    contentWrapper.style.opacity = '1';
                });
        }

        // 게시글 목록 렌더링
        function renderGuideList(data) {
            const postList = document.querySelector('.post-list');

            if (!data.guideList || data.guideList.length === 0) {
                postList.innerHTML = `
                    <div class="empty-state">
                        <div class="empty-icon">📭</div>
                        <h3>게시글이 없습니다</h3>
                        <p>첫 번째 게시글을 작성해보세요!</p>
                    </div>
                `;
                return;
            }

            let html = '';
            data.guideList.forEach(guide => {
                const categoryInfo = getCategoryInfo(guide.guideCategory);
                const isHot = guide.isHot === 'Y';

                html += `
                    <li class="post-item" onclick="location.href='${pageContext.request.contextPath}/community/guide/\${guide.guideNo}'">
                        <div class="post-header">
                            <div class="post-left">
                                <span class="post-category \${guide.guideCategory}">
                                    \${categoryInfo.icon} \${categoryInfo.name}
                                </span>
                                \${isHot ? '<span class="post-badge hot"><i class="fa-solid fa-fire"></i> HOT</span>' : ''}
                                <h3 class="post-title">\${guide.guideTitle}</h3>
                                <p class="post-preview">\${getPreview(guide.guideContent)}</p>
                            </div>
                        </div>
                        <div class="post-meta">
                            <span><i class="fa-solid fa-user"></i> \${guide.userId}</span>
                            <span><i class="fa-solid fa-calendar"></i> \${formatDate(guide.writeDate)}</span>
                            <span><i class="fa-solid fa-eye"></i> \${guide.viewCount}</span>
                            <span><i class="fa-solid fa-heart"></i> \${guide.likeCount}</span>
                            <span><i class="fa-solid fa-comment"></i> \${guide.commentCount}</span>
                        </div>
                    </li>
                `;
            });

            postList.innerHTML = html;
        }

        // 페이징 렌더링
        function renderPagination(data) {
            const paginationDiv = document.querySelector('.pagination');
            if (!paginationDiv) return;

            let html = '';

            // 이전 페이지 그룹
            if (data.startPage > 1) {
                html += `<a href="javascript:changePage(\${data.startPage - 1})" class="page-link">&laquo;</a>`;
            }
            // 이전 페이지
            if (data.currentPage > 1) {
                html += `<a href="javascript:changePage(\${data.currentPage - 1})" class="page-link">&lt;</a>`;
            }

            // 페이지 번호
            for (let p = data.startPage; p <= data.endPage; p++) {
                html += `<a href="javascript:changePage(\${p})" class="page-link \${data.currentPage == p ? 'active' : ''}">\${p}</a>`;
            }

            // 다음 페이지
            if (data.currentPage < data.maxPage) {
                html += `<a href="javascript:changePage(\${data.currentPage + 1})" class="page-link">&gt;</a>`;
            }
            // 다음 페이지 그룹
            if (data.endPage < data.maxPage) {
                html += `<a href="javascript:changePage(\${data.endPage + 1})" class="page-link">&raquo;</a>`;
            }

            paginationDiv.innerHTML = html;
        }

        // 카테고리 정보 반환
        function getCategoryInfo(category) {
            const categories = {
                'contract': { icon: '<i class="fa-solid fa-file-signature"></i>', name: '계약 팁' },
                'moving': { icon: '<i class="fa-solid fa-boxes-packing"></i>', name: '이사 팁' },
                'life': { icon: '<i class="fa-solid fa-lightbulb"></i>', name: '생활 팁' },
                'area': { icon: '<i class="fa-solid fa-location-dot"></i>', name: '동네 정보' },
                'qna': { icon: '<i class="fa-solid fa-circle-question"></i>', name: '질문/답변' }
            };
            return categories[category] || { icon: '', name: category };
        }

        // 미리보기 텍스트 생성
        function getPreview(content) {
            const cleaned = content.replace(/<[^>]*>/g, ' ').trim();
            return cleaned.length > 100 ? cleaned.substring(0, 100) + '...' : cleaned;
        }

        // 날짜 포맷
        function formatDate(dateStr) {
            const date = new Date(dateStr);
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            return year + '.' + month + '.' + day;
        }

        // 뒤로가기/앞으로가기 지원
        window.addEventListener('popstate', function(e) {
            if (e.state) {
                currentCategory = e.state.category || 'all';
                currentPage = e.state.page || 1;
                currentKeyword = e.state.keyword || '';
                loadGuideList();

                // 카테고리 탭 상태 업데이트
                document.querySelectorAll('.category-tab').forEach(tab => {
                    tab.classList.remove('active');
                });
                const activeTab = document.querySelector(`.category-tab[onclick*="'\${currentCategory}'"]`);
                if (activeTab) activeTab.classList.add('active');
            }
        });

        // 글쓰기 (로그인 체크)
        function checkLoginAndWrite() {
            const isLoggedIn = ${not empty sessionScope.loginUser};

            if (!isLoggedIn) {
                if (confirm('로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?')) {
                    window.location.href = '${pageContext.request.contextPath}/auth/login';
                }
                return;
            }

            location.href = '${pageContext.request.contextPath}/community/guide-write';
        }
    </script>
</body>
</html>
