<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    </main>
  </div>

  <!-- 푸터 -->
  <footer style="background: #2a2a2a; color: #999; padding: 40px 0; border-top: 1px solid #3a3a3a; text-align: center; font-size: 13px;">
    © 2025 UNILAND Admin. All rights reserved.
  </footer>

  <script>
    // 사이드바 메뉴 클릭
    document.querySelectorAll('.sidebar li').forEach((item, index) => {
      item.addEventListener('click', function() {
        document.querySelectorAll('.sidebar li').forEach(li => li.classList.remove('active'));
        this.classList.add('active');

        const pages = [
          '${pageContext.request.contextPath}/admin/dashboard',
          '${pageContext.request.contextPath}/admin/user-management',
          '${pageContext.request.contextPath}/admin/property-management',
          '${pageContext.request.contextPath}/admin/content-management',
          '${pageContext.request.contextPath}/admin/inquiry-management',
          '${pageContext.request.contextPath}/admin/realtor-approval'
        ];

        if (pages[index]) {
          window.location.href = pages[index];
        }
      });
    });

    // 로고 클릭
    document.querySelector('.logo').addEventListener('click', function() {
      window.location.href = '${pageContext.request.contextPath}/uniland';
    });

    // 로그아웃
    function logout() {
      if (confirm('로그아웃 하시겠습니까?')) {
        location.href = '${pageContext.request.contextPath}/auth/logout';
      }
    }
  </script>
</body>
</html>
