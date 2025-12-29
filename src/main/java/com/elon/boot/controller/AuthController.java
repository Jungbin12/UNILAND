package com.elon.boot.controller;

import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.elon.boot.domain.user.model.service.UserService;
import com.elon.boot.domain.user.model.vo.User;
import com.elon.boot.domain.realtor.model.service.RealtorService;
import com.elon.boot.domain.realtor.model.vo.Realtor;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final UserService userService;
    private final RealtorService realtorService; // 중개사 서비스

    // 로그인 페이지
    @GetMapping("/login")
    public String loginPage(@RequestParam(required = false) String redirectUrl, Model model) {
        model.addAttribute("redirectUrl", redirectUrl);
        return "auth/login";
    }

    // 로그인 처리
    @PostMapping("/login")
    public String login(@RequestParam String userId,
                        @RequestParam String userPassword,
                        @RequestParam(required = false) String redirectUrl,
                        HttpSession session,
                        RedirectAttributes redirectAttributes) {
        User user = userService.login(userId, userPassword);

        if (user != null) {
            session.setAttribute("loginUser", user);
            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                return "redirect:" + redirectUrl;
            }
            return "redirect:/";
        } else {
            redirectAttributes.addFlashAttribute("errorMsg", "아이디 또는 비밀번호가 일치하지 않습니다.");
            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                return "redirect:/auth/login?redirectUrl=" + redirectUrl;
            }
            return "redirect:/auth/login";
        }
    }

    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    // 회원가입 페이지
    @GetMapping("/signup")
    public String signupPage() {
        return "auth/signup";
    }

    // 회원가입 처리
    @PostMapping("/signup")
    public String signup(User user, RedirectAttributes redirectAttributes) {
        try {
            if (userService.checkDuplicateId(user.getUserId())) {
                redirectAttributes.addFlashAttribute("errorMsg", "이미 사용 중인 아이디입니다.");
                return "redirect:/auth/signup";
            }

            if (user.getBirthDate() != null) {
                java.time.LocalDate birthDate = user.getBirthDate().toLocalDate();
                java.time.LocalDate now = java.time.LocalDate.now();
                int age = now.getYear() - birthDate.getYear();
                if (now.getMonthValue() < birthDate.getMonthValue() ||
                    (now.getMonthValue() == birthDate.getMonthValue() && now.getDayOfMonth() < birthDate.getDayOfMonth())) {
                    age--;
                }
                user.setUserAge(age);
            }

            int result = userService.signUp(user);

            if (result > 0) {
                redirectAttributes.addFlashAttribute("successMsg", "회원가입이 완료되었습니다.");
                return "redirect:/auth/login";
            } else {
                redirectAttributes.addFlashAttribute("errorMsg", "회원가입에 실패했습니다.");
                return "redirect:/auth/signup";
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMsg", "오류가 발생했습니다: " + e.getMessage());
            return "redirect:/auth/signup";
        }
    }

    // 비밀번호 찾기 페이지
    @GetMapping("/find-password")
    public String findPasswordPage() {
        return "auth/find-password";
    }

    // 비밀번호 찾기 처리 (자동 판별: 이메일 또는 전화번호만으로 일반회원/중개사 찾기)
    @PostMapping("/find-password")
    public String findPassword(@RequestParam String userId,
                               @RequestParam String userName,
                               @RequestParam(required = false) String userEmail,
                               @RequestParam(required = false) String userPhone,
                               @RequestParam String searchType,
                               Model model) {

        // 먼저 일반회원(User) 검색
        User user = null;
        if ("email".equals(searchType) && userEmail != null) {
            user = userService.getUserByEmail(userEmail);
            if (user != null && (!user.getUserId().equals(userId) || !user.getUserName().equals(userName))) {
                user = null;
            }
        } else if ("phone".equals(searchType) && userPhone != null) {
            user = userService.getUserByPhone(userPhone);
            if (user != null && (!user.getUserId().equals(userId) || !user.getUserName().equals(userName))) {
                user = null;
            }
        }

        if (user != null) {
            model.addAttribute("user", user);
            model.addAttribute("successMsg", "회원 정보를 찾았습니다.");
            model.addAttribute("searchType", searchType);
            return "auth/find-password";
        }

        // 일반회원이 없으면 중개사(Realtor) 검색
        Realtor realtor = null;
        if ("email".equals(searchType) && userEmail != null) {
            realtor = realtorService.getRealtorById(userId);
            if (realtor != null && (!realtor.getRealtorName().equals(userName) ||
                                     !realtor.getRealtorEmail().equals(userEmail))) {
                realtor = null;
            }
        } else if ("phone".equals(searchType) && userPhone != null) {
            realtor = realtorService.getRealtorById(userId);
            if (realtor != null && (!realtor.getRealtorName().equals(userName) ||
                                     !realtor.getRealtorPhone().equals(userPhone))) {
                realtor = null;
            }
        }

        if (realtor != null) {
            model.addAttribute("realtor", realtor);
            model.addAttribute("successMsg", "중개사 정보를 찾았습니다.");
        } else if (user == null) {
            model.addAttribute("errorMsg", "입력하신 정보와 일치하는 회원 또는 중개사가 없습니다.");
        }

        model.addAttribute("searchType", searchType);
        return "auth/find-password";
    }

    // 중개사 회원가입 페이지
    @GetMapping("/signup-realtor")
    public String signupRealtorPage() {
        return "auth/signup-realtor"; 
    }

    // 중개사 회원가입 처리
    @PostMapping("/signup-realtor")
    public String signupRealtor() {
        // TODO: 중개사 회원가입 로직 구현
        return "redirect:/auth/login";
    }

    // 중개사 로그인 페이지
    @GetMapping("/realtor-login")
    public String realtorLogin() {
        return "/auth/realtor-login";
    }
}
