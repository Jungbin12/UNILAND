package com.elon.boot.controller;

import com.elon.boot.controller.dto.property.OptionAddRequest;
import com.elon.boot.controller.dto.property.PropertyAddRequest;
import com.elon.boot.domain.interest.service.InterestService;
import com.elon.boot.domain.interest.vo.Interest;
import com.elon.boot.domain.property.model.service.PropertyService;
import com.elon.boot.domain.property.model.vo.Property;
import com.elon.boot.domain.property.model.vo.PropertyImg;
import com.elon.boot.domain.property.model.vo.PropertyOption;
import com.elon.boot.domain.realtor.model.service.RealtorService;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import com.elon.boot.domain.user.model.vo.User;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/property")
@RequiredArgsConstructor
public class PropertyController {

    private final PropertyService pService;
    private final InterestService iService;
    // 매물 상세 페이지
    @GetMapping("/{id}")
    public String propertyDetail(@PathVariable Long id, Model model,HttpSession session) {
    	System.out.println(id);
    	Property property = pService.selectOneByNo(id);
    	String rId = property.getRealtorId();
    	PropertyOption option = pService.selectOnesOption(id);
//    	중개사 정보 가져오기
    	Realtor realtor = pService.selectRealtorById(rId);
    	List<PropertyImg> imgs = new ArrayList<PropertyImg> ();
    	imgs = pService.selectOnesImgs(id);
    	
    	System.out.println(rId);
    	System.out.println(realtor);
    	
    	 model.addAttribute("realtor",realtor);
         model.addAttribute("property", property);
         model.addAttribute("option", option);
         model.addAttribute("imgs", imgs);
         
         User loginUser = (User) session.getAttribute("loginUser");
         String loginUserId = (loginUser != null) ? loginUser.getUserId() : null;
         
         boolean isFavorited = false;
         int favoriteCount = iService.countFavorites(id);
         
         if(loginUserId != null) {
             Interest interest = new Interest();
             interest.setUserId(loginUserId);
             interest.setPropertyNo(id);
             isFavorited = iService.isFavorited(interest);
         }
         
         model.addAttribute("isFavorited", isFavorited);
         model.addAttribute("favoriteCount", favoriteCount);
         
        return "property/detail";
    }
    
    @PostMapping("/register")
    public String register(PropertyAddRequest req
    		, OptionAddRequest oReq
    		, HttpSession session
    		,@RequestParam (value="images",required=false)List<MultipartFile> images) {
        Realtor realtor = (Realtor) session.getAttribute("loginRealtor");
        if (realtor == null || realtor.getRealtorId() == null || realtor.getRealtorId().isBlank()) {
            return "redirect:/realtor/realtor-dashboard";
        }

        Long result = pService.register(req,oReq,images, realtor.getRealtorId());
        if( result == 0 ) {
        	return "redirect:/errror";
        }
        
        return "redirect:/realtor/property-management";
    }
    
//    임시로 사용할 테스트용 하드코딩 / 중개사 회원 로그인 기능 완성되면 지우고 위의 코딩을 사용해야함 
//    @PostMapping("/regiset")
//    public String register(PropertyAddRequest propReq, HttpSession session) {
//        String realtorId = "realtor_0001";
//
//        
//        propertyService.register(propReq, realtorId);
//
//        return "redirect:/realtor/property-management";
//    }
    @PostMapping("/{id}/wishlist")
    public String toggleWishlist(@PathVariable Long id,
                                 HttpSession session,Model model) {
    	User loginUser = (User) session.getAttribute("loginUser");
    	if (loginUser == null) {
    	    return "redirect:/auth/login"; // 혹은 로그인 페이지 경로
    	}
    	String loginUserId = loginUser.getUserId();

    	Interest interest = new Interest();
    	interest.setUserId(loginUserId);
    	interest.setPropertyNo(id);
    	iService.toggle(interest);
    	return "redirect:/property/" + id;
    }
    
    @PostMapping(value = "/{id}/wishlistM", produces = "application/json")
    @ResponseBody
    public java.util.Map<String, Object> toggleWishlist2(@PathVariable Long id, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");

//        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));로 작동
        if (loginUser == null) {
            return java.util.Map.of("success", false, "message", "LOGIN_REQUIRED");
        }

        Interest interest = new Interest();
        interest.setUserId(loginUser.getUserId());
        interest.setPropertyNo(id);

        boolean liked = iService.toggle(interest);
        int favoriteCount = iService.countFavorites(id);

        return java.util.Map.of(
            "success", true,
            "liked", liked,
            "favoriteCount", favoriteCount
        );
    }

    @GetMapping(value = "/{id}/wishlist/status", produces = "application/json")
    @ResponseBody
    public java.util.Map<String, Object> checkWishlistStatus(@PathVariable Long id, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null) {
            return java.util.Map.of("success", true, "liked", false);
        }

        Interest interest = new Interest();
        interest.setUserId(loginUser.getUserId());
        interest.setPropertyNo(id);

        boolean liked = iService.isFavorited(interest);

        return java.util.Map.of(
            "success", true,
            "liked", liked
        );
    }
}