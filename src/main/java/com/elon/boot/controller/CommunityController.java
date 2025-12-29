package com.elon.boot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity; // ✅ 추가
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping; // ✅ 추가
import org.springframework.web.bind.annotation.RequestBody; // ✅ 추가
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.elon.boot.domain.community.guide.model.service.GuideCommentLikeService;
import com.elon.boot.domain.community.guide.model.service.GuideCommentService;
import com.elon.boot.domain.community.guide.model.service.GuideLikeService;
import com.elon.boot.domain.community.guide.model.service.GuideService;
import com.elon.boot.domain.community.guide.model.vo.Guide;
import com.elon.boot.domain.community.guide.model.vo.GuideComment;
import com.elon.boot.domain.user.model.vo.User;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/community")
@RequiredArgsConstructor
public class CommunityController {

   private final GuideService gService;
   private final GuideCommentService cService;
   private final GuideLikeService lService;
   private final GuideCommentLikeService clService;

   // 가이드 작성 페이지 표시
	@GetMapping("/guide-write")
	public String guideWriteForm(HttpSession session, Model model) {
	    // 로그인 체크
	    User loginUser = (User) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        model.addAttribute("errorMessage", "로그인이 필요합니다.");
	        return "redirect:/login";
	    }

	    // Jsp에서 <c:out> 사용 시 NullPoiner 방지를 위해 빈 객체 추가
	    model.addAttribute("guide", new Guide());
	    // Jsp에서 작성/수정 모드 구분을 위한 값 추가
	    model.addAttribute("isEditMode", false);

