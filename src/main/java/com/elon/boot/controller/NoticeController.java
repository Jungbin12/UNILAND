package com.elon.boot.controller;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
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

import com.elon.boot.controller.dto.notice.NoticeInsertRequest;
import com.elon.boot.controller.dto.notice.NoticeUpdateRequest;
import com.elon.boot.domain.community.notice.model.service.NoticeService;
import com.elon.boot.domain.community.notice.model.vo.Notice;
import com.elon.boot.domain.user.model.vo.User;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/community")
@RequiredArgsConstructor
@Slf4j
public class NoticeController {
    
    private final NoticeService noticeService;
    
    // 공지사항 목록
    @GetMapping("/notice")
    public String noticeList(Model model) {
        try {
            List<Notice> noticeList = noticeService.getAllNotices();
            model.addAttribute("noticeList", noticeList);
            
            log.debug("공지사항 목록 조회 성공: {} 건", noticeList != null ? noticeList.size() : 0);
            
            if (noticeList != null) {
                for (Notice notice : noticeList) {
                    log.debug("공지사항: NO={}, SUBJECT={}, WRITER={}", 
                        notice.getNoticeNo(), 
                        notice.getNoticeSubject(), 
                        notice.getNoticeWriter());
                }
            }
            
        } catch (Exception e) {
            log.error("공지사항 조회 실패: ", e);
            model.addAttribute("error", "공지사항을 불러올 수 없습니다.");
        }
        
        return "community/notice";
    }
    
    // 공지사항 상세
    @GetMapping("/notice/{noticeNo}")
    public String noticeDetail(@PathVariable Integer noticeNo, Model model) {
        try {
            Notice notice = noticeService.getNoticeById(noticeNo);
            
            if (notice != null) {
                model.addAttribute("notice", notice);
                log.debug("공지사항 상세 조회: {}", notice);
            } else {
                model.addAttribute("error", "존재하지 않는 공지사항입니다.");
            }
            
        } catch (Exception e) {
            log.error("공지사항 상세 조회 실패: ", e);
            model.addAttribute("error", "공지사항을 불러올 수 없습니다.");
        }
        
        return "community/notice-detail";
    }
    
    // 공지사항 작성 페이지
    @GetMapping("/notice-write")
    public String noticeWriteForm(HttpSession session, RedirectAttributes redirectAttributes) {
        // 로그인 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/auth/login";
        }
        
        return "community/notice-write";
    }
    
    // 공지사항 작성 처리
    @PostMapping("/notice-write")
    public String noticeWrite(@ModelAttribute Notice notice,
                             @RequestParam(value = "noticeImportant", defaultValue = "N") String noticeImportant,
                             @RequestParam(value = "noticeIsnew", defaultValue = "N") String noticeIsnew,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        
        // 로그인 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/auth/login";
        }
        
        try {
            // 작성자 정보 설정
            notice.setUserId(loginUser.getUserId());
            notice.setNoticeWriter(loginUser.getUserName());
            notice.setNoticeImportant(noticeImportant);
            notice.setNoticeIsnew(noticeIsnew);
            
            log.debug("공지사항 등록 시도: userId={}, writer={}, subject={}, important={}, isnew={}", 
                    notice.getUserId(), 
                    notice.getNoticeWriter(),
                    notice.getNoticeSubject(),
                    notice.getNoticeImportant(),
                    notice.getNoticeIsnew());
                
                int result = noticeService.createNotice(notice);
                
                if (result > 0) {
                    redirectAttributes.addFlashAttribute("message", "공지사항이 등록되었습니다.");
                    return "redirect:/community/notice";
                } else {
                    redirectAttributes.addFlashAttribute("error", "공지사항 등록에 실패했습니다.");
                    return "redirect:/community/notice/write";
                }
                
            } catch (Exception e) {
                log.error("공지사항 등록 실패: ", e);
                redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다: " + e.getMessage());
                return "redirect:/community/notice/write";
            }
        }
    
    // 공지사항 수정 페이지
    @GetMapping("/notice-update/{noticeNo}")
    public String noticeEditForm(@PathVariable Integer noticeNo,
                                HttpSession session,
                                Model model,
                                RedirectAttributes redirectAttributes) {
        
        // 로그인 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/auth/login";
        }
        
        try {
            Notice notice = noticeService.getNoticeById(noticeNo);
            
            model.addAttribute("notice", notice);
            
        } catch (Exception e) {
            log.error("공지사항 조회 실패: ", e);
            redirectAttributes.addFlashAttribute("error", "공지사항을 불러올 수 없습니다.");
            return "redirect:/admin/content-management";
        }
        
        return "community/notice-update";
    }
    
    // 공지사항 수정 처리
    @PostMapping("/notice-update/{noticeNo}")
    public String noticeEdit(@PathVariable Integer noticeNo,
                           @ModelAttribute Notice notice,
                           @RequestParam(value = "noticeImportant", defaultValue = "N") String noticeImportant,
                           @RequestParam(value = "noticeIsnew", defaultValue = "N") String noticeIsnew,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        
        // 로그인 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/auth/login";
        }
        
        try {
            notice.setNoticeNo(noticeNo);
            notice.setNoticeImportant(noticeImportant);
            notice.setNoticeIsnew(noticeIsnew);
            
            int result = noticeService.updateNotice(notice);
            if (result > 0) {
                redirectAttributes.addFlashAttribute("message", "공지사항이 수정되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("error", "공지사항 수정에 실패했습니다.");
            }
            
        } catch (Exception e) {
            log.error("공지사항 수정 실패: ", e);
            redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다.");
        }
        
        return "redirect:/community/notice/" + noticeNo;
    }
    
    // 공지사항 삭제
    @PostMapping("/notice/delete/{noticeNo}")
    public String noticeDelete(@PathVariable Integer noticeNo,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        
        // 로그인 체크
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/auth/login";
        }
        
        try {
            int result = noticeService.deleteNotice(noticeNo);
            
            if (result > 0) {
                redirectAttributes.addFlashAttribute("message", "공지사항이 삭제되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("error", "공지사항 삭제에 실패했습니다.");
            }
            
        } catch (Exception e) {
            log.error("공지사항 삭제 실패: ", e);
            redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다.");
        }
        
        return "redirect:/community/notice";
    }
}