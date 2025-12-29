package com.elon.boot.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.elon.boot.controller.dto.admin.Dashboard;
import com.elon.boot.controller.dto.admin.PageRequestDTO;
import com.elon.boot.controller.dto.admin.PageResponseDTO;
import com.elon.boot.controller.dto.admin.PropertyAdminDTO;
import com.elon.boot.controller.dto.admin.RealtorApproval;
import com.elon.boot.controller.dto.admin.UserManagement;
import com.elon.boot.domain.admin.model.service.AdminService;
import com.elon.boot.domain.community.notice.model.service.NoticeService;
import com.elon.boot.domain.community.notice.model.vo.Notice;
import com.elon.boot.domain.inquiry.model.service.InquiryService;
import com.elon.boot.domain.inquiry.model.vo.Inquiry;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import com.elon.boot.domain.user.model.vo.User;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
@Slf4j
public class AdminController {
	
	private final AdminService adminService;
	private final NoticeService noticeService;
	private final InquiryService inquiryService;

    // 대시보드
    @GetMapping("/dashboard")
    public String dashboard(Model model, 
    						HttpSession session, 
    						RedirectAttributes redirectAttributes) {
    	
    	// 관리자 권한 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
            redirectAttributes.addFlashAttribute("error", "관리자 권한이 필요합니다.");
            return "redirect:/";
        }
        
        try {
            Dashboard dashboard = adminService.getDashboardData();
            model.addAttribute("dashboard", dashboard);
            
            log.debug("대시보드 로드: 회원 {} 명, 매물 {} 건", 
                dashboard.getTotalUsers(), 
                dashboard.getTotalProperties(), 
                dashboard.getTotalRealtors());
            
        } catch (Exception e) {
            log.error("대시보드 로드 실패: ", e);
            model.addAttribute("error", "대시보드를 불러올 수 없습니다.");
        }
        
        try {
            // 최근 공지사항 5개 조회
            List<Notice> noticeList = noticeService.getRecentNotices(5);
            model.addAttribute("noticeList", noticeList);
            
            log.debug("메인 페이지 공지사항 조회: {} 건", noticeList != null ? noticeList.size() : 0);
            
        } catch (Exception e) {
            log.error("메인 페이지 공지사항 조회 실패: ", e);
            // 에러가 발생해도 페이지는 표시되도록 함
        }
    	
