package com.elon.boot.controller;

import com.elon.boot.domain.realtor.model.service.FileStorageService;
import com.elon.boot.domain.realtor.model.service.RealtorService;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import com.elon.boot.domain.inquiry.model.service.InquiryService;
import com.elon.boot.domain.inquiry.model.vo.Inquiry;
import com.elon.boot.domain.property.model.service.PropertyService;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.property.model.vo.PropertyOption;
import com.elon.boot.domain.property.model.vo.PropertyImg;
import com.elon.boot.domain.realtor.model.vo.Pagination; 

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors; 

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/realtor") 
@Slf4j
public class RealtorController {

    @Autowired
    private RealtorService realtorService;
    
    @Autowired
    private FileStorageService fileStorageService; 
    
    @Autowired
    private InquiryService inquiryService;
    
    @Autowired
    private PropertyService propertyService; 

    /** ✅ 사업자등록번호 중복 확인 (AJAX) */
    @PostMapping("/check-business-num")
    @ResponseBody
    public Map<String, Object> checkBusinessNum(@RequestBody Map<String, String> req) {
        String businessNum = req.get("businessNum");
        boolean isDuplicate = realtorService.isBusinessNumDuplicate(businessNum);

        Map<String, Object> res = new HashMap<>();
        res.put("isDuplicate", isDuplicate);
        res.put("message", isDuplicate ? "이미 등록된 사업자등록번호입니다." : "사용 가능한 사업자등록번호입니다.");
        return res;
    }
    
    /** 중개사 등록번호 중복 여부를 확인합니다. (AJAX) */
    @PostMapping("/check-realtor-reg-num")
    @ResponseBody
    public Map<String, Object> checkRealtorRegNum(@RequestBody Map<String, String> req) {
        String realtorRegNum = req.get("realtorRegNum");
        boolean isDuplicate = realtorService.isRealtorRegNumDuplicate(realtorRegNum);

        Map<String, Object> res = new HashMap<>();
        res.put("isDuplicate", isDuplicate);
        res.put("message", isDuplicate ? "이미 등록된 중개사 등록번호입니다." : "사용 가능한 중개사 등록번호입니다.");
        return res;
    }

    /** ✅ 회원가입 폼 제출 처리 */
    @PostMapping("/register")
    @ResponseBody
    public Map<String, Object> registerRealtor(@RequestBody Realtor realtor) {
        Map<String, Object> res = new HashMap<>();

        // 1. 사업자 등록번호 중복 체크
        if (realtorService.isBusinessNumDuplicate(realtor.getBusinessNum())) {
            res.put("success", false);
            res.put("message", "이미 등록된 사업자등록번호입니다.");
            return res;
        }
        
        // 2. 중개사 등록번호 중복 체크
        if (realtorService.isRealtorRegNumDuplicate(realtor.getRealtorRegNum())) {
             res.put("success", false);
             res.put("message", "이미 등록된 중개사 등록번호입니다.");
             return res;
        }

        // 회원가입 처리
        boolean success = realtorService.registerRealtor(realtor);
        if (success) {
            res.put("success", true);
            res.put("message", "회원가입 신청이 완료되었습니다. 관리자 승인을 기다려주세요.");
        } else {
            res.put("success", false);
            res.put("message", "회원가입에 실패했습니다. 다시 시도해주세요.");
        }

        return res;
    }

    /** ✅ 로그인 처리 (APPROVAL_STATUS 확인) */
    @PostMapping("/realtor-login")
    public String realtorLogin(@RequestParam("realtorId") String realtorId,
                               @RequestParam("password") String password,
                               @RequestParam("businessNumber") String businessNumber,
                               HttpSession session,
                               Model model) {

        Realtor realtor = realtorService.getRealtorByLogin(realtorId, password, businessNumber);

        if (realtor != null) {
            String status = realtor.getApprovalStatus(); 

            if ("APPROVAL".equals(status)) { 
                session.setAttribute("loginRealtor", realtor);
                return "redirect:/realtor/realtor-dashboard";

            } else if ("PENDING".equals(status)) { 
                model.addAttribute("loginError", "회원가입 승인 대기 중입니다. 관리자의 승인을 기다려주세요.");
                return "auth/realtor-login"; 

            } else if ("REJECTED".equals(status)) { 
                model.addAttribute("loginError", "죄송합니다. 회원가입 신청이 거절되었습니다. 고객센터에 문의해주세요.");
                return "auth/realtor-login";

            } else {
                model.addAttribute("loginError", "계정 상태를 확인할 수 없습니다. 고객센터에 문의해주세요.");
                return "auth/realtor-login";
            }
            
        } else {
        	model.addAttribute("loginError", "아이디, 비밀번호 또는 사업자등록번호가 올바르지 않습니다.");
            return "auth/realtor-login";
        }
    }

