<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="UNILAND 관리자 - 매물관리" />
<c:set var="currentPage" value="property-management" />
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
    .total-count {
      font-size: 14px;
      color: #666;
      margin-left: 10px;
    }

    /* 검색 & 페이지 사이즈 선택 */
    .control-box {
      background: white;
      border: 1px solid #e5e5e5;
      border-radius: 8px;
      padding: 20px;
      margin-bottom: 20px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }
    .search-box {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 15px;
    }
    .page-size-box {
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .page-size-box label {
      font-size: 14px;
      color: #555;
      font-weight: 500;
    }
    .search-box select, .search-box input, .page-size-box select {
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 6px;
      font-size: 14px;
    }
    .search-box select { width: 130px; }
    .search-box input { flex: 1; }
    .page-size-box select { width: 100px; }
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

    /* 테이블 래퍼 - 반응형 스크롤 */
    .table-wrapper {
      width: 100%;
      overflow-x: auto;
      background: white;
      border-radius: 8px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
      margin-bottom: 20px;
    }

    table {
      width: 100%;
      min-width: 1000px; /* 최소 너비 설정 */
      background: white;
      border-collapse: collapse;
    }
    th, td {
      padding: 14px 12px;
      text-align: center;
      border-bottom: 1px solid #f0f0f0;
      font-size: 14px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    th {
      background: #f8f8f8;
      color: #555;
      font-weight: 600;
    }
    tr:hover td { background: #f9faff; }

    /* 각 열별 너비 설정 */
    th:nth-child(1), td:nth-child(1) { width: 50px; }  /* No. */
    th:nth-child(2), td:nth-child(2) {
      min-width: 150px;
      max-width: 200px;
      white-space: normal;
      word-break: break-word;
      line-height: 1.4;
    }  /* 건물명 - 두 줄 가능 */
    th:nth-child(3), td:nth-child(3) { width: 70px; }  /* 유형 */
    th:nth-child(4), td:nth-child(4) { width: 90px; }  /* 가격 */
    th:nth-child(5), td:nth-child(5) {
      min-width: 120px;
      max-width: 180px;
      white-space: normal;
      word-break: break-word;
    }  /* 위치 */
    th:nth-child(6), td:nth-child(6) { width: 80px; }  /* 등록자 */
    th:nth-child(7), td:nth-child(7) { width: 110px; }  /* 연락처 */
    th:nth-child(8), td:nth-child(8) { width: 70px; }  /* 상태 */
    th:nth-child(9), td:nth-child(9) { width: 100px; }  /* 등록일 */
    th:nth-child(10), td:nth-child(10) { width: 140px; }  /* 관리 */

    .action-btns {
      display: flex;
      justify-content: center;
      gap: 5px;
    }
    .action-btns button {
      border: none;
      padding: 6px 12px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 13px;
      transition: all 0.2s;
    }
    .btn-edit { background: #48bb78; color: white; }
    .btn-edit:hover { background: #38a169; }
    .btn-delete { background: #e53e3e; color: white; }
    .btn-delete:hover { background: #c53030; }

    .status-active { color: #48bb78; font-weight: 600; }
    .status-reserved { color: #ed8936; font-weight: 600; }
    .status-completed { color: #4299e1; font-weight: 600; }

    /* 페이징 */
    .pagination {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 8px;
      margin-top: 30px;
      padding: 20px;
      background: white;
      border-radius: 8px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }
    .pagination button {
      border: 1px solid #ddd;
      background: white;
      padding: 8px 12px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 14px;
      transition: all 0.2s;
      min-width: 36px;
    }
    .pagination button:hover:not(:disabled) {
      background: #f0f2ff;
      border-color: #667eea;
      color: #667eea;
    }
    .pagination button:disabled {
      cursor: not-allowed;
      opacity: 0.5;
    }
    .pagination button.active {
      background: #667eea;
      color: white;
      border-color: #667eea;
      font-weight: 600;
    }
    .pagination .page-info {
      margin: 0 15px;
      font-size: 14px;
      color: #666;
    }

    .modal {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0,0,0,0.5);
      z-index: 1000;
      justify-content: center;
      align-items: center;
    }
    .modal-content {
      background: white;
      padding: 30px;
      border-radius: 12px;
      width: 400px;
      box-shadow: 0 10px 40px rgba(0,0,0,0.3);
    }
    .modal-header {
      font-size: 18px;
      font-weight: 600;
      margin-bottom: 20px;
      color: #333;
    }
    .modal-body {
      margin-bottom: 20px;
    }
    .modal-body label {
      display: block;
      margin-bottom: 8px;
      font-weight: 500;
      color: #555;
    }
    .modal-body select {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 6px;
      font-size: 14px;
    }
    .modal-footer {
      display: flex;
      justify-content: flex-end;
      gap: 10px;
    }
    .btn-cancel {
      background: #e2e8f0;
      color: #333;
      border: none;
      padding: 10px 20px;
      border-radius: 6px;
      cursor: pointer;
      font-weight: 600;
    }
    .btn-confirm {
      background: #667eea;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 6px;
      cursor: pointer;
      font-weight: 600;
    }

    .loading {
      display: none;
      text-align: center;
      padding: 20px;
      color: #666;
    }

    .empty-list {
      text-align: center;
      padding: 40px;
      color: #999;
      background: white;
      border-radius: 8px;
    }

    /* 반응형 미디어 쿼리 */
    @media (max-width: 1200px) {
      .search-box {
        flex-wrap: wrap;
      }
      .search-box select {
        width: 120px;
      }
    }

    @media (max-width: 768px) {
      .page-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 10px;
      }

      .search-box {
        flex-direction: column;
        align-items: stretch;
      }

      .search-box select,
      .search-box input,
      .btn-search {
        width: 100%;
      }

      .page-size-box {
        flex-wrap: wrap;
      }

      .pagination {
        flex-wrap: wrap;
        gap: 5px;
        padding: 15px 10px;
      }

      .pagination button {
        min-width: 32px;
        padding: 6px 10px;
        font-size: 13px;
      }

      .action-btns {
        flex-direction: column;
        gap: 3px;
      }

      .action-btns button {
        width: 100%;
        padding: 5px 8px;
        font-size: 12px;
      }
    }

    @media (max-width: 480px) {
      th, td {
        padding: 10px 8px;
        font-size: 12px;
      }

      .page-header h2 {
        font-size: 20px;
      }

      .total-count {
        font-size: 12px;
      }
    }
  </style>

      <div class="page-header">
        <div>
          <h2>매물관리 <span class="total-count" id="totalCount">총 ${pageInfo.totalElements}건</span></h2>
        </div>
      </div>

      <div class="control-box">
        <div class="search-box">
          <select id="searchCategory">
            <option value="name">건물명</option>
            <option value="type">유형</option>
            <option value="price">가격</option>
            <option value="location">위치</option>
            <option value="owner">등록자</option>
            <option value="contact">연락처</option>
            <option value="date">등록일</option>
          </select>
          <input type="text" id="searchInput" placeholder="검색어를 입력하세요" onkeypress="handleEnterKey(event)">
          <button class="btn-search" onclick="searchListing()"><i class="fa-solid fa-magnifying-glass"></i> 검색</button>
        </div>
        <div class="page-size-box">
          <label>페이지당 항목 수:</label>
          <select id="pageSizeSelect" onchange="changePageSize()">
            <option value="10" ${pageInfo.size == 10 ? 'selected' : ''}>10개</option>
            <option value="20" ${pageInfo.size == 20 ? 'selected' : ''}>20개</option>
            <option value="30" ${pageInfo.size == 30 ? 'selected' : ''}>30개</option>
            <option value="50" ${pageInfo.size == 50 ? 'selected' : ''}>50개</option>
          </select>
        </div>
      </div>

      <div class="loading" id="loading">
        <i class="fa-solid fa-spinner fa-spin"></i> 로딩 중...
      </div>

      <div id="tableContainer">
        <c:choose>
          <c:when test="${empty propertyList}">
            <div class="empty-list">
              <i class="fa-solid fa-folder-open" style="font-size: 48px; color: #ddd; margin-bottom: 10px;"></i>
              <p>등록된 매물이 없습니다.</p>
            </div>
          </c:when>
          <c:otherwise>
            <div class="table-wrapper">
              <table>
                <thead>
                  <tr>
                    <th>No.</th>
                    <th>건물명</th>
                    <th>유형</th>
                    <th>가격</th>
                    <th>위치</th>
                    <th>등록자</th>
                    <th>연락처</th>
                    <th>상태</th>
                    <th>등록일</th>
                    <th>관리</th>
                  </tr>
                </thead>
                <tbody id="listingTable">
                  <c:forEach items="${propertyList}" var="property" varStatus="status">
                    <tr>
                      <td>${(pageInfo.currentPage - 1) * pageInfo.size + status.count}</td>
                      <td>${property.propertyName}</td>
                      <td>${property.propertyType}</td>
                      <td>${property.priceDisplay}</td>
                      <td>${property.location}</td>
                      <td>${property.ownerName}</td>
                      <td>${property.ownerContact}</td>
                      <td>
                        <c:choose>
                          <c:when test="${property.status == 'ACTIVE'}">
                            <span class="status-active">등록</span>
                          </c:when>
                          <c:when test="${property.status == 'RESERVED'}">
                            <span class="status-reserved">예약중</span>
                          </c:when>
                          <c:when test="${property.status == 'COMPLETED'}">
                            <span class="status-completed">거래완료</span>
                          </c:when>
                          <c:otherwise>
                            <span>${property.status}</span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td><fmt:formatDate value="${property.createdAt}" pattern="yyyy-MM-dd" /></td>
                      <td class="action-btns">
                        <button class="btn-edit" onclick="openStatusModal(${property.propertyNo}, '${property.status}')">
                          <i class="fa-solid fa-pen"></i> 수정
                        </button>
                        <button class="btn-delete" onclick="deleteProperty(${property.propertyNo})">
                          <i class="fa-solid fa-trash"></i> 삭제
                        </button>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- 페이징 -->
      <div class="pagination" id="pagination">
        <button onclick="goToPage(1)" ${pageInfo.first ? 'disabled' : ''}>
          <i class="fa-solid fa-angles-left"></i>
        </button>
        <button onclick="goToPage(${pageInfo.currentPage - 1})" ${!pageInfo.hasPrevious ? 'disabled' : ''}>
          <i class="fa-solid fa-angle-left"></i>
        </button>

        <c:forEach items="${pageInfo.pageNumbers}" var="pageNum">
          <button onclick="goToPage(${pageNum})" class="${pageNum == pageInfo.currentPage ? 'active' : ''}">
            ${pageNum}
          </button>
        </c:forEach>

        <button onclick="goToPage(${pageInfo.currentPage + 1})" ${!pageInfo.hasNext ? 'disabled' : ''}>
          <i class="fa-solid fa-angle-right"></i>
        </button>
        <button onclick="goToPage(${pageInfo.totalPages})" ${pageInfo.last ? 'disabled' : ''}>
          <i class="fa-solid fa-angles-right"></i>
        </button>

        <span class="page-info">${pageInfo.currentPage} / ${pageInfo.totalPages} 페이지</span>
      </div>

  <div class="modal" id="statusModal">
    <div class="modal-content">
      <div class="modal-header">매물 상태 변경</div>
      <div class="modal-body">
        <label for="statusSelect">변경할 상태를 선택하세요:</label>
        <select id="statusSelect">
          <option value="ACTIVE">등록</option>
          <option value="RESERVED">예약중</option>
          <option value="COMPLETED">거래완료</option>
        </select>
      </div>
      <div class="modal-footer">
        <button class="btn-cancel" onclick="closeStatusModal()">취소</button>
        <button class="btn-confirm" onclick="confirmStatusChange()">확인</button>
      </div>
    </div>
  </div>

  <script>
    let currentPropertyNo = null;
    let currentPage = ${pageInfo.currentPage};
    let currentPageSize = ${pageInfo.size};
    let currentSearchCategory = '';
    let currentSearchKeyword = '';

    let totalPages = ${pageInfo.totalPages};

    function goToPage(page) {
        if (page < 1 || page > totalPages) return;

        const url = '${pageContext.request.contextPath}/admin/api/properties/search' +
                    '?page=' + page +
                    '&size=' + currentPageSize +
                    '&searchCategory=' + encodeURIComponent(currentSearchCategory) +
                    '&searchKeyword=' + encodeURIComponent(currentSearchKeyword);

        loadProperties(url);
      }


    function changePageSize() {
      currentPageSize = document.getElementById('pageSizeSelect').value;
      goToPage(1);
    }

    function searchListing() {
      currentSearchCategory = document.getElementById('searchCategory').value;
      currentSearchKeyword = document.getElementById('searchInput').value.trim();
      currentPage = 1;
      goToPage(1);
    }

    function handleEnterKey(event) {
      if (event.key === 'Enter') {
        searchListing();
      }
    }

    function loadProperties(url) {
      document.getElementById('loading').style.display = 'block';
      document.getElementById('tableContainer').style.display = 'none';

      fetch(url)
        .then(response => response.json())
        .then(pageResponse => {
          if (pageResponse && pageResponse.content) {
            renderTable(pageResponse.content, pageResponse);
            renderPagination(pageResponse);
            document.getElementById('totalCount').textContent = '총 ' + pageResponse.totalElements + '건';
            currentPage = pageResponse.currentPage;
            totalPages = pageResponse.totalPages;
          } else {
            alert('조회 중 오류가 발생했습니다.');
          }
        })
        .catch(error => {
          console.error('Error:', error);
          alert('조회 중 오류가 발생했습니다: ' + error.message);
        })
        .finally(() => {
          document.getElementById('loading').style.display = 'none';
          document.getElementById('tableContainer').style.display = 'block';
        });
    }

    function renderTable(properties, pageInfo) {
      const container = document.getElementById('tableContainer');
      if (!container) return;

      if (properties.length === 0) {
        container.innerHTML = '<div class="empty-list"><i class="fa-solid fa-folder-open" style="font-size: 48px; color: #ddd; margin-bottom: 10px;"></i><p>검색 결과가 없습니다.</p></div>';
        return;
      }

      let tableHTML = '<div class="table-wrapper"><table><thead><tr><th>No.</th><th>건물명</th><th>유형</th><th>가격</th><th>위치</th><th>등록자</th><th>연락처</th><th>상태</th><th>등록일</th><th>관리</th></tr></thead><tbody id="listingTable">';

      properties.forEach((property, index) => {
        const rowNum = (pageInfo.currentPage - 1) * pageInfo.size + index + 1;
        const createdDate = property.createdAt ? new Date(property.createdAt).toISOString().split('T')[0] : '-';

        let statusText = '-';
        let statusClass = '';
        if (property.status === 'ACTIVE') {
          statusText = '등록';
          statusClass = 'status-active';
        } else if (property.status === 'RESERVED') {
          statusText = '예약중';
          statusClass = 'status-reserved';
        } else if (property.status === 'COMPLETED') {
          statusText = '거래완료';
          statusClass = 'status-completed';
        } else if (property.status) {
          statusText = property.status;
        }

        const propertyName = property.propertyName || '-';
        const propertyType = property.propertyType || '-';
        const priceDisplay = property.priceDisplay || '-';
        const location = property.location || '-';
        const ownerName = property.ownerName || '-';
        const ownerContact = property.ownerContact || '-';

        tableHTML += '<tr>' +
          '<td>' + rowNum + '</td>' +
          '<td>' + propertyName + '</td>' +
          '<td>' + propertyType + '</td>' +
          '<td>' + priceDisplay + '</td>' +
          '<td>' + location + '</td>' +
          '<td>' + ownerName + '</td>' +
          '<td>' + ownerContact + '</td>' +
          '<td><span class="' + statusClass + '">' + statusText + '</span></td>' +
          '<td>' + createdDate + '</td>' +
          '<td class="action-btns">' +
          '<button class="btn-edit" onclick="openStatusModal(' + property.propertyNo + ', \'' + property.status + '\')"><i class="fa-solid fa-pen"></i> 수정</button>' +
          '<button class="btn-delete" onclick="deleteProperty(' + property.propertyNo + ')"><i class="fa-solid fa-trash"></i> 삭제</button>' +
          '</td>' +
          '</tr>';
      });

      tableHTML += '</tbody></table></div>';
      container.innerHTML = tableHTML;
    }

    function renderPagination(pageInfo) {
      const container = document.getElementById('pagination');
      container.innerHTML = '';

      // 첫 페이지로 이동 버튼
      const firstBtn = document.createElement('button');
      firstBtn.innerHTML = '<i class="fa-solid fa-angles-left"></i>';
      firstBtn.onclick = () => goToPage(1);
      firstBtn.disabled = pageInfo.first;
      container.appendChild(firstBtn);

      // 이전 페이지 버튼
      const prevBtn = document.createElement('button');
      prevBtn.innerHTML = '<i class="fa-solid fa-angle-left"></i>';
      prevBtn.onclick = () => goToPage(pageInfo.currentPage - 1);
      prevBtn.disabled = !pageInfo.hasPrevious;
      container.appendChild(prevBtn);

      // 페이지 번호 버튼들
      pageInfo.pageNumbers.forEach(pageNum => {
        const pageBtn = document.createElement('button');
        pageBtn.textContent = pageNum;
        pageBtn.onclick = () => goToPage(pageNum);
        if (pageNum === pageInfo.currentPage) {
          pageBtn.classList.add('active');
        }
        container.appendChild(pageBtn);
      });

      // 다음 페이지 버튼
      const nextBtn = document.createElement('button');
      nextBtn.innerHTML = '<i class="fa-solid fa-angle-right"></i>';
      nextBtn.onclick = () => goToPage(pageInfo.currentPage + 1);
      nextBtn.disabled = !pageInfo.hasNext;
      container.appendChild(nextBtn);

      // 마지막 페이지로 이동 버튼
      const lastBtn = document.createElement('button');
      lastBtn.innerHTML = '<i class="fa-solid fa-angles-right"></i>';
      lastBtn.onclick = () => goToPage(pageInfo.totalPages);
      lastBtn.disabled = pageInfo.last;
      container.appendChild(lastBtn);

      // 페이지 정보 표시
      const pageInfo_span = document.createElement('span');
      pageInfo_span.className = 'page-info';
      pageInfo_span.textContent = `${pageInfo.currentPage} / ${pageInfo.totalPages} 페이지`;
      container.appendChild(pageInfo_span);
    }

    function openStatusModal(propertyNo, currentStatus) {
      currentPropertyNo = propertyNo;
      document.getElementById('statusSelect').value = currentStatus;
      document.getElementById('statusModal').style.display = 'flex';
    }

    function closeStatusModal() {
      document.getElementById('statusModal').style.display = 'none';
      currentPropertyNo = null;
    }

    function confirmStatusChange() {
      const newStatus = document.getElementById('statusSelect').value;

      fetch('${pageContext.request.contextPath}/admin/api/properties/' + currentPropertyNo + '/status?status=' + newStatus, {
        method: 'PUT'
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          alert(data.message);
          closeStatusModal();
          goToPage(currentPage);
        } else {
          alert(data.message);
        }
      })
      .catch(error => {
        console.error('Error:', error);
        alert('상태 변경 중 오류가 발생했습니다.');
      });
    }

    function deleteProperty(propertyNo) {
      if (!confirm('정말 삭제하시겠습니까?\n삭제된 매물은 복구할 수 없습니다.')) {
        return;
      }

      fetch('${pageContext.request.contextPath}/admin/api/properties/' + propertyNo, {
        method: 'DELETE'
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          alert(data.message);
          goToPage(currentPage);
        } else {
          alert(data.message);
        }
      })
      .catch(error => {
        console.error('Error:', error);
        alert('삭제 중 오류가 발생했습니다.');
      });
    }
  </script>

<jsp:include page="/WEB-INF/views/common/admin-footer.jsp"/>