        return "admin/dashboard";
    }

    // 회원관리
    @GetMapping("/user-management")
    public String userManagement(Model model) {
    	UserManagement data = adminService.getUserManagementData();
    	
    	model.addAttribute("userList", data.getUserList());
        model.addAttribute("realtorList", data.getRealtorList());
        
        return "admin/user-management";
    }
    
    // 회원 탈퇴 처리
    @PostMapping("/user-delete/{userId}")
    public String userDelete(@PathVariable String userId,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        // 관리자 권한 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
            redirectAttributes.addFlashAttribute("error", "관리자 권한이 필요합니다.");
            return "redirect:/";
        }
        
        try {
            int result = adminService.deleteUser(userId);
            
            if (result > 0) {
                redirectAttributes.addFlashAttribute("message", "회원이 탈퇴 처리되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("error", "회원 탈퇴 처리에 실패했습니다.");
            }
        } catch (Exception e) {
            log.error("회원 탈퇴 처리 실패: ", e);
            redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다.");
        }
        
        return "redirect:/admin/user-management";
    }
    
    // 중개사 탈퇴 처리
    @PostMapping("/realtor-delete/{realtorId}")
    public String realtorDelete(@PathVariable String realtorId,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        // 관리자 권한 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
            redirectAttributes.addFlashAttribute("error", "관리자 권한이 필요합니다.");
            return "redirect:/";
        }
        
        try {
            int result = adminService.deleteRealtor(realtorId);
            
            if (result > 0) {
                redirectAttributes.addFlashAttribute("message", "중개사 탈퇴 처리되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("error", "중개사 탈퇴 처리에 실패했습니다.");
            }
        } catch (Exception e) {
            log.error("회원 탈퇴 처리 실패: ", e);
            redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다.");
        }
        
        return "redirect:/admin/user-management";
    }

    /**
     * 매물관리 페이지
     */
    @GetMapping("/property-management")
    public String propertyManagementPage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model) {
        
        log.info("매물관리 페이지 요청 - 페이지: {}, 크기: {}", page, size);
        
        PageRequestDTO pageRequest = PageRequestDTO.builder()
            .page(page)
            .size(size)
            .build();
        
        PageResponseDTO<PropertyAdminDTO> response = adminService.getPropertyListWithPaging(pageRequest);
        
        model.addAttribute("propertyList", response.getContent());
        model.addAttribute("pageInfo", response);
        
        return "admin/property-management";
    }
    
    /**
     * 매물 검색 API (페이징 포함)
     */
    @GetMapping("/api/properties/search")
    @ResponseBody
    public ResponseEntity<PageResponseDTO<PropertyAdminDTO>> searchProperties(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false, defaultValue = "") String searchCategory,
            @RequestParam(required = false, defaultValue = "") String searchKeyword) {
        
        log.info("매물 검색 API 호출 - 페이지: {}, 크기: {}, 카테고리: {}, 키워드: {}", 
            page, size, searchCategory, searchKeyword);
        
        try {
            PageRequestDTO pageRequest = PageRequestDTO.builder()
                .page(page)
                .size(size)
                .searchCategory(searchCategory)
                .searchKeyword(searchKeyword)
                .build();
            
            PageResponseDTO<PropertyAdminDTO> pageResponse = adminService.getPropertyListWithPaging(pageRequest);
            
            log.info("검색 결과 - 전체: {}, 현재 페이지: {}/{}", 
                pageResponse.getTotalElements(), 
                pageResponse.getCurrentPage(), 
                pageResponse.getTotalPages());
            
            return ResponseEntity.ok(pageResponse);
            
        } catch (Exception e) {
            log.error("매물 검색 중 오류 발생", e);
            return ResponseEntity.status(500).build();
        }
    }
    
    /**
     * 매물 상태 변경 API (수정 버튼)
     */
    @PutMapping("/api/properties/{propertyNo}/status")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updatePropertyStatus(
            @PathVariable Long propertyNo,
            @RequestParam String status) {
        
        log.info("매물 상태 변경 API 호출 - 매물번호: {}, 상태: {}", propertyNo, status);
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            boolean success = adminService.updatePropertyStatus(propertyNo, status);
            
            if (success) {
                response.put("success", true);
                response.put("message", "상태가 변경되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "상태 변경에 실패했습니다.");
            }
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            log.error("매물 상태 변경 중 오류 발생", e);
            response.put("success", false);
            response.put("message", "상태 변경 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(response);
        }
    }
    
    /**
     * 매물 삭제 API (삭제 버튼 - DELETED 상태로 변경)
     */
    @DeleteMapping("/api/properties/{propertyNo}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteProperty(@PathVariable Long propertyNo) {
        
        log.info("매물 삭제 API 호출 - 매물번호: {}", propertyNo);
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            boolean success = adminService.updatePropertyStatus(propertyNo, "DELETED");
            
            if (success) {
                response.put("success", true);
                response.put("message", "매물이 삭제되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "삭제에 실패했습니다.");
            }
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            log.error("매물 삭제 중 오류 발생", e);
            response.put("success", false);
            response.put("message", "삭제 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(response);
        }
    }

    // 공지사항관리
    @GetMapping("/content-management")
    public String contentManagement(Model model) {
    	List<Notice> noticeList = adminService.getAllNotices(); // DB에서 공지 가져오기
        model.addAttribute("noticeList", noticeList);
        return "admin/content-management";
    }

//    // 문의관리
//    @GetMapping("/inquiry-management")
//    public String inquiryManagement(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
//    	// 관리자 권한 체크
//        User loginUser = (User) session.getAttribute("loginUser");
//        if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
//            redirectAttributes.addFlashAttribute("error", "관리자 권한이 필요합니다.");
//            return "redirect:/";
//        }
//        
//        try {
//            // 전체 문의 목록 조회
//            List<Inquiry> inquiryList = inquiryService.getAllInquiries();
//            System.out.println(inquiryList);
//            model.addAttribute("inquiryList", inquiryList);
//            
//            // 통계 계산
//            int totalCount = inquiryList.size();
//            int pendingCount = 0;
//            int answeredCount = 0;
//            
//            for (Inquiry inquiry : inquiryList) {
//                if ("PENDING".equals(inquiry.getStatus())) {
//                    pendingCount++;
//                } else if ("ANSWERED".equals(inquiry.getStatus())) {
//                    answeredCount++;
//                }
//            }
//            
//            model.addAttribute("totalCount", totalCount);
//            model.addAttribute("pendingCount", pendingCount);
//            model.addAttribute("answeredCount", answeredCount);
//            
//            log.debug("문의 관리 페이지 로드: 전체 {} 건, 미답변 {} 건, 답변완료 {} 건", 
//                totalCount, pendingCount, answeredCount);
//            
//        } catch (Exception e) {
//            log.error("문의 관리 페이지 로드 실패: ", e);
//            model.addAttribute("error", "문의 목록을 불러올 수 없습니다.");
//        }
//        
//        return "admin/inquiry-management";
//    }
    
    /**
     * 문의 관리 페이지
     * GET /admin/inquiry-management
     */
    @GetMapping("/inquiry-management")
    public String inquiryManagement(Model model, 
                                   HttpSession session, 
                                   RedirectAttributes redirectAttributes) {
        
        // 관리자 권한 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
            redirectAttributes.addFlashAttribute("error", "관리자 권한이 필요합니다.");
            return "redirect:/";
        }
        
        try {
            // 관리자 문의 목록 조회 (INQUIRY_TYPE = 'ADMIN')
            List<Inquiry> inquiryList = inquiryService.getAllInquiries();
            model.addAttribute("inquiryList", inquiryList);
            
            log.debug("관리자 문의 목록 조회: {} 건", inquiryList.size());
            
        } catch (Exception e) {
            log.error("관리자 문의 목록 조회 실패: ", e);
            model.addAttribute("error", "문의 목록을 불러올 수 없습니다.");
        }
        
        return "admin/inquiry-management";
    }
    
    /**
     * 문의 답변 등록
     * POST /admin/inquiry-answer/{inquiryId}
     */
    @PostMapping("/inquiry-answer/{inquiryId}")
    public String answerInquiry(@PathVariable Integer inquiryId,
                               @RequestParam String answer,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        // 관리자 권한 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
            redirectAttributes.addFlashAttribute("error", "관리자 권한이 필요합니다.");
            return "redirect:/";
        }
        
        // 답변 내용 검증
        if (answer == null || answer.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "답변 내용을 입력해주세요.");
            return "redirect:/admin/inquiry-management";
        }
        
        if (answer.trim().length() < 10) {
            redirectAttributes.addFlashAttribute("error", "답변 내용을 10자 이상 입력해주세요.");
            return "redirect:/admin/inquiry-management";
        }
        
        try {
            Inquiry inquiry = inquiryService.getInquiryById(inquiryId);
            
            if (inquiry == null) {
                redirectAttributes.addFlashAttribute("error", "존재하지 않는 문의입니다.");
                return "redirect:/admin/inquiry-management";
            }
            
            // 관리자 문의인지 확인
            if (!"ADMIN".equals(inquiry.getInquiryType())) {
                redirectAttributes.addFlashAttribute("error", "관리자 문의만 답변할 수 있습니다.");
                return "redirect:/admin/inquiry-management";
            }
            
            if ("ANSWERED".equals(inquiry.getStatus())) {
                redirectAttributes.addFlashAttribute("error", "이미 답변이 등록된 문의입니다.");
                return "redirect:/admin/inquiry-management";
            }
            
            int result = inquiryService.answerInquiry(inquiryId, answer.trim());
            
            if (result > 0) {
                redirectAttributes.addFlashAttribute("message", "답변이 등록되었습니다.");
                log.info("관리자 문의 답변 등록: inquiryId={}, adminId={}", inquiryId, loginUser.getUserId());
            } else {
                redirectAttributes.addFlashAttribute("error", "답변 등록에 실패했습니다.");
            }
            
        } catch (Exception e) {
            log.error("답변 등록 실패: inquiryId={}", inquiryId, e);
            redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다.");
        }
        
        return "redirect:/admin/inquiry-management";
    }
    
    /**
     * 문의 삭제
     * POST /admin/inquiry-delete/{inquiryId}
     */
    @PostMapping("/inquiry-delete/{inquiryId}")
    public String deleteInquiry(@PathVariable Integer inquiryId,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        // 관리자 권한 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
            redirectAttributes.addFlashAttribute("error", "관리자 권한이 필요합니다.");
            return "redirect:/";
        }
        
        try {
            int result = inquiryService.deleteInquiry(inquiryId);
            
            if (result > 0) {
                redirectAttributes.addFlashAttribute("message", "문의가 삭제되었습니다.");
                log.info("문의 삭제: inquiryId={}, adminId={}", inquiryId, loginUser.getUserId());
            } else {
                redirectAttributes.addFlashAttribute("error", "문의 삭제에 실패했습니다.");
            }
            
        } catch (Exception e) {
            log.error("문의 삭제 실패: inquiryId={}", inquiryId, e);
            redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다.");
        }
        
        return "redirect:/admin/inquiry-management";
    }

    // 중개사 관리
    @GetMapping("/realtor-approval")
    public String realtorApproval(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
    	
    	// 관리자 권한 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
            redirectAttributes.addFlashAttribute("error", "관리자 권한이 필요합니다.");
            return "redirect:/";
        }
        
        try {
            RealtorApproval data = adminService.getRealtorApprovalData();
            
            // 전체 리스트 합치기
            List<Realtor> allRealtors = new ArrayList<>();
            allRealtors.addAll(data.getPendingRealtors());
            allRealtors.addAll(data.getApprovedRealtors());
            allRealtors.addAll(data.getRejectedRealtors());
            
            model.addAttribute("realtorList", allRealtors);
            
            log.debug("중개사 승인 관리 로드: 전체 {} 건", allRealtors.size());
            
        } catch (Exception e) {
            log.error("중개사 승인 관리 로드 실패: ", e);
            model.addAttribute("error", "중개사 목록을 불러올 수 없습니다.");
        }
    	
        return "admin/realtor-approval";
    }
    
    // 중개사 승인
    @PostMapping("/realtor-approve/{realtorId}")
    public String approveRealtor(@PathVariable String realtorId,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        // 관리자 권한 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
            redirectAttributes.addFlashAttribute("error", "관리자 권한이 필요합니다.");
            return "redirect:/";
        }
        
        try {
            int result = adminService.approveRealtor(realtorId);
            
            if (result > 0) {
                redirectAttributes.addFlashAttribute("message", "중개사가 승인되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("error", "중개사 승인에 실패했습니다.");
            }
            
        } catch (Exception e) {
            log.error("중개사 승인 실패: ", e);
            redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다.");
        }
        
        return "redirect:/admin/realtor-approval";
    }
    
    // 중개사 거부
    @PostMapping("/realtor-reject/{realtorId}")
    public String rejectRealtor(@PathVariable String realtorId,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        // 관리자 권한 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
            redirectAttributes.addFlashAttribute("error", "관리자 권한이 필요합니다.");
            return "redirect:/";
        }
        
        try {
            int result = adminService.rejectRealtor(realtorId);
            
            if (result > 0) {
                redirectAttributes.addFlashAttribute("message", "중개사가 거부되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("error", "중개사 거부에 실패했습니다.");
            }
            
        } catch (Exception e) {
            log.error("중개사 거부 실패: ", e);
            redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다.");
        }
        
        return "redirect:/admin/realtor-approval";
    }
    
    // 중개사 승인 취소
    @PostMapping("/realtor-cancel/{realtorId}")
    public String cancelRealtorApproval(@PathVariable String realtorId,
                                       HttpSession session,
                                       RedirectAttributes redirectAttributes) {
        
        // 관리자 권한 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
            redirectAttributes.addFlashAttribute("error", "관리자 권한이 필요합니다.");
            return "redirect:/";
        }
        
        try {
            int result = adminService.cancelApproval(realtorId);
            
            if (result > 0) {
                redirectAttributes.addFlashAttribute("message", "중개사 승인이 취소되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("error", "승인 취소에 실패했습니다.");
            }
            
        } catch (Exception e) {
            log.error("승인 취소 실패: ", e);
            redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다.");
        }
        
        return "redirect:/admin/realtor-approval";
    }
    
    /**
     * 중개사 상세 정보 조회 (AJAX용)
     * GET /admin/realtor-detail/{realtorId}
     */
    @GetMapping("/realtor-detail/{realtorId}")
    @ResponseBody
    public Map<String, Object> getRealtorDetail(@PathVariable String realtorId,
                                               HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // 관리자 권한 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"Y".equals(loginUser.getAdminYn())) {
            response.put("success", false);
            response.put("message", "관리자 권한이 필요합니다.");
            return response;
        }
        
        try {
            // 중개사 정보 조회
            Realtor realtor = adminService.getRealtorById(realtorId);
            
            if (realtor != null) {
                // 날짜 포맷팅
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                Map<String, Object> realtorData = new HashMap<>();
                
                realtorData.put("realtorId", realtor.getRealtorId());
                realtorData.put("realtorName", realtor.getRealtorName());
                realtorData.put("officeName", realtor.getOfficeName());
                realtorData.put("realtorPhone", realtor.getRealtorPhone());
                realtorData.put("realtorEmail", realtor.getRealtorEmail());
                realtorData.put("realtorAddress", realtor.getRealtorAddress());
                realtorData.put("realtorRegNum", realtor.getRealtorRegNum());
                realtorData.put("businessNum", realtor.getBusinessNum());
                realtorData.put("approvalStatus", realtor.getApprovalStatus());
                
                // 날짜가 null이 아닌 경우에만 포맷팅
                if (realtor.getCreatedAt() != null) {
                    realtorData.put("createdAt", sdf.format(realtor.getCreatedAt()));
                } else {
                    realtorData.put("createdAt", "-");
                }
                
                response.put("success", true);
                response.put("realtor", realtorData);
                
                log.debug("중개사 상세 정보 조회 성공: {}", realtorId);
                
            } else {
                response.put("success", false);
                response.put("message", "중개사를 찾을 수 없습니다.");
                log.warn("중개사 정보 없음: {}", realtorId);
            }
            
        } catch (Exception e) {
            log.error("중개사 상세 정보 조회 실패: realtorId={}", realtorId, e);
            response.put("success", false);
            response.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        
        return response;
    }

    // 통계
    @GetMapping("/statistics")
    public String statistics() {
        return "admin/statistics";
    }
}