    /** ✅ 대시보드 페이지 */
    @GetMapping("/realtor-dashboard")
    public String showRealtorDashboard(HttpSession session, 
            Model model) {
    		Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");
        
        if (loginRealtor == null) {
            return "redirect:/realtor/realtor-login";
        }
        
        String realtorId = loginRealtor.getRealtorId();
        
        // 2. 통계 조회
        Map<String, Integer> stats2 = inquiryService.getRealtorInquiryStats(realtorId);
        
        
        
        // 1. 매물 통계 조회
        Map<String, Integer> stats = propertyService.getPropertyStatsByRealtor(realtorId);
        model.addAttribute("allCount", stats.getOrDefault("ALL_COUNT", 0));
        model.addAttribute("completedCount", stats.getOrDefault("COMPLETED_COUNT", 0));
        model.addAttribute("stats", stats2);
        
        return "realtor/realtor-dashboard";
    }

// -------------------------------------------------------------------------
// 매물 상세 조회 메서드 (수정 완료)
// -------------------------------------------------------------------------

    /** * 매물 상세 페이지 (property-detail)
     * 중개사 본인이 등록한 매물만 조회할 수 있도록 권한을 확인합니다.
     */
    @GetMapping("/property-detail")
    public String showPropertyDetail(@RequestParam("id") Long propertyNo, 
                                     HttpSession session, 
                                     Model model, 
                                     RedirectAttributes ra) {
        
        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");
        
        if (loginRealtor == null) {
            ra.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
            return "redirect:/realtor/realtor-login"; 
        }
        
        try {
            // 1. 매물 기본 정보 조회
            Property property = propertyService.selectOneByNo(propertyNo);
            
            // 2. 권한 확인: 매물이 존재하고, 현재 로그인한 중개사가 등록한 매물인지 확인
            if (property == null || !property.getRealtorId().equals(loginRealtor.getRealtorId())) {
                ra.addFlashAttribute("errorMessage", "접근 권한이 없거나 존재하지 않는 매물입니다.");
                return "redirect:/realtor/property-management";
            }
            
            // 3. 매물 옵션 정보 조회
            PropertyOption options = propertyService.selectOnesOption(propertyNo);
            
            // 4. 매물 이미지 목록 조회
            List<PropertyImg> images = propertyService.selectOnesImgs(propertyNo);

            // 5. 조회된 데이터를 모델에 담기
            model.addAttribute("property", property);
            model.addAttribute("options", options);
            // ⭐ 이미지 연동을 위해 모델 키를 JSP 코드와 일치하는 "imgs"로 수정
            model.addAttribute("imgs", images); 

            return "realtor/property-detail"; // property-detail.jsp 로 이동
            
        } catch (Exception e) {
            log.error("매물 상세 조회 실패 (ID: {}): {}", propertyNo, e.getMessage());
            ra.addFlashAttribute("errorMessage", "매물 정보를 불러오는 중 오류가 발생했습니다.");
            return "redirect:/realtor/property-management";
        }
    }

// -------------------------------------------------------------------------
// 나머지 매물 관리 및 회원 관리 기능 (유지)
// -------------------------------------------------------------------------