	    return "community/guide-write";
	}

	// 가이드 작성 처리
	@PostMapping("/guide-write")
	public String guideWrite(
	        @RequestParam String guideCategory,
	        @RequestParam String guideTitle,
	        @RequestParam String guideContent,
	        HttpSession session,
	        Model model) {

		User loginUser = (User) session.getAttribute("loginUser");

	    try {
	        // 로그인 체크
	        if (loginUser == null) {
	            model.addAttribute("error", "로그인이 필요합니다.");
	            return "redirect:/login";
	        }

	        // Guide 객체 생성
	        Guide guide = new Guide();
	        guide.setGuideCategory(guideCategory);
	        guide.setGuideTitle(guideTitle);
	        guide.setGuideContent(guideContent);
	        guide.setUserId(loginUser.getUserId());

	        // 가이드 등록
	        int result = gService.insertGuide(guide);

	        if (result > 0) {
	            // 성공 시 목록 페이지로 리다이렉트
	            return "redirect:/community/guide";
	        } else {
	            model.addAttribute("error", "게시글 등록에 실패했습니다.");
	            // 실패 시 isEditMode와 guide 객체를 다시 전달해야 함
	            model.addAttribute("guide", guide); // 입력했던 내용 보존
	            model.addAttribute("isEditMode", false);
	            return "community/guide-write";
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("error", "게시글 등록 중 오류가 발생했습니다.");

	        // 실패 시 isEditMode와 입력값 보존된 guide 객체를 다시 전달
	        Guide guide = new Guide();
	 		guide.setGuideCategory(guideCategory);
	 		guide.setGuideTitle(guideTitle);
	 		guide.setGuideContent(guideContent);
	 		if (loginUser != null) {
	 			guide.setUserId(loginUser.getUserId());
	 		}

	        model.addAttribute("guide", guide); // 입력 값 보존
	        model.addAttribute("isEditMode", false);
	        return "community/guide-write";
	    }
	}

	// 가이드 수정 페이지 표시
	@GetMapping("/guide/edit/{id}")
	public String guideEditForm(
	        @PathVariable("id") int guideNo,
	        HttpSession session,
	        Model model) {

	    try {
	        // 로그인 체크
	        User loginUser = (User) session.getAttribute("loginUser");
	        if (loginUser == null) {
	            model.addAttribute("errorMessage", "로그인이 필요합니다.");
	            return "redirect:/login";
	        }

	        // 가이드 정보 조회
	        Guide guide = gService.getGuideDetail(guideNo, loginUser.getUserId());

	        if (guide == null) {
	            model.addAttribute("errorMessage", "존재하지 않는 게시글입니다.");
	            return "redirect:/community/guide";
	        }

	        // 작성자 본인 확인
	        if (!guide.getUserId().equals(loginUser.getUserId())) {
	            model.addAttribute("errorMessage", "수정 권한이 없습니다.");
	            return "redirect:/community/guide/" + guideNo;
	        }

	        model.addAttribute("guide", guide);
	        model.addAttribute("isEditMode", true); // Jsp에서 수정 모드임을 알림

	        return "community/guide-write"; // 'guide-write' 반환

	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("errorMessage", "게시글을 불러오는데 실패했습니다.");
	        return "redirect:/community/guide";
	    }
	}

	// 가이드 수정 처리
	@PostMapping("/guide/{id}/edit")
	public String guideEdit(
	        @PathVariable("id") int guideNo,
	        @RequestParam String guideCategory,
	        @RequestParam String guideTitle,
	        @RequestParam String guideContent,
	        HttpSession session,
	        Model model) {

		User loginUser = (User) session.getAttribute("loginUser");

	    try {
	        // 로그인 체크
	        if (loginUser == null) {
	            model.addAttribute("error", "로그인이 필요합니다.");
	            return "redirect:/login";
	        }

	        // 기존 가이드 조회
	        Guide existingGuide = gService.getGuideDetail(guideNo, loginUser.getUserId());

	        // 작성자 본인 확인
	        if (existingGuide == null || !existingGuide.getUserId().equals(loginUser.getUserId())) {
	            model.addAttribute("error", "수정 권한이 없거나 게시글이 존재하지 않습니다.");
	            // guideNo가 유효하지 않을 수 있으므로 목록으로 리다이렉트
	            return "redirect:/community/guide";
	        }

	        // Guide 객체 생성
	        Guide guide = new Guide();
	        guide.setGuideNo(guideNo);
	        guide.setGuideCategory(guideCategory);
	        guide.setGuideTitle(guideTitle);
	        guide.setGuideContent(guideContent);
	        guide.setUserId(loginUser.getUserId()); // 작성자는 변경되지 않음

	        // 가이드 수정
	        int result = gService.updateGuide(guide);

	        if (result > 0) {
	            // 성공 시 상세 페이지로 리다이렉트
	            return "redirect:/community/guide/" + guideNo;
	        } else {
	            model.addAttribute("error", "게시글 수정에 실패했습니다.");
	            model.addAttribute("guide", guide);
	            model.addAttribute("isEditMode", true); // 수정 모드임을 명시
	            return "community/guide-write"; // 'guide-write' 반환
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("error", "게시글 수정 중 오류가 발생했습니다.");

            // ✅ 수정: 생성자 대신 setter 사용
	        Guide guide = new Guide();
            guide.setGuideNo(guideNo);
            guide.setGuideCategory(guideCategory);
            guide.setGuideTitle(guideTitle);
            guide.setGuideContent(guideContent);
            if (loginUser != null) {
                guide.setUserId(loginUser.getUserId());
            }

            model.addAttribute("guide", guide); // 사용자가 입력한 값 보존
	        model.addAttribute("isEditMode", true);
	        return "community/guide-write";
	    }
	}

	// 가이드 삭제
	@DeleteMapping("/guide/{id}")
	@ResponseBody
	public Map<String, Object> guideDelete(
	        @PathVariable("id") int guideNo,
	        HttpSession session) {

	    Map<String, Object> response = new HashMap<>();

	    try {
	        // 로그인 체크
	        User loginUser = (User) session.getAttribute("loginUser");
	        if (loginUser == null) {
	            response.put("success", false);
	            response.put("message", "로그인이 필요합니다.");
	            return response;
	        }

	        // 가이드 정보 조회 (삭제 권한 확인용)
	        Guide guide = gService.getGuideDetail(guideNo, loginUser.getUserId());

	        // 게시글 존재 및 작성자 본인 확인
	        if (guide == null || !guide.getUserId().equals(loginUser.getUserId())) {
	            response.put("success", false);
	            response.put("message", "삭제 권한이 없거나 게시글이 존재하지 않습니다.");
	            return response;
	        }

	        // 가이드 삭제
	        int result = gService.deleteGuide(guideNo);

	        if (result > 0) {
	            response.put("success", true);
	            response.put("message", "게시글이 삭제되었습니다.");
	        } else {
	            response.put("success", false);
	            response.put("message", "게시글 삭제에 실패했습니다.");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        response.put("success", false);
	        response.put("message", "게시글 삭제 중 오류가 발생했습니다.");
	    }

	    return response;
	}


    // 가이드 목록
    @GetMapping("/guide")
    public String guideList(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false, defaultValue = "all") String category,
            @RequestParam(required = false, defaultValue = "1") int page,
            Model model) {
       try {
          // 카테고리 처리 ('all'이면 null로)
          String searchCategory = (category != null && !"all".equals(category)) ? category : null;

           int boardLimit = 10;
           int pageLimit = 5;
           int totalCount = gService.getGuideCount(keyword, searchCategory);
           int maxPage = (int) Math.ceil((double) totalCount / boardLimit);
           int startPage = ((page-1)/pageLimit) * pageLimit + 1; // 시작페이지(1, 6, 11, 16 ...)
           int endPage = startPage + pageLimit - 1;
           if(endPage > maxPage) {
        	   endPage = maxPage;
           }

           int offset = (page - 1) * boardLimit;

           List<Guide> guideList = gService.getGuideList(keyword, searchCategory, offset, boardLimit);

           List<Guide> popularGuides = gService.getPopularGuides();

          // List
          model.addAttribute("guideList", guideList);
          model.addAttribute("popularGuides", popularGuides);
          model.addAttribute("keyword", keyword);
          model.addAttribute("category", category);

          // 페이징
          model.addAttribute("currentPage", page);
          model.addAttribute("maxPage", maxPage);
          model.addAttribute("startPage", startPage);
          model.addAttribute("endPage", endPage);
          model.addAttribute("totalCount", totalCount);

      } catch (Exception e) {
         e.printStackTrace();
           model.addAttribute("errorMessage", "게시글 목록을 불러오는데 실패했습니다.");
      }

        return "community/guide";
    }

    // AJAX용 가이드 목록 (JSON 반환)
    @GetMapping("/guide/ajax")
    @ResponseBody
    public Map<String, Object> guideListAjax(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false, defaultValue = "all") String category,
            @RequestParam(required = false, defaultValue = "1") int page) {

        Map<String, Object> response = new HashMap<>();

        try {
            // 카테고리 처리 ('all'이면 null로)
            String searchCategory = (category != null && !"all".equals(category)) ? category : null;

            int boardLimit = 10;
            int pageLimit = 5;
            int totalCount = gService.getGuideCount(keyword, searchCategory);
            int maxPage = (int) Math.ceil((double) totalCount / boardLimit);
            int startPage = ((page-1)/pageLimit) * pageLimit + 1;
            int endPage = startPage + pageLimit - 1;
            if(endPage > maxPage) {
                endPage = maxPage;
            }

            int offset = (page - 1) * boardLimit;

            List<Guide> guideList = gService.getGuideList(keyword, searchCategory, offset, boardLimit);

            // 응답 데이터 구성
            response.put("success", true);
            response.put("guideList", guideList);
            response.put("currentPage", page);
            response.put("maxPage", maxPage);
            response.put("startPage", startPage);
            response.put("endPage", endPage);
            response.put("totalCount", totalCount);
            response.put("keyword", keyword);
            response.put("category", category);

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "게시글 목록을 불러오는데 실패했습니다.");
        }

        return response;
    }

    // 가이드 상세
    @GetMapping("/guide/{id}")
    public String guideDetail(@PathVariable("id") int guideNo,
            HttpSession session,
            Model model) {
        try {
            // 세션에서 현재 사용자 정보 가져오기
            String currentUserId = null;
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser != null) {
                currentUserId = loginUser.getUserId();
            }

            // 가이드 상세 정보 조회 (조회수 증가 포함)
            Guide guide = gService.getGuideDetail(guideNo, currentUserId);

            if (guide == null) {
                model.addAttribute("errorMessage", "존재하지 않는 게시글입니다.");
                return "redirect:/community/guide";
            }

            // 이전/다음 글 조회
            Guide prevGuide = gService.getPrevGuide(guideNo);
            Guide nextGuide = gService.getNextGuide(guideNo);

            // 댓글 목록 조회
            List<GuideComment> comments = cService.getCommentsByGuideNo(guideNo);

            // 각 가이드 댓글의 좋아요 상태 설정
            if (currentUserId != null && comments != null && !comments.isEmpty()) {
                for (GuideComment comment : comments) {
                    boolean commentLiked = clService.isGuideCommentLikedByUser(comment.getCommentId(), currentUserId);
                    comment.setLiked(commentLiked);
                }
            }

            // 좋아요 정보 조회
            int likeCount = lService.getLikeCount(guideNo);
            boolean isLiked = false;
            if (currentUserId != null) {
                isLiked = lService.isLikedByUser(guideNo, currentUserId);
            }

            model.addAttribute("guide", guide);
            model.addAttribute("prevGuide", prevGuide);
            model.addAttribute("nextGuide", nextGuide);
            model.addAttribute("comments", comments);
            model.addAttribute("likeCount", likeCount);
            model.addAttribute("isLiked", isLiked);

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "게시글을 불러오는데 실패했습니다.");
            return "redirect:/community/guide";
        }

        return "community/guide-detail";
    }

    // 가이드 좋아요
    @PostMapping("/guide/{id}/like")
    @ResponseBody
    public Map<String, Object> likeGuide(@PathVariable("id") int guideNo, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        try {
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return response;
            }

            String userId = loginUser.getUserId();

            // 좋아요 토글
            boolean isLiked = lService.toggleLike(guideNo, userId);
            int likeCount = lService.getLikeCount(guideNo);

            response.put("success", true);
            response.put("isLiked", isLiked);
            response.put("likeCount", likeCount);

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "좋아요 처리 중 오류가 발생했습니다.");
        }

        return response;
    }

    // 댓글 추가
    @PostMapping("/guide/{id}/comment")
    public String addComment(
            @PathVariable("id") int guideNo,
            @RequestParam String content,
            HttpSession session,
            Model model) { // RedirectAttributes attributes 추가 권장

        try {
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser == null) {
            	// 로그인 페이지로 리다이렉트 시키거나, 에러 메시지 전달 후 현재 페이지 유지
                // attributes.addFlashAttribute("errorMessage", "로그인이 필요합니다."); // RedirectAttributes 사용 시
                 model.addAttribute("errorMessage", "로그인이 필요합니다."); // Model 사용 시 (리다이렉트 후 사라짐)
                return "redirect:/community/guide/" + guideNo;
            }

            GuideComment comment = new GuideComment();
            comment.setGuideNo(guideNo);
            comment.setUserId(loginUser.getUserId());
            comment.setContent(content);

            cService.addComment(comment);

        } catch (Exception e) {
            e.printStackTrace();
            // 댓글 작성 실패 시 사용자에게 알림 (RedirectAttributes 사용 권장)
            // attributes.addFlashAttribute("errorMessage", "댓글 작성 중 오류가 발생했습니다.");
            model.addAttribute("errorMessage", "댓글 작성 중 오류가 발생했습니다.");
        }

        return "redirect:/community/guide/" + guideNo;
    }

    // 댓글 삭제
    @DeleteMapping("/guide/{guideId}/comment/{commentId}")
    @ResponseBody
    public Map<String, Object> deleteComment(
            @PathVariable("guideId") int guideNo, // 이 파라미터는 현재 로직에서 사용되지 않음
            @PathVariable("commentId") int commentId,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        try {
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return response;
            }

            String userId = loginUser.getUserId();
            // 서비스단에서 권한 확인(commentId와 userId 일치 여부) 후 삭제 진행
            int result = cService.deleteComment(commentId, userId);

            if (result > 0) {
                response.put("success", true);
                response.put("message", "댓글이 삭제되었습니다.");
            } else {
                response.put("success", false);
                // 실패 이유: 권한 없음 or DB 오류 등
                response.put("message", "댓글 삭제에 실패했습니다. (권한 확인 또는 서버 오류)");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "댓글 삭제 중 오류가 발생했습니다.");
        }

        return response;
    }

    // --- ✅ 댓글 수정 처리 메소드 추가 ---
    @PutMapping("/guide/{guideNo}/comment/{commentId}")
    @ResponseBody
    public Map<String, Object> updateComment(
            @PathVariable("guideNo") int guideNo,
            @PathVariable("commentId") int commentId,
            @RequestBody Map<String, String> payload, // JSON {"content": "..."} 받기
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();
        String newContent = payload.get("content"); // JSON에서 content 값 추출

        // 내용 유효성 검사 (간단 예시)
        if (newContent == null || newContent.trim().isEmpty()) {
            response.put("success", false);
            response.put("message", "댓글 내용이 비어있습니다.");
            return response;
        }

        try {
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return response;
            }
            String userId = loginUser.getUserId();

            // 서비스 호출 (서비스/매퍼에 updateComment 메소드 구현 필요)
            int result = cService.updateComment(commentId, userId, newContent.trim());

            if (result > 0) {
                response.put("success", true);
                response.put("message", "댓글이 수정되었습니다.");
            } else {
                response.put("success", false);
                // 실패 이유: 권한 없음 or DB 오류 등
                response.put("message", "댓글 수정에 실패했습니다. (권한 확인 또는 서버 오류)");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "댓글 수정 중 오류가 발생했습니다.");
        }
        return response;
    }

    // 가이드 댓글 좋아요
    @PostMapping("/guide/comment/{commentId}/like")
    @ResponseBody
    public Map<String, Object> toggleGuideCommentLike(
            @PathVariable("commentId") int commentId,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        try {
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return response;
            }

            String userId = loginUser.getUserId();

            // 가이드 댓글 좋아요 토글
            boolean isLiked = clService.toggleGuideCommentLike(commentId, userId);
            int likeCount = clService.getGuideCommentLikeCount(commentId);

            response.put("success", true);
            response.put("isLiked", isLiked);
            response.put("likeCount", likeCount);

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "가이드 댓글 좋아요 처리 중 오류가 발생했습니다.");
        }

        return response;
    }
}