<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="UNILAND 관리자 - 공지사항관리" />
<c:set var="currentPage" value="content-management" />
<jsp:include page="/WEB-INF/views/common/admin-header.jsp"/>

  <style>
    .page-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 24px;
    }

    .page-header h2 {
      font-size: 24px;
      font-weight: 700;
      color: #1a1a1a;
    }

    .btn-create {
      background: #667eea;
      color: white;
      border: none;
      padding: 10px 18px;
      border-radius: 8px;
      font-weight: 600;
      cursor: pointer;
      transition: background 0.3s ease;
    }

    .btn-create:hover {
      background: #5a67d8;
    }

    .search-box {
      background: white;
      border: 1px solid #e5e5e5;
      border-radius: 8px;
      padding: 20px;
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 30px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }

    .search-box select, .search-box input {
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 6px;
      font-size: 14px;
    }

    .search-box select { width: 130px; }
    .search-box input { flex: 1; }

    .btn-search {
      background: #667eea;
      color: white;
      border: none;
      padding: 10px 18px;
      border-radius: 6px;
      font-weight: 600;
      cursor: pointer;
      transition: background 0.3s ease;
    }

    .btn-search:hover { background: #5a67d8; }

    .btn-reset {
      background: #718096;
      color: white;
      border: none;
      padding: 10px 18px;
      border-radius: 6px;
      font-weight: 600;
      cursor: pointer;
      transition: background 0.3s ease;
    }
    .btn-reset:hover { background: #4a5568; }

    table {
      width: 100%;
      border-collapse: collapse;
      background: white;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    th, td {
      padding: 14px;
      border-bottom: 1px solid #f0f0f0;
      text-align: center;
      font-size: 14px;
    }

    th {
      background: #f8f8f8;
      color: #555;
      font-weight: 600;
    }

    tr:hover td { background: #f9faff; }

    .manage-btn {
      display: flex;
      justify-content: center;
      gap: 6px;
    }

    .badge {
      display: inline-block;
      padding: 4px 8px;
      border-radius: 4px;
      font-size: 11px;
      font-weight: 600;
    }

    .badge-important {
      background: #f56565;
      color: white;
    }

    .badge-new {
      background: #48bb78;
      color: white;
    }

    .btn-edit, .btn-delete {
      border: none;
      padding: 6px 10px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 13px;
      font-weight: 600;
    }

    .notice-title a {
      text-decoration: none;
      color: #1a1a1a;
      transition: color 0.2s;
    }

    .notice-title a:hover {
      color: #667eea;
    }

    .btn-edit { background: #48bb78; color: white; }
    .btn-delete { background: #e53e3e; color: white; }
    .btn-edit:hover { background: #38a169; }
    .btn-delete:hover { background: #c53030; }

    .search-result-message {
      background: #e6f7ff;
      border: 1px solid #91d5ff;
      border-radius: 6px;
      padding: 12px 16px;
      margin-bottom: 20px;
      color: #0050b3;
      font-size: 14px;
      display: none;
      align-items: center;
      gap: 8px;
    }
    .search-result-message.active {
      display: flex;
    }

    .no-result {
      text-align: center;
      padding: 40px 20px;
      color: #718096;
      font-size: 14px;
      display: none;
    }
    .no-result.active {
      display: block;
    }
    .no-result i {
      font-size: 48px;
      margin-bottom: 12px;
      opacity: 0.5;
    }
  </style>

      <div class="page-header">
        <h2>공지사항관리 (<span id="noticeCount">0</span>건)</h2>
        <button class="btn-create" onclick="location.href='/uniland/community/notice-write'">
          <i class="fa-solid fa-pen"></i> 공지 작성
        </button>
      </div>

      <div class="search-result-message" id="searchResultMessage">
        <i class="fa-solid fa-info-circle"></i>
        <span id="searchResultText"></span>
      </div>

      <div class="search-box">
        <select id="searchCategory">
          <option value="all">전체</option>
          <option value="title">제목</option>
          <option value="writer">작성자</option>
          <option value="date">작성일</option>
        </select>
        <input type="text" id="searchInput" placeholder="검색어를 입력하세요" onkeypress="if(event.keyCode==13) searchNotice()">
        <button class="btn-search" onclick="searchNotice()">
          <i class="fa-solid fa-search"></i> 검색
        </button>
        <button class="btn-reset" onclick="resetSearch()">
          <i class="fa-solid fa-rotate-right"></i> 초기화
        </button>
      </div>

      <table>
        <thead>
          <tr>
            <th>No.</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
            <th>관리</th>
          </tr>
        </thead>
        <tbody id="noticeTable">
          <c:forEach var="notice" items="${noticeList}">
            <tr data-title="${notice.noticeSubject}"
                data-writer="${notice.noticeWriter}"
                data-date="<fmt:formatDate value="${notice.noticeCreateat}" pattern="yyyy-MM-dd" />">
              <td>${notice.noticeNo}</td>
              <td class="notice-title">
                <a href="${pageContext.request.contextPath}/community/notice/${notice.noticeNo}">
                  <c:if test="${notice.noticeImportant == 'Y'}">
                    <span class="badge badge-important">중요</span>
                  </c:if>
                  <c:if test="${notice.noticeIsnew == 'Y'}">
                    <span class="badge badge-new">NEW</span>
                  </c:if>
                  ${notice.noticeSubject}
                </a>
              </td>
              <td>${notice.noticeWriter}</td>
              <td><fmt:formatDate value="${notice.noticeCreateat}" pattern="yyyy-MM-dd" /></td>
              <td>${notice.viewCount}</td>
              <td>
                <div class="manage-btn">
                  <button class="btn-edit" onclick="location.href='${pageContext.request.contextPath}/community/notice-update/${notice.noticeNo}'">
                    <i class="fa-solid fa-pen"></i> 수정
                  </button>
                  <form action="${pageContext.request.contextPath}/community/notice/delete/${notice.noticeNo}" method="post" style="display:inline;">
                    <button type="submit" class="btn-delete" onclick="return confirm('정말 삭제하시겠습니까?')">
                      <i class="fa-solid fa-trash"></i> 삭제
                    </button>
                  </form>
                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>

      <div id="noResult" class="no-result">
        <i class="fa-solid fa-inbox"></i>
        <div>검색 결과가 없습니다.</div>
      </div>

      <c:if test="${empty noticeList}">
        <div class="no-result active">
          <i class="fa-solid fa-inbox"></i>
          <div>등록된 공지사항이 없습니다.</div>
        </div>
      </c:if>

  <script>
    function searchNotice() {
      const category = document.getElementById('searchCategory').value;
      const keyword = document.getElementById('searchInput').value.trim().toLowerCase();

      if (!keyword) {
        alert('검색어를 입력하세요.');
        return;
      }

      const rows = document.querySelectorAll('#noticeTable tr');
      let visibleCount = 0;

      rows.forEach(row => {
        const title = row.getAttribute('data-title')?.toLowerCase() || '';
        const writer = row.getAttribute('data-writer')?.toLowerCase() || '';
        const date = row.getAttribute('data-date') || '';

        let isMatch = false;

        if (category === 'all') {
          isMatch = title.includes(keyword) ||
                    writer.includes(keyword) ||
                    date.includes(keyword);
        } else if (category === 'title') {
          isMatch = title.includes(keyword);
        } else if (category === 'writer') {
          isMatch = writer.includes(keyword);
        } else if (category === 'date') {
          isMatch = date.includes(keyword);
        }

        if (isMatch) {
          row.style.display = '';
          visibleCount++;
        } else {
          row.style.display = 'none';
        }
      });

      const searchResultMessage = document.getElementById('searchResultMessage');
      const searchResultText = document.getElementById('searchResultText');
      const noResultDiv = document.getElementById('noResult');

      searchResultMessage.classList.add('active');

      if (visibleCount > 0) {
    	  searchResultText.textContent = "'" + keyword + "' 검색 결과";
        noResultDiv.classList.remove('active');
      } else {
    	  searchResultText.textContent = "'" + keyword + "' 검색 결과가 없습니다.";
        noResultDiv.classList.add('active');
      }

      document.getElementById('noticeCount').textContent = visibleCount;
    }

    function resetSearch() {
      document.getElementById('searchCategory').value = 'all';
      document.getElementById('searchInput').value = '';

      document.getElementById('searchResultMessage').classList.remove('active');
      document.getElementById('searchResultText').textContent = '';

      document.querySelectorAll('#noticeTable tr').forEach(row => {
        row.style.display = '';
      });

      document.getElementById('noResult').classList.remove('active');

      updateCount();
    }

    function updateCount() {
      const rows = document.querySelectorAll('#noticeTable tr');
      let visibleCount = 0;

      rows.forEach(row => {
        if (row.style.display !== 'none') visibleCount++;
      });

      document.getElementById('noticeCount').textContent = visibleCount;
    }

    window.addEventListener('DOMContentLoaded', function() {
      updateCount();
    });
  </script>

<jsp:include page="/WEB-INF/views/common/admin-footer.jsp"/>