    /** ✅ 매물 관리 페이지 */
    @GetMapping("/property-management")
    public String propertyManagementPage(
            HttpSession session, 
            Model model,
            @RequestParam(value = "page", defaultValue = "1") int currentPage,
            @RequestParam Map<String, String> filterParams
            ) {
        
        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");
        
        if (loginRealtor == null) {
            return "redirect:/realtor/realtor-login";
        }
        
        String realtorId = loginRealtor.getRealtorId();
        
        // 1. 매물 통계 조회
        Map<String, Integer> stats = propertyService.getPropertyStatsByRealtor(realtorId);
        model.addAttribute("allCount", stats.getOrDefault("ALL_COUNT", 0));
        model.addAttribute("activeCount", stats.getOrDefault("ACTIVE_COUNT", 0));
        model.addAttribute("reservedCount", stats.getOrDefault("RESERVED_COUNT", 0));
        model.addAttribute("completedCount", stats.getOrDefault("COMPLETED_COUNT", 0));
        
        // 2. 검색 및 필터 파라미터 설정
        filterParams.put("realtorId", realtorId);
        
        // 3. 페이징 처리
        int listCount = propertyService.getPropertyCount(filterParams);
        int pageLimit = 10;
        int boardLimit = 9;
        
        Pagination pager = new Pagination(currentPage, listCount, pageLimit, boardLimit);
        
        // 4. 매물 목록 조회
        List<Property> propertyList = propertyService.selectPropertyList(filterParams, pager);
        
        // 5. 필터 파라미터를 JSP의 pagination에 전달하기 위해 쿼리 스트링으로 변환
        String filterQueryString = filterParams.entrySet().stream()
                .filter(entry -> !entry.getKey().equals("page") && !entry.getKey().equals("realtorId"))
                .map(entry -> entry.getKey() + "=" + entry.getValue())
                .collect(Collectors.joining("&"));
        
        model.addAttribute("propertyList", propertyList);
        model.addAttribute("pager", pager);
        model.addAttribute("filterParams", filterQueryString);
        
        log.info("중개사 매물 관리 페이지 로드: 매물 {}건, 현재 페이지 {}", propertyList.size(), currentPage);

        return "realtor/property-management";
    }
    
    /** ⭐ 매물 상태 변경 (AJAX) */
    @PostMapping("/property/change-status")
    @ResponseBody
    public Map<String, Object> changePropertyStatus(
            @RequestParam("propertyId") int propertyNo,
            @RequestParam("newStatus") String newStatus,
            HttpSession session) {
        
        Map<String, Object> res = new HashMap<>();
        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");
        
        if (loginRealtor == null) {
            res.put("success", false);
            res.put("message", "로그인이 필요합니다.");
            return res;
        }

        try {
            int result = propertyService.updatePropertyStatus(propertyNo, newStatus);
            
            if (result > 0) {
                res.put("success", true);
                res.put("message", "매물 상태가 성공적으로 변경되었습니다.");
            } else {
                res.put("success", false);
                res.put("message", "매물 상태 변경에 실패했거나 매물 번호가 유효하지 않습니다.");
            }
        } catch (Exception e) {
            log.error("매물 상태 변경 중 오류 발생: {}", e.getMessage());
            res.put("success", false);
            res.put("message", "오류가 발생했습니다.");
        }
        
        return res;
    }
    
    /** ⭐ 매물 삭제 (AJAX) */
    @PostMapping("/property/delete")
    @ResponseBody
    public Map<String, Object> deleteProperty(
            @RequestParam("propertyId") int propertyNo,
            HttpSession session) {

        Map<String, Object> res = new HashMap<>();
        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");

        if (loginRealtor == null) {
            res.put("success", false);
            res.put("message", "로그인이 필요합니다.");
            return res;
        }

        try {
            // 중개사 소유 매물인지 확인하는 로직이 Service에 있다고 가정
            int result = propertyService.deleteProperty(propertyNo, loginRealtor.getRealtorId());

            if (result > 0) {
                res.put("success", true);
                res.put("message", "매물이 성공적으로 삭제되었습니다.");
            } else {
                res.put("success", false);
                res.put("message", "매물 삭제에 실패했습니다. 소유권이 없거나 매물이 존재하지 않습니다.");
            }
        } catch (Exception e) {
            log.error("매물 삭제 중 오류 발생: {}", e.getMessage());
            res.put("success", false);
            res.put("message", "오류가 발생했습니다.");
        }

        return res;
    }

