package com.elon.boot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.elon.boot.controller.dto.user.UserModRequest;
import com.elon.boot.domain.inquiry.model.service.InquiryService;
import com.elon.boot.domain.inquiry.model.vo.Inquiry;
import com.elon.boot.domain.interest.service.InterestService;
import com.elon.boot.domain.interest.vo.Interest;
import com.elon.boot.domain.property.model.service.PropertyService;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.property.model.vo.PropertyImg;
import com.elon.boot.domain.user.model.service.UserService;
import com.elon.boot.domain.user.model.vo.User;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/mypage")
@RequiredArgsConstructor
@Slf4j
public class MypageController {

   private final UserService uService;
   private final InquiryService inquiryService;
   private final InterestService iService;
   private final PropertyService pService;
   
    // 일반 사용자 마이페이지
    @GetMapping
    public String mypage(HttpSession session, Model model) {

        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/auth/login"; // 미로그인 시 로그인 페이지로
        }
//        User userInfo = uService.getUserById(loginUser.getUserId());
        List<Inquiry> inquiries = inquiryService.getInquiriesByUserId(loginUser.getUserId());
        List<Interest> iList = iService.getListById(loginUser.getUserId());
        List<Long> propertyNos = iList.stream()
               .map(Interest::getPropertyNo)
               .collect(Collectors.toList());
        List<Property> wishlist = pService.selectListByNoList(propertyNos);
        List<PropertyImg> wImg = pService.getImgListByNoList(propertyNos);

        System.out.println(wishlist);
        System.out.println(wImg);
        System.out.println(iList);

        // 계약된 매물 목록 조회 (USER_ID가 현재 로그인한 사용자이고 CONTRACT_STATUS = 'Y'인 매물)
        Map<String, String> contractFilter = new HashMap<>();
        contractFilter.put("userId", loginUser.getUserId());
        contractFilter.put("CONTRACT_STATUS", "Y");
        List<Property> contractedProperties = pService.getContractedPropertiesByUserId(contractFilter);

        model.addAttribute("inquiries", inquiries);
        model.addAttribute("wishlist", wishlist);
        model.addAttribute("wImg", wImg);
        model.addAttribute("contractedProperties", contractedProperties);
        model.addAttribute("user", loginUser);
        return "mypage/real-estate-mypage";
    }
    // 임시: 로그인 체크 비활성화 (개발용)
    // if (user == null) {
    //     return "redirect:/auth/login";
    // }
    
    // TODO: 실제 데이터베이스에서 사용자 정보, 계약현황, 찜매물 등 가져오기
    // model.addAttribute("user", user);
    // model.addAttribute("contracts", contractService.getContractsByUserId(userId));
    // model.addAttribute("wishlist", wishlistService.getWishlistByUserId(userId));
    // model.addAttribute("recentProperties", propertyService.getRecentViewsByUserId(userId));
    // model.addAttribute("inquiries", inquiryService.getInquiriesByUserId(userId));

    // 회원정보 수정
    @PostMapping("/update")
    public String updateProfile(
            @ModelAttribute UserModRequest userModiReq,
            HttpSession session) {
       int result = uService.updateUser(userModiReq);


        return "redirect:/mypage";
    }

    // 회원 탈퇴
    @GetMapping("/delete")
    public String deleteAccount(HttpSession session) {
        // TODO: 회원 탈퇴 처리
        // userService.deleteUser(userId);

        session.invalidate();
        return "redirect:/";
    }
    
    
    
    
//    당장은 일 안하는 코드지만 혹시 몰라서 냅둠
//    @GetMapping("/inquiries")
//    public String CheckInquiry(@RequestParam(value = "tab", required = false) String tab, HttpSession session, Model model) {
//        User user = (User) session.getAttribute("user");
//        if (user == null) {
//            return "redirect:/auth/login";
//        }
//        
//        log.info("마이페이지 접근: userId={}, tab={}", user.getUserId(), tab);
//        
//        try {
//            // 사용자 정보 최신화 (DB에서 다시 조회)
//            User updatedUser = uService.getUserById(user.getUserId());
//            if (updatedUser != null) {
//                session.setAttribute("user", updatedUser);
//                model.addAttribute("user", updatedUser);
//            } else {
//                model.addAttribute("user", user);
//            }
//            
//            // ========== 문의내역 조회 ==========
//            
//            // 전체 문의 목록
//            List<Inquiry> inquiries = inquiryService.getInquiriesByUserId(user.getUserId());
//            model.addAttribute("inquiries", inquiries);
//            
//            // 관리자 문의만
//            List<Inquiry> adminInquiries = inquiryService.getAdminInquiriesByUserId(user.getUserId());
//            model.addAttribute("adminInquiries", adminInquiries);
//            
//            // 중개사 문의만
//            List<Inquiry> realtorInquiries = inquiryService.getRealtorInquiriesByUserId(user.getUserId());
//            model.addAttribute("realtorInquiries", realtorInquiries);
//            
//            // 미읽음 문의 개수
//            int unreadCount = inquiryService.getUnreadInquiryCount(user.getUserId());
//            model.addAttribute("unreadCount", unreadCount);
//            
//            log.info("문의내역 조회 완료 - 전체: {}, 관리자: {}, 중개사: {}, 미읽음: {}", 
//                    inquiries.size(), adminInquiries.size(), realtorInquiries.size(), unreadCount);
//            
//            // ========== TODO: 다른 데이터 조회 ==========
//            
//            // 계약 현황 조회
//            // List<Contract> contracts = contractService.getContractsByUserId(user.getUserId());
//            // model.addAttribute("contracts", contracts);
//            
//            // 찜매물 조회
//            // List<Property> wishlist = propertyService.getWishlistByUserId(user.getUserId());
//            // model.addAttribute("wishlist", wishlist);
//            
//            // 최근 본 매물 조회
//            // List<Property> recentProperties = propertyService.getRecentPropertiesByUserId(user.getUserId());
//            // model.addAttribute("recentProperties", recentProperties);
//            
//        } catch (Exception e) {
//            log.error("마이페이지 데이터 조회 중 오류 발생: userId={}", user.getUserId(), e);
//            model.addAttribute("error", "데이터를 불러오는 중 오류가 발생했습니다.");
//        }
//        
//        // 활성화할 탭 전달
//        if (tab != null) {
//            model.addAttribute("activeTab", tab);
//        }
//        
//        // 문의내역 조회
//        List<Inquiry> inquiries = inquiryService.getInquiriesByUserId(user.getUserId());
//        System.out.println(inquiries);
//        model.addAttribute("inquiries", inquiries);
//        model.addAttribute("user", user);
//        
//        return "mypage/realtor-mypage";
//    }

}
