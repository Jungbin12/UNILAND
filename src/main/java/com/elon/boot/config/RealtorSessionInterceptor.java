package com.elon.boot.config;

import com.elon.boot.domain.realtor.model.vo.Realtor;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

public class RealtorSessionInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        String uri = request.getRequestURI();

        // 로그인 및 공개 요청 제외
        if (uri.contains("/realtor-login") ||
            uri.contains("/register") ||
            uri.contains("/check-") ||
            uri.contains("/profile/updateImage")) {
            return true;
        }

        HttpSession session = request.getSession(false);
        Realtor loginRealtor = (session != null) ? (Realtor) session.getAttribute("loginRealtor") : null;

        if (loginRealtor == null) {
            // 세션 만료 → 메인홈으로 리다이렉트 + 메시지 쿼리 파라미터 추가
            response.sendRedirect(request.getContextPath() + "/?sessionExpired=true");
            return false;
        }

        return true;
    }
}