    /** ⭐ 계약 완료 처리 (AJAX) */
    @PostMapping("/property/complete-contract")
    @ResponseBody
    public Map<String, Object> completeContract(
            @RequestParam("propertyId") int propertyNo,
            @RequestParam("buyerUserId") String buyerUserId,
            HttpSession session) {

        Map<String, Object> res = new HashMap<>();
        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");

        if (loginRealtor == null) {
            res.put("success", false);
            res.put("message", "로그인이 필요합니다.");
            return res;
        }

        try {
            // 계약 완료 처리 (USER_ID, CONTRACT_STATUS, STATUS, CONTRACT_AT 업데이트)
            int result = propertyService.completeContract(propertyNo, buyerUserId, loginRealtor.getRealtorId());

            if (result > 0) {
                res.put("success", true);
                res.put("message", "계약이 성공적으로 완료되었습니다.");
            } else {
                res.put("success", false);
                res.put("message", "계약 완료 처리에 실패했습니다. 매물 번호 또는 사용자 ID를 확인해주세요.");
            }
        } catch (Exception e) {
            log.error("계약 완료 처리 중 오류 발생: {}", e.getMessage());
            res.put("success", false);
            res.put("message", "오류가 발생했습니다: " + e.getMessage());
        }

        return res;
    }


    /** ✅ 매물 등록 페이지 */
    @GetMapping("/property-register")
    public String propertyRegisterPage() {
        return "realtor/property-register";
    }

    /** ✅ 문의 관리 페이지 */
    @GetMapping("/inquiry-management")
    public String inquiryManagementPage(HttpSession session, 
                                       Model model,
                                       RedirectAttributes redirectAttributes) {
        
        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");
        
        if (loginRealtor == null) {
            redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/realtor/realtor-login";
        }
        
        try {
            String realtorId = loginRealtor.getRealtorId();
            
            // 1. 문의 목록 조회
            List<Inquiry> inquiries = inquiryService.getRealtorInquiries(realtorId);
            
            // 2. 통계 조회
            Map<String, Integer> stats = inquiryService.getRealtorInquiryStats(realtorId);
            
            model.addAttribute("inquiries", inquiries);
            model.addAttribute("stats", stats);
            
            log.info("중개사 문의 목록 조회: {} 건", inquiries.size());
            
        } catch (Exception e) {
            log.error("문의 목록 조회 실패: ", e);
            redirectAttributes.addFlashAttribute("error", "문의 목록을 불러올 수 없습니다.");
        }
        
        return "realtor/inquiry-management";
    }
    
