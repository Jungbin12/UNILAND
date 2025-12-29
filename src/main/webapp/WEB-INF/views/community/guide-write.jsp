<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <%-- ✅ 1. 제목 동적 변경 --%>
    <title>${isEditMode ? '가이드 수정' : '가이드 작성'} - UNILAND</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* ========================================
           UNILAND 디자인 시스템 - CSS 변수
        ======================================== */
        :root {
            --primary-purple: #667eea;
            --primary-dark: #5568d3;
            --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --text-primary: #1a1a1a;
            --text-secondary: #555;
            --text-tertiary: #666;
            --bg-body: #f5f5f5;
            --bg-white: #ffffff;
            --bg-tag: #f5f5f5;
            --border-light: #e5e5e5;
            --spacing-sm: 12px;
            --spacing-md: 20px;
            --spacing-lg: 24px;
            --spacing-xl: 32px;
            --spacing-2xl: 40px;
            --spacing-3xl: 48px;
            --radius-md: 6px;
            --radius-lg: 8px;
            --font-md: 14px;
            --font-lg: 16px;
            --font-2xl: 24px;
            --card-width: 1200px;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Noto Sans KR', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: var(--bg-body);
            color: var(--text-primary);
        }
        
        .container {
            max-width: 900px;
            margin: var(--spacing-3xl) auto;
            padding: var(--spacing-2xl);
            background: var(--bg-white);
            border-radius: var(--radius-lg);
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        
        .page-title {
            font-size: var(--font-2xl);
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: var(--spacing-2xl);
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }
        
        .form-group {
            margin-bottom: var(--spacing-lg);
        }
        
        .form-label {
            display: block;
            font-weight: 600;
            color: var(--text-secondary);
            font-size: var(--font-md);
            margin-bottom: var(--spacing-sm);
        }
        
        .form-label .required {
            color: #f56565;
            margin-left: 4px;
        }
        
        .form-control {
            width: 100%;
            padding: var(--spacing-sm) var(--spacing-md);
            border: 1px solid var(--border-light);
            border-radius: var(--radius-md);
            font-size: var(--font-md);
            transition: all 0.3s;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-purple);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        select.form-control {
            cursor: pointer;
            background: var(--bg-white);
        }
        
        textarea.form-control {
            min-height: 400px;
            resize: vertical;
            font-family: inherit;
            line-height: 1.6;
        }
        
        .category-select {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: var(--spacing-sm);
            margin-bottom: var(--spacing-lg);
        }
        
        .category-option {
            position: relative;
        }
        
        .category-option input[type="radio"] {
            position: absolute;
            opacity: 0;
            cursor: pointer;
        }
        
        .category-label {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: var(--spacing-sm) var(--spacing-md);
            border: 2px solid var(--border-light);
            border-radius: var(--radius-md);
            font-size: var(--font-md);
            font-weight: 500;
            color: var(--text-tertiary);
            cursor: pointer;
            transition: all 0.2s;
            background: var(--bg-white);
        }
        
        .category-option input[type="radio"]:checked + .category-label {
            border-color: var(--primary-purple);
            background: rgba(102, 126, 234, 0.1);
            color: var(--primary-purple);
        }
        
        .category-label:hover {
            border-color: var(--primary-purple);
            background: rgba(102, 126, 234, 0.05);
        }
        
        .category-icon {
            font-size: 16px;
        }
        
        .checkbox-group {
            display: flex;
            gap: var(--spacing-lg);
            padding: var(--spacing-md);
            background: var(--bg-tag);
            border-radius: var(--radius-md);
            margin-bottom: var(--spacing-lg);
        }
        
        .checkbox-item {
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }
        
        .checkbox-item input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }
        
        .checkbox-item label {
            font-size: var(--font-md);
            color: var(--text-secondary);
            cursor: pointer;
            margin: 0;
            font-weight: 500;
        }
        
        .help-text {
            font-size: 13px;
            color: var(--text-tertiary);
            margin-top: 8px;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        
        .btn-area {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: var(--spacing-2xl);
            padding-top: var(--spacing-lg);
            border-top: 1px solid var(--border-light);
        }
        
        .btn-primary {
            padding: var(--spacing-sm) var(--spacing-lg);
            background: var(--gradient-primary);
            color: var(--bg-white);
            border: none;
            border-radius: var(--radius-md);
            font-size: var(--font-md);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }
        
        .btn-primary:hover {
            opacity: 0.9;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(102, 126, 234, 0.3);
        }
        
        .btn-secondary {
            padding: var(--spacing-sm) var(--spacing-lg);
            background: var(--bg-white);
            color: var(--primary-purple);
            border: 1px solid var(--primary-purple);
            border-radius: var(--radius-md);
            font-size: var(--font-md);
            font-weight: 500;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }
        
        .btn-secondary:hover {
            background: var(--bg-tag);
        }
        
        .alert {
            padding: var(--spacing-md);
            margin-bottom: var(--spacing-lg);
            border-radius: var(--radius-md);
            font-size: var(--font-md);
        }
        
        .alert-error {
            background: rgba(245, 101, 101, 0.1);
            color: #f56565;
            border: 1px solid #f56565;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="page-title">
            <i class="fa-solid fa-pen-to-square"></i>
            <%-- ✅ 1. 제목 동적 변경 --%>
            ${isEditMode ? '가이드 수정' : '가이드 작성'}
        </h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        
        <%-- ✅ 2. Form action 동적 변경 --%>
        <c:choose>
            <c:when test="${isEditMode}">
                <c:set var="formAction" value="${pageContext.request.contextPath}/community/guide/${guide.guideNo}/edit" />
            </c:when>
            <c:otherwise>
                <c:set var="formAction" value="${pageContext.request.contextPath}/community/guide-write" />
            </c:otherwise>
        </c:choose>

        <form action="${formAction}" method="post">
            
            <div class="form-group">
                <label class="form-label">
                    카테고리 선택<span class="required">*</span>
                </label>
                <div class="category-select">
                    <%-- ✅ 3. 기존 카테고리 checked 처리 --%>
                    <div class="category-option">
                        <input type="radio" id="cat-contract" name="guideCategory" value="contract" required ${guide.guideCategory == 'contract' ? 'checked' : ''}>
                        <label for="cat-contract" class="category-label">
                            <i class="fa-solid fa-file-contract category-icon"></i>
                            <span>계약 팁</span>
                        </label>
                    </div>
                    <div class="category-option">
                        <input type="radio" id="cat-moving" name="guideCategory" value="moving" required ${guide.guideCategory == 'moving' ? 'checked' : ''}>
                        <label for="cat-moving" class="category-label">
                            <i class="fa-solid fa-truck-moving category-icon"></i>
                            <span>이사 팁</span>
                        </label>
                    </div>
                    <div class="category-option">
                        <input type="radio" id="cat-life" name="guideCategory" value="life" required ${guide.guideCategory == 'life' ? 'checked' : ''}>
                        <label for="cat-life" class="category-label">
                            <i class="fa-solid fa-house-user category-icon"></i>
                            <span>생활 팁</span>
                        </label>
                    </div>
                    <div class="category-option">
                        <input type="radio" id="cat-area" name="guideCategory" value="area" required ${guide.guideCategory == 'area' ? 'checked' : ''}>
                        <label for="cat-area" class="category-label">
                            <i class="fa-solid fa-map-location-dot category-icon"></i>
                            <span>동네 정보</span>
                        </label>
                    </div>
                    <div class="category-option">
                        <input type="radio" id="cat-qna" name="guideCategory" value="qna" required ${guide.guideCategory == 'qna' ? 'checked' : ''}>
                        <label for="cat-qna" class="category-label">
                            <i class="fa-solid fa-question-circle category-icon"></i>
                            <span>질문/답변</span>
                        </label>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="guideTitle" class="form-label">
                    제목<span class="required">*</span>
                </label>
                <input type="text" 
                       id="guideTitle" 
                       name="guideTitle" 
                       class="form-control" 
                       placeholder="게시물 제목을 입력하세요" 
                       required
                       value="<c:out value='${guide.guideTitle}'/>"> <%-- ✅ 4. 기존 제목 value 값 설정 --%>
            </div>
            
            <div class="form-group">
                <label for="guideContent" class="form-label">
                    내용<span class="required">*</span>
                </label>
                <textarea id="guideContent" 
                          name="guideContent" 
                          class="form-control" 
                          placeholder="" 
                          required><c:out value='${guide.guideContent}'/></textarea> <%-- ✅ 5. 기존 내용 textarea에 설정 --%>
            </div>
            

            <div class="btn-area">
			    <%-- 1. isEditMode 값에 따라 취소 버튼의 URL을 결정합니다. --%>
			    <c:choose>
			        <c:when test="${isEditMode}">
			            <%-- 수정 모드일 때는 상세보기 페이지 URL을 만듭니다. --%>
			            <c:set var="cancelUrl" value="${pageContext.request.contextPath}/community/guide/${guide.guideNo}" />
			        </c:when>
			        <c:otherwise>
			            <%-- 작성 모드일 때는 목록 페이지 URL을 사용합니다. --%>
			            <c:set var="cancelUrl" value="${pageContext.request.contextPath}/community/guide" />
			        </c:otherwise>
			    </c:choose>
			
			    <%-- 2. 결정된 URL을 <a> 태그의 href 속성에 적용합니다. --%>
			    <a href="${cancelUrl}" class="btn-secondary">
			        <i class="fa-solid fa-arrow-left"></i> 취소
			    </a>
			
			    <button type="submit" class="btn-primary">
			        <i class="fa-solid fa-paper-plane"></i> ${isEditMode ? '수정하기' : '등록하기'}
			    </button>
			</div>
			
        </form>
    </div>
</body>
</html>