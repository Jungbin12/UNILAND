package com.elon.boot.domain.community.guide.model.store;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface GuideCommentLikeMapper {
    
    // 가이드 댓글 좋아요 추가
    int insertGuideCommentLike(@Param("commentId") int commentId, @Param("userId") String userId);
    
    // 가이드 댓글 좋아요 취소
    int deleteGuideCommentLike(@Param("commentId") int commentId, @Param("userId") String userId);
    
    // 가이드 댓글 좋아요 수 조회
    int selectGuideCommentLikeCount(@Param("commentId") int commentId);
    
    // 사용자가 가이드 댓글에 좋아요 했는지 확인
    int isGuideCommentLikedByUser(@Param("commentId") int commentId, @Param("userId") String userId);
}