    /** ✅ 문의 답변 작성 */
    @PostMapping("/inquiry/answer")
    @ResponseBody
    public Map<String, Object> answerInquiry(@RequestParam("inquiryId") Integer inquiryId,
                                            @RequestParam("answer") String answer,
                                            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");
        
        if (loginRealtor == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return response;
        }
        
        try {
            int result = inquiryService.answerRealtorInquiry(inquiryId, answer);
            
            if (result > 0) {
                response.put("success", true);
                response.put("message", "답변이 전송되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "답변 전송에 실패했습니다.");
            }
            
        } catch (Exception e) {
            log.error("답변 작성 실패: ", e);
            response.put("success", false);
            response.put("message", "오류가 발생했습니다.");
        }
        
        return response;
    }
    
    /** ✅ 문의 읽음 처리 */
    @PostMapping("/inquiry/read")
    @ResponseBody
    public Map<String, Object> markInquiryAsRead(@RequestParam("inquiryId") Integer inquiryId,
                                                 HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");
        
        if (loginRealtor == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return response;
        }
        
        try {
            int result = inquiryService.markAsRead(inquiryId);
            
            if (result > 0) {
                response.put("success", true);
            } else {
                response.put("success", false);
                response.put("message", "이미 읽은 문의입니다.");
            }
            
        } catch (Exception e) {
            log.error("읽음 처리 실패: ", e);
            response.put("success", false);
            response.put("message", "오류가 발생했습니다.");
        }
        
        return response;
    }
    
    /** ✅ 매물 수정 페이지 */
    @GetMapping("/property-edit")
    public String showPropertyEdit(@RequestParam("id") int propertyNo, HttpSession session, Model model) {
        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");

        if (loginRealtor == null) {
            return "redirect:/realtor/realtor-login";
        }

        // 매물 정보 조회
        Property property = propertyService.selectPropertyById(propertyNo);

        if (property == null) {
            return "redirect:/realtor/property-management?error=notfound";
        }

        // 해당 매물이 로그인한 중개사의 매물인지 확인
        if (!property.getRealtorId().equals(loginRealtor.getRealtorId())) {
            return "redirect:/realtor/property-management?error=unauthorized";
        }

        // 매물 옵션 조회
        List<PropertyOption> options = propertyService.selectPropertyOptions(propertyNo);

        // 매물 이미지 조회
        List<PropertyImg> images = propertyService.selectPropertyImages(propertyNo);

        model.addAttribute("property", property);
        model.addAttribute("options", options);
        model.addAttribute("images", images);

        return "realtor/property-edit";
    }

    /** ✅ 매물 수정 처리 (POST) */
    @PostMapping("/property-edit")
    public String updateProperty(
            @RequestParam("id") int propertyNo,
            @RequestParam("status") String status,
            @RequestParam("propertyName") String propertyName,
            @RequestParam("deposit") int deposit,
            @RequestParam("monthlyRent") int monthlyRent,
            @RequestParam(value = "maintenanceFee", required = false, defaultValue = "0") int maintenanceFee,
            @RequestParam(value = "availableDate", required = false) String availableDate,
            @RequestParam("description") String description,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");

        if (loginRealtor == null) {
            return "redirect:/realtor/realtor-login";
        }

        // 매물 정보 업데이트
        Map<String, Object> params = new HashMap<>();
        params.put("propertyNo", propertyNo);
        params.put("status", status);
        params.put("propertyName", propertyName);
        params.put("deposit", deposit);
        params.put("monthlyRent", monthlyRent);
        params.put("maintenanceFee", maintenanceFee);
        params.put("availableDate", availableDate);
        params.put("description", description);
        params.put("realtorId", loginRealtor.getRealtorId());

        int result = propertyService.updateProperty(params);

        if (result > 0) {
            redirectAttributes.addFlashAttribute("message", "매물 수정이 완료되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "매물 수정에 실패했습니다.");
        }

        return "redirect:/realtor/property-management";
    }

    /** ✅ 로그아웃 */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/?logout=true";
    }
    
    /** * ✅ 중개사 마이페이지 조회 (realtor/realtor-mypage) */
    @GetMapping("/realtor-mypage")
    public String showRealtorMypage(HttpSession session, Model model) {
        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");

        if (loginRealtor == null) {
            return "redirect:/realtor/realtor-login";
        }

        // 최신 사용자 정보를 다시 조회
        Realtor currentRealtor = realtorService.getRealtorById(loginRealtor.getRealtorId());

        session.setAttribute("loginRealtor", currentRealtor);
        model.addAttribute("realtor", currentRealtor);

        // 계약 완료된 매물 목록 조회 (CONTRACT_STATUS = 'Y')
        Map<String, String> filterParams = new HashMap<>();
        filterParams.put("realtorId", currentRealtor.getRealtorId());
        filterParams.put("STATUS", "COMPLETED");
        filterParams.put("CONTRACT_STATUS", "Y");

        List<Property> contractedProperties = propertyService.selectPropertyList(filterParams, null);
        model.addAttribute("contractedProperties", contractedProperties);

        return "realtor/realtor-mypage";
    }
    
    /** * ✅ 중개사 회원정보 수정 처리 (realtor/mypage/update) */
    @PostMapping("/mypage/update")
    public String updateRealtorProfile(
            HttpSession session, 
            RedirectAttributes ra,
            @RequestParam String officeName,
            @RequestParam String realtorName,
            @RequestParam String realtorAddress,
            @RequestParam String realtorPhone,
            @RequestParam String realtorEmail) {

        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");
        
        if (loginRealtor == null) {
            return "redirect:/realtor/realtor-login"; 
        }

        String realtorId = loginRealtor.getRealtorId();
        String businessNum = loginRealtor.getBusinessNum();
        String realtorRegNum = loginRealtor.getRealtorRegNum(); 


        Realtor updatedRealtor = new Realtor();
        updatedRealtor.setRealtorId(realtorId); 
        updatedRealtor.setBusinessNum(businessNum); 
        updatedRealtor.setRealtorRegNum(realtorRegNum); 
        updatedRealtor.setOfficeName(officeName);
        updatedRealtor.setRealtorName(realtorName);
        updatedRealtor.setRealtorAddress(realtorAddress);
        updatedRealtor.setRealtorPhone(realtorPhone);
        updatedRealtor.setRealtorEmail(realtorEmail);

        boolean success = realtorService.updateRealtor(updatedRealtor);

        if (success) {
             Realtor currentRealtor = realtorService.getRealtorById(realtorId);
             session.setAttribute("loginRealtor", currentRealtor);
             ra.addFlashAttribute("message", "회원 정보가 성공적으로 수정되었습니다.");
        } else {
             ra.addFlashAttribute("message", "회원 정보 수정에 실패했습니다.");
        }

        return "redirect:/realtor/realtor-mypage";
    }

    /** * ✅ 중개사 회원 탈퇴 처리 (realtor/mypage/delete) */
    @GetMapping("/mypage/delete")
    public String deleteRealtorAccount(HttpSession session, RedirectAttributes ra) {
        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");
        
        if (loginRealtor == null) {
            return "redirect:/realtor/realtor-login"; 
        }
        
        String realtorId = loginRealtor.getRealtorId();

        boolean success = realtorService.deleteRealtor(realtorId);

        if (success) {
            session.invalidate();
            ra.addFlashAttribute("message", "성공적으로 탈퇴되었습니다. UNILAND를 이용해주셔서 감사합니다.");
            return "redirect:/";
        } else {
            ra.addFlashAttribute("message", "탈퇴 처리 중 오류가 발생했습니다. 고객센터에 문의해주세요.");
            return "redirect:/realtor/realtor-mypage"; 
        }
    }
    
    /** * ⭐ 수정/통합: 프로필 이미지 업데이트 처리 (realtor/profile/updateImage) */
    @PostMapping("/profile/updateImage")
    public String updateRealtorImage(
        HttpSession session, // 세션 갱신을 위해 추가
        @RequestParam("realtorImage") MultipartFile file,
        RedirectAttributes ra) {
        
        Realtor loginRealtor = (Realtor) session.getAttribute("loginRealtor");

        if (loginRealtor == null) {
            ra.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
            return "redirect:/realtor/realtor-login"; 
        }
        
        String realtorId = loginRealtor.getRealtorId();
        
        if (file.isEmpty()) {
             ra.addFlashAttribute("errorMessage", "업로드할 이미지를 선택해주세요.");
             return "redirect:/realtor/realtor-mypage";
        }
        
        try {
            // 1. 파일 저장 처리 및 새 파일명 생성
            String savedFileName = fileStorageService.saveProfileImage(file);
            
            // 2. DB에 파일명 업데이트
            boolean success = realtorService.updateRealtorImage(realtorId, savedFileName);

            if (success) {
                // 3. 세션 갱신: 최신 정보를 DB에서 다시 가져와 세션을 업데이트
                Realtor currentRealtor = realtorService.getRealtorById(realtorId);
                session.setAttribute("loginRealtor", currentRealtor);
                
                ra.addFlashAttribute("message", "프로필 이미지가 성공적으로 변경되었습니다.");
            } else {
                ra.addFlashAttribute("errorMessage", "DB 업데이트에 실패했습니다.");
            }
        } catch (Exception e) {
            // 파일 저장/DB 업데이트 중 발생한 예외 처리
            ra.addFlashAttribute("errorMessage", "이미지 업로드 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return "redirect:/realtor/realtor-mypage";
    }

}