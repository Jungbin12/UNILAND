package com.elon.boot.domain.community.guide.model.service;

public interface GuideCommentLikeService {
    
    // 가이드 댓글 좋아요 토글 (추가/취소)
    boolean toggleGuideCommentLike(int commentId, String userId);
    
    // 가이드 댓글 좋아요 수 조회
    int getGuideCommentLikeCount(int commentId);
    
    // 사용자가 가이드 댓글에 좋아요 했는지 확인
    boolean isGuideCommentLikedByUser(int commentId, String userId);
}