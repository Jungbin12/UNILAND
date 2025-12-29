<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="UNILAND 관리자 - 회원관리" />
<c:set var="currentPage" value="user-management" />
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

    /* 검색창 */
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

    /* 섹션 타이틀 */
    .section-title {
      font-size: 18px;
      font-weight: 600;
      color: #2d3748;
      margin-bottom: 16px;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    /* 테이블 */
    table {
      width: 100%;
      background: white;
      border-collapse: collapse;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
      margin-bottom: 40px;
    }
    th, td {
      padding: 14px 12px;
      text-align: center;
      border-bottom: 1px solid #f0f0f0;
      font-size: 14px;
    }
    th {
      background: #f8f8f8;
      color: #555;
      font-weight: 600;
    }
    tr:hover td { background: #f9faff; }

    /* 상태 뱃지 */
    .badge {
      display: inline-block;
      padding: 4px 10px;
      border-radius: 12px;
      font-size: 12px;
      font-weight: 600;
      color: white;
    }
    .badge.active { background: #48bb78; }
    .badge.inactive { background: #e53e3e; }
    .badge.PENDING {background: #ed8936;}
    .badge.APPROVAL { background: #48bb78;}
    .badge.REJECTED {background: #e53e3e;}

    /* 버튼 */
    .action-btns button {
      border: none;
      padding: 6px 12px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 13px;
      margin: 0 4px;
      transition: all 0.2s;
    }
    .btn-edit { background: #48bb78; color: white; }
    .btn-edit:hover { background: #38a169; }
    .btn-delete { background: #e53e3e; color: white; }
    .btn-delete:hover { background: #c53030; }

    /* 검색 결과 메시지 */
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

    /* 검색 결과 없음 */
    .no-result {
      text-align: center;
      padding: 40px 20px;
      color: #718096;
      font-size: 14px;
    }
    .no-result i {
      font-size: 48px;
      margin-bottom: 12px;
      opacity: 0.5;
    }
  </style>

      <div class="page-header">
        <h2>회원관리</h2>
      </div>

      <!-- 검색 박스 -->
      <div class="search-box">
        <select id="searchCategory">
          <option value="all">전체</option>
          <option value="name">이름</option>
          <option value="id">아이디</option>
          <option value="email">이메일</option>
          <option value="phone">연락처</option>
          <option value="office">사무소명</option>
        </select>
        <input type="text" id="searchInput" placeholder="검색어를 입력하세요" onkeypress="if(event.keyCode==13) searchMember()">
        <button class="btn-search" onclick="searchMember()">
          <i class="fa-solid fa-search"></i> 검색
        </button>
        <button class="btn-reset" onclick="resetSearch()">
          <i class="fa-solid fa-rotate-right"></i> 초기화
        </button>
      </div>

      <!-- 검색 결과 메시지 -->
      <div class="search-result-message" id="searchResultMessage">
        <i class="fa-solid fa-info-circle"></i>
        <span id="searchResultText"></span>
      </div>

      <!-- 일반 회원 목록 -->
      <h3 class="section-title">
        <i class="fa-solid fa-user"></i> 일반 회원 목록
        <span style="color: #667eea; font-size: 16px;">(<span id="userCount">0</span>명)</span>
      </h3>
      <table>
        <thead>
          <tr>
            <th>No.</th>
            <th>이름</th>
            <th>아이디</th>
            <th>이메일</th>
            <th>연락처</th>
            <th>상태</th>
            <th>가입일</th>
            <th>관리</th>
          </tr>
        </thead>
        <tbody id="memberTable">
          <c:forEach var="user" items="${userList}" varStatus="status">
            <c:if test="${user.adminYn == 'N'}">
              <tr data-name="${user.userName}"
                  data-id="${user.userId}"
                  data-email="${user.userEmail}"
                  data-phone="${user.userPhone}">
                <td>${status.count}</td>
                <td>${user.userName}</td>
                <td>${user.userId}</td>
                <td>${user.userEmail}</td>
                <td>${user.userPhone}</td>
                <td>
                  <span class="badge ${user.deleteYn == 'N' ? 'active' : 'inactive'}">
                    ${user.deleteYn == 'N' ? '활성' : '탈퇴'}
                  </span>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${not empty user.createdAt}">
                      <fmt:formatDate value="${user.createdAt}" pattern="yyyy-MM-dd"/>
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                  </c:choose>
                </td>
                <td class="action-btns">
                  <form action="${pageContext.request.contextPath}/admin/user-delete/${user.userId}"
                        method="post" style="display:inline;">
                    <button type="submit" class="btn-delete"
                            onclick="return confirm('정말 탈퇴 처리하시겠습니까?')">
                      <i class="fa-solid fa-user-xmark"></i> 탈퇴
                    </button>
                  </form>
                </td>
              </tr>
            </c:if>
          </c:forEach>
        </tbody>
      </table>
      <div id="noUserResult" class="no-result" style="display: none;">
        <i class="fa-solid fa-inbox"></i>
        <div>검색 결과가 없습니다.</div>
      </div>

      <!-- 중개사 회원 목록 -->
      <h3 class="section-title">
        <i class="fa-solid fa-building"></i> 중개사 회원 목록
        <span style="color: #667eea; font-size: 16px;">(<span id="realtorCount">0</span>명)</span>
      </h3>
      <table>
        <thead>
          <tr>
            <th>No.</th>
            <th>중개인 이름</th>
            <th>아이디</th>
            <th>사무소명</th>
            <th>연락처</th>
            <th>이메일</th>
            <th>승인상태</th>
            <th>가입일</th>
            <th>관리</th>
          </tr>
        </thead>
        <tbody id="realtorTable">
          <c:forEach var="realtor" items="${realtorList}" varStatus="status">
            <tr data-name="${realtor.realtorName}"
                data-id="${realtor.realtorId}"
                data-email="${realtor.realtorEmail}"
                data-phone="${realtor.realtorPhone}"
                data-office="${realtor.officeName}">
              <td>${status.count}</td>
              <td>${realtor.realtorName}</td>
              <td>${realtor.realtorId}</td>
              <td>${realtor.officeName}</td>
              <td>${realtor.realtorPhone}</td>
              <td>${realtor.realtorEmail}</td>
              <td>
                <c:choose>
                  <c:when test="${realtor.approvalStatus == 'APPROVAL'}">
                    <span class="badge ${realtor.approvalStatus}">승인완료</span>
                  </c:when>
                  <c:when test="${realtor.approvalStatus == 'PENDING'}">
                    <span class="badge ${realtor.approvalStatus}">승인대기</span>
                  </c:when>
                  <c:when test="${realtor.approvalStatus == 'REJECTED'}">
                    <span class="badge ${realtor.approvalStatus}">반려</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge inactive">-</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <c:choose>
                  <c:when test="${not empty realtor.createdAt}">
                    <fmt:formatDate value="${realtor.createdAt}" pattern="yyyy-MM-dd"/>
                  </c:when>
                  <c:otherwise>-</c:otherwise>
                </c:choose>
              </td>
              <td class="action-btns">
                <form action="${pageContext.request.contextPath}/admin/realtor-delete/${realtor.realtorId}"
                      method="post" style="display:inline;">
                  <button type="submit" class="btn-delete"
                          onclick="return confirm('정말 탈퇴하시겠습니까?')">
                    <i class="fa-solid fa-trash"></i> 탈퇴
                  </button>
                </form>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      <div id="noRealtorResult" class="no-result" style="display: none;">
        <i class="fa-solid fa-inbox"></i>
        <div>검색 결과가 없습니다.</div>
      </div>

  <script>
    // 검색 기능
    function searchMember() {
      const category = document.getElementById('searchCategory').value;
      const keyword = document.getElementById('searchInput').value.trim().toLowerCase();

      if (!keyword) {
        alert('검색어를 입력하세요.');
        return;
      }

      // 일반 회원 검색
      const userRows = document.querySelectorAll('#memberTable tr');
      let userVisibleCount = 0;

      userRows.forEach(row => {
        const name = row.getAttribute('data-name') || '';
        const id = row.getAttribute('data-id') || '';
        const email = row.getAttribute('data-email') || '';
        const phone = row.getAttribute('data-phone') || '';

        let isMatch = false;

        if (category === 'all') {
          isMatch = name.toLowerCase().includes(keyword) ||
                   id.toLowerCase().includes(keyword) ||
                   email.toLowerCase().includes(keyword) ||
                   phone.toLowerCase().includes(keyword);
        } else if (category === 'name') {
          isMatch = name.toLowerCase().includes(keyword);
        } else if (category === 'id') {
          isMatch = id.toLowerCase().includes(keyword);
        } else if (category === 'email') {
          isMatch = email.toLowerCase().includes(keyword);
        } else if (category === 'phone') {
          isMatch = phone.toLowerCase().includes(keyword);
        }

        if (isMatch) {
          row.style.display = '';
          userVisibleCount++;
        } else {
          row.style.display = 'none';
        }
      });

      // 중개사 검색
      const realtorRows = document.querySelectorAll('#realtorTable tr');
      let realtorVisibleCount = 0;

      realtorRows.forEach(row => {
        const name = row.getAttribute('data-name') || '';
        const id = row.getAttribute('data-id') || '';
        const email = row.getAttribute('data-email') || '';
        const phone = row.getAttribute('data-phone') || '';
        const office = row.getAttribute('data-office') || '';

        let isMatch = false;

        if (category === 'all') {
          isMatch = name.toLowerCase().includes(keyword) ||
                   id.toLowerCase().includes(keyword) ||
                   email.toLowerCase().includes(keyword) ||
                   phone.toLowerCase().includes(keyword) ||
                   office.toLowerCase().includes(keyword);
        } else if (category === 'name') {
          isMatch = name.toLowerCase().includes(keyword);
        } else if (category === 'id') {
          isMatch = id.toLowerCase().includes(keyword);
        } else if (category === 'email') {
          isMatch = email.toLowerCase().includes(keyword);
        } else if (category === 'phone') {
          isMatch = phone.toLowerCase().includes(keyword);
        } else if (category === 'office') {
          isMatch = office.toLowerCase().includes(keyword);
        }

        if (isMatch) {
          row.style.display = '';
          realtorVisibleCount++;
        } else {
          row.style.display = 'none';
        }
      });

      	// 검색 결과 메시지
		const totalCount = userVisibleCount + realtorVisibleCount;
		const searchResultMessage = document.getElementById('searchResultMessage');
		const searchResultText = document.getElementById('searchResultText');

/* 		if (totalCount > 0) {
		  searchResultText.textContent = `'${keyword}' 검색 결과: 일반 ${userVisibleCount}명, 중개사 ${realtorVisibleCount}명`;
		  searchResultMessage.classList.add('active');
		} else {
		  searchResultText.textContent = `'${keyword}' 검색 결과가 없습니다.`;
		  searchResultMessage.classList.add('active');
		}
		 */
		document.getElementById('userCount').textContent = userVisibleCount;
		document.getElementById('realtorCount').textContent = realtorVisibleCount;
		document.getElementById('searchResultText').textContent = totalCount;

      // 카운트 업데이트
      updateCounts();


    }

    // 검색 초기화
    function resetSearch() {
      document.getElementById('searchCategory').value = 'all';
      document.getElementById('searchInput').value = '';
      document.getElementById('searchResultMessage').classList.remove('active');

      // 모든 행 표시
      document.querySelectorAll('#memberTable tr, #realtorTable tr').forEach(row => {
        row.style.display = '';
      });

      // 결과 없음 메시지 숨김
      document.getElementById('noUserResult').style.display = 'none';
      document.getElementById('noRealtorResult').style.display = 'none';

      // 카운트 업데이트
      updateCounts();

      window.searchMember = searchMember;
    }

    // 카운트 업데이트
    function updateCounts() {
      const userRows = document.querySelectorAll('#memberTable tr');
      const realtorRows = document.querySelectorAll('#realtorTable tr');

      let userVisibleCount = 0;
      let realtorVisibleCount = 0;

      userRows.forEach(row => {
        if (row.style.display !== 'none') userVisibleCount++;
      });

      realtorRows.forEach(row => {
        if (row.style.display !== 'none') realtorVisibleCount++;
      });

      document.getElementById('userCount').textContent = userVisibleCount;
      document.getElementById('realtorCount').textContent = realtorVisibleCount;
    }

    // 페이지 로드 시 초기 카운트
    window.addEventListener('DOMContentLoaded', function() {
      updateCounts();
    });
  </script>

<jsp:include page="/WEB-INF/views/common/admin-footer.jsp"/>
