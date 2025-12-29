package com.elon.boot.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.elon.boot.controller.dto.inquiry.ContactAdmin;
import com.elon.boot.domain.inquiry.model.service.InquiryService;
import com.elon.boot.domain.inquiry.model.vo.Inquiry;
import com.elon.boot.domain.user.model.vo.User;

import com.elon.boot.domain.property.model.service.PropertyService;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.property.model.vo.PropertyImg;
import com.elon.boot.domain.property.model.vo.PropertyOption;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/inquiries")
@RequiredArgsConstructor
@Slf4j
public class InquiryController {

    private final InquiryService inquiryService;
    
    private final PropertyService propertyService;

    // TODO: 중개사 문의 페이지
    @GetMapping("/realtor")
    public String realtorInquiryPage(@RequestParam("propertyId") int propertyId, Model model) {
        
        // --- 매물 정보/옵션/썸네일 조회 로직 추가 ---
        try {
            // (참고: int를 Long으로 형변환)
            long id = (long) propertyId; 

            // 1. 기본 매물 정보 조회
            Property property = propertyService.selectOneByNo(id);

            // 2. 옵션 정보 조회
            PropertyOption options = propertyService.selectOnesOption(id);

            // 3. 썸네일 이미지 조회 (이미지 리스트의 첫 번째를 썸네일로 사용)
            List<PropertyImg> images = propertyService.selectOnesImgs(id);
            PropertyImg thumbnail = (images != null && !images.isEmpty()) ? images.get(0) : null;

            // 4. Model에 3개 객체를 각각 담아서 JSP로 전달
            model.addAttribute("property", property);
            model.addAttribute("options", options);     // ★ ${options} 라는 이름으로 전달
            model.addAttribute("thumbnail", thumbnail); // ★ ${thumbnail} 이라는 이름으로 전달

        } catch (Exception e) {
            e.printStackTrace(); // 서버 로그에 에러 출력
            // 여기서 model.addAttribute를 안하면,
            // JSP의 <c:if test="${empty property}">에 걸려서
            // "매물 정보를 불러올 수 없습니다."가 정상적으로 뜹니다.
        }
        // --- ▲▲▲ 3. 조회 로직 끝 ▲▲▲ ---

        return "inquiry/contact-realtor";
    }

    // TODO: 중개사 문의 제출
    @PostMapping("/realtor")
    public String submitRealtorInquiry(@ModelAttribute Inquiry inquiry,
                                       @RequestParam("contactPhone") String contactPhone,
                                       @RequestParam("inquiryCategory") String inquiryCategory,
                                       @RequestParam("inquiryTitle") String inquiryTitle,
                                       @RequestParam("inquiryContent") String inquiryContent,
                                       HttpSession session,
                                       RedirectAttributes redirectAttributes) {
        
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/auth/login";
        }
        
