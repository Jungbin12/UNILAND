<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 수정 - UNILAND</title>
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
        
        textarea.form-control {
            min-height: 300px;
            resize: vertical;
            font-family: inherit;
        }
        
        .checkbox-group {
            display: flex;
            gap: var(--spacing-lg);
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
        }
        
        .btn-area {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: var(--spacing-2xl);
            padding-top: var(--spacing-lg);
            border-top: 1px solid var(--border-light);
        }
        
        .btn-group {
            display: flex;
            gap: var(--spacing-sm);
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
        
        .btn-danger {
            padding: var(--spacing-sm) var(--spacing-lg);
            background: var(--bg-white);
            color: #f56565;
            border: 1px solid #f56565;
            border-radius: var(--radius-md);
            font-size: var(--font-md);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }
        
        .btn-danger:hover {
            background: rgba(245, 101, 101, 0.1);
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
        
        .alert-success {
            background: rgba(72, 187, 120, 0.1);
            color: #48bb78;
            border: 1px solid #48bb78;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="page-title">
            <i class="fa-solid fa-pen-to-square"></i>
            공지사항 수정
        </h2>
        
        <!-- 에러 메시지 -->
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        
        <!-- 성공 메시지 -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        
        <!-- 공지 수정 폼 -->
        <form action="${pageContext.request.contextPath}/community/notice-update/${notice.noticeNo}" method="post">
            <!-- 공지사항 ID (hidden) -->
            <input type="hidden" name="noticeNo" value="${notice.noticeNo}">
            
            <div class="form-group">
                <label for="noticeSubject" class="form-label">제목 *</label>
                <input type="text" 
                       id="noticeSubject" 
                       name="noticeSubject" 
                       class="form-control" 
                       value="${notice.noticeSubject}"
                       placeholder="공지사항 제목을 입력하세요" 
                       required>
            </div>
            
            <div class="form-group">
                <label for="noticeContent" class="form-label">내용 *</label>
                <textarea id="noticeContent" 
                          name="noticeContent" 
                          class="form-control" 
                          placeholder="공지사항 내용을 입력하세요" 
                          required>${notice.noticeContent}</textarea>
            </div>
            
            <!-- 옵션 체크박스 -->
            <div class="checkbox-group">
                <div class="checkbox-item">
                    <input type="checkbox" 
                           id="noticeImportant" 
                           name="noticeImportant" 
                           value="Y"
                           ${notice.noticeImportant == 'Y' ? 'checked' : ''}>
                    <label for="noticeImportant">중요 공지</label>
                </div>
                <div class="checkbox-item">
                    <input type="checkbox" 
                           id="noticeIsnew" 
                           name="noticeIsnew" 
                           value="Y"
                           ${notice.noticeIsnew == 'Y' ? 'checked' : ''}>
                    <label for="noticeIsnew">NEW 배지 표시</label>
                </div>
            </div>
            
            <div class="btn-area">
                <a href="${pageContext.request.contextPath}/admin/content-management" class="btn-secondary">
                    <i class="fa-solid fa-arrow-left"></i> 취소
                </a>
                <div class="btn-group">
                    <button type="button" class="btn-danger" onclick="deleteNotice()">
                        <i class="fa-solid fa-trash"></i> 삭제
                    </button>
                    <button type="submit" class="btn-primary">
                        <i class="fa-solid fa-check"></i> 수정하기
                    </button>
                </div>
            </div>
        </form>
    </div>
    
    <script>
        function deleteNotice() {
            if (confirm('정말로 이 공지사항을 삭제하시겠습니까?')) {
                const form = document.createElement('form');
                form.method = 'post';
                form.action = '${pageContext.request.contextPath}/community/notice-delete';
                
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'noticeNo';
                input.value = '${notice.noticeNo}';
                
                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>