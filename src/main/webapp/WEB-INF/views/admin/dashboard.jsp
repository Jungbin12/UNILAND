<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="UNILAND 관리자 페이지" />
<c:set var="currentPage" value="dashboard" />
<jsp:include page="/WEB-INF/views/common/admin-header.jsp"/>

  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    .dashboard-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 24px;
    }
    .dashboard-header h2 {
      font-size: 24px;
      font-weight: 700;
      color: #1a1a1a;
    }

    /* 통계 카드 */
    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 20px;
      margin-bottom: 40px;
    }

    .stat-card {
      background: white;
      border-radius: 8px;
      padding: 24px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      border: 1px solid #e5e5e5;
      display: flex;
      align-items: center;
      justify-content: space-between;
      transition: transform 0.2s;
    }

    .stat-card:hover { transform: translateY(-3px); }

    .stat-card i {
      font-size: 28px;
      color: #667eea;
    }

    .stat-info h4 {
      font-size: 13px;
      color: #666;
      margin-bottom: 6px;
    }

    .stat-info p {
      font-size: 20px;
      font-weight: 700;
      color: #1a1a1a;
    }

    /* 차트 */
    .chart-container {
      background: white;
      border-radius: 8px;
      padding: 24px;
      border: 1px solid #e5e5e5;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      margin-bottom: 40px;
    }

    .chart-container h3 {
      font-size: 16px;
      margin-bottom: 20px;
      color: #1a1a1a;
    }

    /* 최근 공지사항 */
    .notice-list {
      background: white;
      border-radius: 8px;
      border: 1px solid #e5e5e5;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      padding: 24px;
    }

    .notice-list h3 {
      font-size: 16px;
      margin-bottom: 20px;
      color: #1a1a1a;
    }

    .notice-list table {
      width: 100%;
      border-collapse: collapse;
    }

    .notice-list th, .notice-list td {
      padding: 12px;
      border-bottom: 1px solid #f0f0f0;
      text-align: left;
      font-size: 14px;
    }

    .notice-list th {
      background: #f5f5f5;
      color: #555;
      font-weight: 600;
    }

    .notice-list tr:hover td {
      background: #f9faff;
      cursor: pointer;
    }
  </style>

      <div class="dashboard-header">
        <h2>관리자 대시보드</h2>
      </div>

      <!-- 통계 카드 -->
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-info">
            <h4>총 일반 회원 수</h4>
            <p>${dashboard.totalUsers}명</p>
          </div>
          <i class="fa-solid fa-user-group"></i>
        </div>

        <div class="stat-card">
          <div class="stat-info">
            <h4>총 중개사 회원 수</h4>
            <p>${dashboard.totalRealtors}명</p>
          </div>
          <i class="fa-solid fa-user-group"></i>
        </div>

        <div class="stat-card">
          <div class="stat-info">
            <h4>등록 매물</h4>
            <p>${dashboard.totalProperties}건</p>
          </div>
          <i class="fa-solid fa-building"></i>
        </div>

        <div class="stat-card">
          <div class="stat-info">
            <h4>미처리 문의</h4>
            <p>${dashboard.pendingInquiries}건</p>
          </div>
          <i class="fa-solid fa-envelope-circle-check"></i>
        </div>
      </div>

      <!-- 차트 -->
      <div class="chart-container">
        <h3>일별 신규 회원 현황 (최근 30일)</h3>
        <canvas id="userChart" height="80"></canvas>
      </div>

      <!-- 최근 공지사항 -->
      <div class="notice-list">
        <h3>최근 공지사항</h3>
        <table>
          <thead>
            <tr>
              <th>번호</th>
              <th>제목</th>
              <th>등록일</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="notice" items="${noticeList}" varStatus="status">
              <tr onclick="location.href='${pageContext.request.contextPath}/community/notice/${notice.noticeNo}'">
                <td>${notice.noticeNo}</td>
                <td>${notice.noticeSubject}</td>
                <td><fmt:formatDate value="${notice.noticeCreateat}" pattern="yyyy-MM-dd"/></td>
              </tr>
            </c:forEach>
            <c:if test="${empty noticeList}">
		            <li style="color: #999; cursor: default;">등록된 공지사항이 없습니다.</li>
		    </c:if>
          </tbody>
        </table>
      </div>

  <script>
    // 차트 데이터 (서버에서 전달받은 데이터)
    const dailyLabels = [
      <c:forEach var="label" items="${dashboard.dailyLabels}" varStatus="status">
        '${label}'<c:if test="${!status.last}">,</c:if>
      </c:forEach>
    ];

    const dailyData = [
      <c:forEach var="data" items="${dashboard.dailyUserData}" varStatus="status">
        ${data}<c:if test="${!status.last}">,</c:if>
      </c:forEach>
    ];

    // 회원 증감 차트
    const ctx = document.getElementById('userChart').getContext('2d');
    new Chart(ctx, {
      type: 'line',
      data: {
        labels: dailyLabels.length > 0 ? dailyLabels : ['데이터 없음'],
        datasets: [{
          label: '신규 회원 수',
          data: dailyData.length > 0 ? dailyData : [0],
          borderColor: '#667eea',
          backgroundColor: 'rgba(102, 126, 234, 0.15)',
          fill: true,
          tension: 0.3,
          pointRadius: 2,
          pointHoverRadius: 5
        }]
      },
      options: {
        plugins: {
          legend: { display: false },
          tooltip: {
            callbacks: {
              label: function(context) {
                return '신규 회원: ' + context.parsed.y + '명';
              }
            }
          }
        },
        scales: {
          x: {
            ticks: {
              maxRotation: 45,
              minRotation: 45,
              autoSkip: true,
              maxTicksLimit: 15
            }
          },
          y: {
            beginAtZero: true,
            ticks: { stepSize: 5 }
          }
        },
        interaction: {
          intersect: false,
          mode: 'index'
        }
      }
    });
  </script>

<jsp:include page="/WEB-INF/views/common/admin-footer.jsp"/>
