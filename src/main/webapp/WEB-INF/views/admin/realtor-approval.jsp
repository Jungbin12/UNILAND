<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="currentPage" value="realtor-approval" scope="request"/>
<c:set var="pageTitle" value="UNILAND 관리자 - 중개사 승인" scope="request"/>
<%@ include file="../common/admin-header.jsp" %>

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

    /* 알림 메시지 */
    .alert {
      padding: 12px 20px;
      border-radius: 6px;
      margin-bottom: 20px;
      font-size: 14px;
    }
    .alert-success {
      background: #d4edda;
      color: #155724;
      border: 1px solid #c3e6cb;
    }
    .alert-error {
      background: #f8d7da;
      color: #721c24;
      border: 1px solid #f5c6cb;
    }

    /* 테이블 */
    table {
      width: 100%;
      background: white;
      border-collapse: collapse;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
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
    .badge.pending { background: #f59e0b; }
    .badge.approved { background: #48bb78; }
    .badge.rejected { background: #e53e3e; }

    /* 버튼 */
    .action-btns {
      display: flex;
      justify-content: center;
      gap: 4px;
    }
    .action-btns button, .action-btns form {
      display: inline-block;
    }
    .btn-detail, .btn-approve, .btn-reject, .btn-cancel {
      border: none;
      padding: 6px 12px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 13px;
      font-weight: 600;
      transition: all 0.2s;
    }
    .btn-detail { background: #667eea; color: white; }
    .btn-detail:hover { background: #5568d3; }
    .btn-approve { background: #48bb78; color: white; }
    .btn-approve:hover { background: #38a169; }
    .btn-reject { background: #e53e3e; color: white; }
    .btn-reject:hover { background: #c53030; }
    .btn-cancel { background: #f59e0b; color: white; }
    .btn-cancel:hover { background: #d97706; }

    /* 모달 스타일 */
    .modal-overlay {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.5);
      z-index: 1000;
      justify-content: center;
      align-items: center;
      animation: fadeIn 0.3s;
    }
    .modal-overlay.active {
      display: flex;
    }

    .modal-content {
      background: white;
      border-radius: 12px;
      width: 90%;
      max-width: 700px;
      max-height: 85vh;
      overflow-y: auto;
      box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
      animation: slideUp 0.3s;
    }

    .modal-header {
      padding: 24px;
      border-bottom: 2px solid #667eea;
      display: flex;
      justify-content: space-between;
      align-items: center;
      position: sticky;
      top: 0;
      background: white;
      z-index: 10;
    }
    .modal-header h3 {
      font-size: 20px;
      font-weight: 700;
      color: #1a1a1a;
    }
    .modal-close {
      background: none;
      border: none;
      font-size: 24px;
      color: #999;
      cursor: pointer;
      transition: color 0.2s;
    }
    .modal-close:hover {
      color: #333;
    }

    .modal-body {
      padding: 24px;
    }

    .detail-section {
      margin-bottom: 24px;
    }
    .detail-section h4 {
      font-size: 16px;
      font-weight: 600;
      color: #667eea;
      margin-bottom: 12px;
      padding-bottom: 8px;
      border-bottom: 1px solid #e5e5e5;
    }

    .detail-row {
      display: flex;
      padding: 10px 0;
      border-bottom: 1px solid #f5f5f5;
    }
    .detail-row:last-child {
      border-bottom: none;
    }
    .detail-label {
      width: 140px;
      font-weight: 600;
      color: #555;
      flex-shrink: 0;
    }
    .detail-value {
      flex: 1;
      color: #333;
    }

    .modal-footer {
      padding: 20px 24px;
      border-top: 1px solid #e5e5e5;
      display: flex;
      justify-content: flex-end;
      gap: 10px;
      position: sticky;
      bottom: 0;
      background: white;
    }
    .btn-modal-close {
      padding: 10px 24px;
      background: #e5e5e5;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-size: 14px;
      font-weight: 600;
      color: #333;
      transition: all 0.2s;
    }
    .btn-modal-close:hover {
      background: #d0d0d0;
    }

    /* 애니메이션 */
    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }
    @keyframes slideUp {
      from { 
        opacity: 0;
        transform: translateY(20px); 
      }
      to { 
        opacity: 1;
        transform: translateY(0);
      }
    }
  </style>

    <!-- 메인 콘텐츠 -->
    <!-- admin-header.jsp에서 시작된 main-content가 이어집니다 -->
      <div class="page-header">
        <h2>중개사 승인 관리</h2>
      </div>

      <!-- 알림 메시지 -->
      <c:if test="${not empty message}">
        <div class="alert alert-success">
          <i class="fa-solid fa-circle-check"></i> ${message}
        </div>
      </c:if>
      <c:if test="${not empty error}">
        <div class="alert alert-error">
          <i class="fa-solid fa-circle-exclamation"></i> ${error}
        </div>
      </c:if>

      <!-- 중개사 승인 테이블 -->
      <table>
        <thead>
          <tr>
            <th>No.</th>
            <th>신청자명</th>
            <th>업체명</th>
            <th>사업자등록번호</th>
            <th>연락처</th>
            <th>신청일</th>
            <th>상태</th>
            <th>관리</th>
          </tr>
        </thead>
        <tbody id="realtorTable">
          <c:forEach var="realtor" items="${realtorList}" varStatus="status">
            <tr>
              <td>${status.count}</td>
              <td>${realtor.realtorName}</td>
              <td>${realtor.officeName}</td>
              <td>${realtor.businessNum}</td>
              <td>${realtor.realtorPhone}</td>
              <td>
                <c:choose>
                  <c:when test="${not empty realtor.createdAt}">
                    <fmt:formatDate value="${realtor.createdAt}" pattern="yyyy-MM-dd"/>
                  </c:when>
                  <c:otherwise>-</c:otherwise>
                </c:choose>
              </td>
              <td>
                <c:choose>
                  <c:when test="${realtor.approvalStatus == 'PENDING'}">
                    <span class="badge pending">승인대기</span>
                  </c:when>
                  <c:when test="${realtor.approvalStatus == 'APPROVAL'}">
                    <span class="badge approved">승인완료</span>
                  </c:when>
                  <c:when test="${realtor.approvalStatus == 'REJECTED'}">
                    <span class="badge rejected">거부됨</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge pending">-</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td class="action-btns">
                <!-- 상세보기 버튼 (모달 열기) -->
                <button class="btn-detail" onclick="openDetailModal('${realtor.realtorId}')">
                  <i class="fa-solid fa-file-lines"></i> 상세
                </button>
                
                <!-- 승인대기 상태 -->
                <c:if test="${realtor.approvalStatus == 'PENDING'}">
                  <form action="${pageContext.request.contextPath}/admin/realtor-approve/${realtor.realtorId}" 
                        method="post" style="display:inline;">
                    <button type="submit" class="btn-approve" 
                            onclick="return confirm('중개사를 승인하시겠습니까?')">
                      <i class="fa-solid fa-check"></i> 승인
                    </button>
                  </form>
                  <form action="${pageContext.request.contextPath}/admin/realtor-reject/${realtor.realtorId}" 
                        method="post" style="display:inline;">
                    <button type="submit" class="btn-reject" 
                            onclick="return confirm('중개사를 거부하시겠습니까?')">
                      <i class="fa-solid fa-xmark"></i> 거부
                    </button>
                  </form>
                </c:if>
                
                <!-- 승인완료 상태 -->
                <c:if test="${realtor.approvalStatus == 'APPROVAL'}">
                  <form action="${pageContext.request.contextPath}/admin/realtor-cancel/${realtor.realtorId}" 
                        method="post" style="display:inline;">
                    <button type="submit" class="btn-reject" 
                            onclick="return confirm('승인을 취소하시겠습니까?')">
                      <i class="fa-solid fa-ban"></i> 승인취소
                    </button>
                  </form>
                </c:if>
                
                <!-- 거부됨 상태 -->
                <c:if test="${realtor.approvalStatus == 'REJECTED'}">
                  <form action="${pageContext.request.contextPath}/admin/realtor-approve/${realtor.realtorId}" 
                        method="post" style="display:inline;">
                    <button type="submit" class="btn-cancel" 
                            onclick="return confirm('재승인하시겠습니까?')">
                      <i class="fa-solid fa-rotate-right"></i> 재승인
                    </button>
                  </form>
                </c:if>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty realtorList}">
            <tr>
              <td colspan="8" style="text-align: center; color: #999; padding: 40px;">
                등록된 중개사가 없습니다.
              </td>
            </tr>
          </c:if>
        </tbody>
      </table>

  <!-- 상세보기 모달 -->
  <div class="modal-overlay" id="detailModal">
    <div class="modal-content">
      <div class="modal-header">
        <h3><i class="fa-solid fa-user-tie"></i> 중개사 상세 정보</h3>
        <button class="modal-close" onclick="closeDetailModal()">
          <i class="fa-solid fa-xmark"></i>
        </button>
      </div>
      <div class="modal-body">
        <div class="detail-section">
          <h4>기본 정보</h4>
          <div class="detail-row">
            <div class="detail-label">아이디</div>
            <div class="detail-value" id="modal-realtorId">-</div>
          </div>
          <div class="detail-row">
            <div class="detail-label">대표자명</div>
            <div class="detail-value" id="modal-realtorName">-</div>
          </div>
          <div class="detail-row">
            <div class="detail-label">중개사무소명</div>
            <div class="detail-value" id="modal-officeName">-</div>
          </div>
        </div>

        <div class="detail-section">
          <h4>연락처 정보</h4>
          <div class="detail-row">
            <div class="detail-label">연락처</div>
            <div class="detail-value" id="modal-realtorPhone">-</div>
          </div>
          <div class="detail-row">
            <div class="detail-label">이메일</div>
            <div class="detail-value" id="modal-realtorEmail">-</div>
          </div>
          <div class="detail-row">
            <div class="detail-label">주소</div>
            <div class="detail-value" id="modal-realtorAddress">-</div>
          </div>
        </div>

        <div class="detail-section">
          <h4>사업자 정보</h4>
          <div class="detail-row">
            <div class="detail-label">중개사 등록번호</div>
            <div class="detail-value" id="modal-realtorRegNum">-</div>
          </div>
          <div class="detail-row">
            <div class="detail-label">사업자등록번호</div>
            <div class="detail-value" id="modal-businessNum">-</div>
          </div>
        </div>

        <div class="detail-section">
          <h4>승인 정보</h4>
          <div class="detail-row">
            <div class="detail-label">승인 상태</div>
            <div class="detail-value" id="modal-approvalStatus">-</div>
          </div>
          <div class="detail-row">
            <div class="detail-label">신청일</div>
            <div class="detail-value" id="modal-createdAt">-</div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn-modal-close" onclick="closeDetailModal()">
          <i class="fa-solid fa-xmark"></i> 닫기
        </button>
      </div>
    </div>
  </div>

  <script>
    const contextPath = '${pageContext.request.contextPath}';

    // 상세보기 모달 열기
    function openDetailModal(realtorId) {
      fetch(contextPath + '/admin/realtor-detail/' + realtorId)
        .then(res => res.json())
        .then(data => {
          if (data.success) {
            const realtor = data.realtor;
            
            // 기본 정보
            document.getElementById('modal-realtorId').textContent = realtor.realtorId || '-';
            document.getElementById('modal-realtorName').textContent = realtor.realtorName || '-';
            document.getElementById('modal-officeName').textContent = realtor.officeName || '-';
            
            // 연락처 정보
            document.getElementById('modal-realtorPhone').textContent = realtor.realtorPhone || '-';
            document.getElementById('modal-realtorEmail').textContent = realtor.realtorEmail || '-';
            document.getElementById('modal-realtorAddress').textContent = realtor.realtorAddress || '-';
            
            // 사업자 정보
            document.getElementById('modal-realtorRegNum').textContent = realtor.realtorRegNum || '-';
            document.getElementById('modal-businessNum').textContent = realtor.businessNum || '-';
            
            // 승인 정보
            let statusText = '-';
            let statusColor = '#999';
            if (realtor.approvalStatus === 'PENDING') {
              statusText = '승인대기';
              statusColor = '#f59e0b';
            } else if (realtor.approvalStatus === 'APPROVAL') {
              statusText = '승인완료';
              statusColor = '#48bb78';
            } else if (realtor.approvalStatus === 'REJECTED') {
              statusText = '거부됨';
              statusColor = '#e53e3e';
            }
            document.getElementById('modal-approvalStatus').innerHTML = 
              '<span style="color: ' + statusColor + '; font-weight: 600;">' + statusText + '</span>';
            
            document.getElementById('modal-createdAt').textContent = realtor.createdAt || '-';
            
            // 모달 표시
            document.getElementById('detailModal').classList.add('active');
          } else {
            alert('중개사 정보를 불러올 수 없습니다.');
          }
        })
        .catch(err => {
          console.error('Error:', err);
          alert('중개사 정보를 불러오는 중 오류가 발생했습니다.');
        });
    }

    // 상세보기 모달 닫기
    function closeDetailModal() {
      document.getElementById('detailModal').classList.remove('active');
    }

    // 모달 배경 클릭 시 닫기
    document.getElementById('detailModal').addEventListener('click', function(e) {
      if (e.target === this) {
        closeDetailModal();
      }
    });

    // ESC 키로 모달 닫기
    document.addEventListener('keydown', function(e) {
      if (e.key === 'Escape') {
        closeDetailModal();
      }
    });

    // 알림 메시지 자동 사라지기
    setTimeout(function() {
      const alerts = document.querySelectorAll('.alert');
      alerts.forEach(alert => {
        alert.style.transition = 'opacity 0.5s';
        alert.style.opacity = '0';
        setTimeout(() => alert.remove(), 500);
      });
    }, 3000);
  </script>

<%@ include file="../common/admin-footer.jsp" %>