        try {
            // Inquiry 객체 설정
            inquiry.setUserId(loginUser.getUserId());
            inquiry.setUserName(loginUser.getUserName());
            inquiry.setUserPhone(contactPhone);
            inquiry.setInquiryType("REALTOR");
            inquiry.setCategory(inquiryCategory);
            inquiry.setTitle(inquiryTitle);
            inquiry.setContent(inquiryContent);
            inquiry.setStatus("PENDING");
            inquiry.setDeleteYn("N");
            inquiry.setReadYn("N");
            
            log.info("중개사 문의 등록: {}", inquiry);
            
            int result = inquiryService.createInquiry(inquiry);
            
            if (result > 0) {
                redirectAttributes.addFlashAttribute("message", "문의가 성공적으로 전송되었습니다.");
                return "redirect:/mypage?tab=inquiries";
            } else {
                redirectAttributes.addFlashAttribute("error", "문의 등록에 실패했습니다.");
                return "redirect:/inquiries/realtor?propertyId=" + inquiry.getPropertyId();
            }
            
        } catch (Exception e) {
            log.error("중개사 문의 등록 실패: ", e);
            redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다.");
            return "redirect:/inquiries/realtor?propertyId=" + inquiry.getPropertyId();
        }
    }

    // TODO: 관리자 문의 페이지
    // @GetMapping("/admin")
    // public String adminInquiryPage(Model model) {
    //     return "inquiry/contact-admin";
    // }

    // TODO: 관리자 문의 제출
    // @PostMapping("/admin")
    // public String submitAdminInquiry(Inquiry inquiry) {
    //     return "redirect:/mypage?tab=inquiries";
    // }

    // TODO: 내 문의 내역 조회 (AJAX)
    // @GetMapping("/list")
    // @ResponseBody
    // public List<Inquiry> getMyInquiries(HttpSession session) {
    //     return inquiryService.getUserInquiries(userId);
    // }
    
    /**
     * 관리자 문의 페이지 이동
     */
    @GetMapping("/contact-admin")
    public String contactAdminPage(HttpSession session, Model model) {
    	// 로그인 확인
        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            log.warn("로그인되지 않은 사용자의 문의 페이지 접근 시도");
            return "redirect:/auth/login";
        }
        
        log.info("관리자 문의 페이지 접근: userId={}", user.getUserId());
        
        model.addAttribute("loginUser", user);
        return "inquiry/contact-admin";
    }

    /**
     * 관리자 문의 등록 처리
     */
    @PostMapping("/contact-admin")
    public String submitInquiry(
    		@ModelAttribute Inquiry inquiry,
            @ModelAttribute ContactAdmin cAdmin,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        try {
        	// 로그인 확인
            User user = (User) session.getAttribute("loginUser");
            if (user == null) {
                log.warn("로그인되지 않은 사용자의 중개사 문의 등록 시도");
                redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
                return "redirect:/auth/login";
            }

            // Inquiry 객체 생성
            inquiry.setUserId(user.getUserId());
            inquiry.setUserName(user.getUserName());
            inquiry.setUserPhone(user.getUserPhone());
            inquiry.setInquiryType("ADMIN");  // 관리자 문의
            inquiry.setCategory(cAdmin.getCategory());
            inquiry.setTitle(cAdmin.getTitle());
            inquiry.setContent(cAdmin.getContent());
            inquiry.setPropertyId(cAdmin.getPropertyId());      // NULL
            inquiry.setRealtorId(cAdmin.getRealtorId());
            inquiry.setStatus("PENDING");     // 기본값
            inquiry.setReadYn("N");           // 미읽음
            inquiry.setDeleteYn("N");         // 활성
            
            log.info("관리자 문의 등록 시작: userId={}, category={}, title={}", user.getUserId(), cAdmin.getCategory(), cAdmin.getTitle());
            
            if (inquiry.getPropertyId() == null || inquiry.getPropertyId() == 0) {
                inquiry.setPropertyId(null);
            }
            if (inquiry.getRealtorId() == null || inquiry.getRealtorId() == null) {
                inquiry.setRealtorId(null);
            }
            
            // 문의 등록
            int result = inquiryService.insertInquiry(inquiry);
            
            
            if (result > 0) {
                log.info("관리자 문의 등록 성공: inquiryId={}, userId={}", inquiry.getInquiryId(), user.getUserId());
                redirectAttributes.addFlashAttribute("message", "문의가 성공적으로 등록되었습니다. 빠른 시일 내에 답변드리겠습니다.");
            } else {
                log.warn("관리자 문의 등록 실패: userId={}", user.getUserId());
                redirectAttributes.addFlashAttribute("error", "문의 등록에 실패했습니다. 다시 시도해주세요.");
                return "redirect:/inquiries/contact-admin";
            }
            
        } catch (Exception e) {
        	User user = (User) session.getAttribute("loginUser");
            log.error("관리자 문의 등록 중 오류 발생: userId={}", user.getUserId(), e);
            redirectAttributes.addFlashAttribute("error", "문의 등록 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/inquiries/contact-admin";
        }
        
        // 마이페이지 문의내역 탭으로 리다이렉트
        return "redirect:/mypage?tab=inquiries";
    }
    
    /**
     * 문의 읽음 처리 (마이페이지에서 상세보기 클릭 시 호출)
     */
    @PostMapping("/mark-as-read")
    public String markInquiryAsRead(
            @RequestParam("inquiryId") int inquiryId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        try {
            // 로그인 확인
            User user = (User) session.getAttribute("loginUser");
            if (user == null) {
                log.warn("로그인되지 않은 사용자의 문의 읽음 처리 시도");
                return "redirect:/auth/login";
            }

            // 문의 조회
            Inquiry inquiry = inquiryService.getInquiryById(inquiryId);
            
            if (inquiry == null) {
                log.warn("존재하지 않는 문의: inquiryId={}", inquiryId);
                return "redirect:/mypage?tab=inquiries";
            }

            // 권한 확인 (본인의 문의만)
            if (!inquiry.getUserId().equals(user.getUserId())) {
                log.warn("권한 없는 사용자의 문의 읽음 처리 시도: userId={}, inquiryUserId={}", 
                        user.getUserId(), inquiry.getUserId());
                return "redirect:/mypage?tab=inquiries";
            }

            // 읽음 처리
            if ("N".equals(inquiry.getReadYn())) {
                int result = inquiryService.markInquiryAsRead(inquiryId);
                if (result > 0) {
                    log.info("문의 읽음 처리 성공: inquiryId={}", inquiryId);
                }
            }
            
        } catch (Exception e) {
            log.error("문의 읽음 처리 중 오류 발생: inquiryId={}", inquiryId, e);
        }
        
        return "redirect:/mypage?tab=inquiries";
    }
}
