package com.elon.boot.domain.community.guide.model.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.elon.boot.domain.community.guide.model.service.GuideCommentService;
import com.elon.boot.domain.community.guide.model.store.GuideCommentMapper;
import com.elon.boot.domain.community.guide.model.vo.GuideComment;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class GuideCommentServiceImpl implements GuideCommentService{
	
	private final GuideCommentMapper cStore;

	@Override
	public List<GuideComment> getCommentsByGuideNo(int guideNo) {
		return cStore.selectCommentsByGuideNo(guideNo);
	}

	@Override
	public int addComment(GuideComment comment) {
		int result = cStore.insertComment(comment);
	    
	    // 댓글 작성 성공 시 가이드의 댓글 수 증가
	    if (result > 0) {
	        cStore.updateCommentCount(comment.getGuideNo(), 1);
	    }
	    
	    return result;
		
	}

	@Override
	public int deleteComment(int commentId, String userId) {
		// 댓글 정보 먼저 조회
	    GuideComment comment = cStore.selectCommentById(commentId);
	    
	    // 댓글 삭제
	    int result = cStore.deleteComment(commentId, userId);
	    
	    // 댓글 삭제 성공 시 가이드의 댓글 수 감소
	    if (result > 0 && comment != null) {
	        cStore.updateCommentCount(comment.getGuideNo(), -1);
	    }
	    
	    return result;
	}

    @Override
    @Transactional // 데이터 변경 작업이므로 Transactional 추가 권장
    public int updateComment(int commentId, String userId, String content) {
        // 매개변수로 Map을 사용하거나, 별도 DTO를 만들어 전달할 수도 있음
        // 여기서는 Mapper 메소드에서 @Param을 사용하는 것을 가정
        return cStore.updateComment(commentId, userId, content);
	}

}
