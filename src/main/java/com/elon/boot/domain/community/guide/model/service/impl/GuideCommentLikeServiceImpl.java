package com.elon.boot.domain.community.guide.model.service.impl;

import org.springframework.stereotype.Service;
import com.elon.boot.domain.community.guide.model.service.GuideCommentLikeService;
import com.elon.boot.domain.community.guide.model.store.GuideCommentLikeMapper;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class GuideCommentLikeServiceImpl implements GuideCommentLikeService {
    
    private final GuideCommentLikeMapper gclStore;
    
    @Override
    public boolean toggleGuideCommentLike(int commentId, String userId) {
        // 이미 좋아요를 눌렀는지 확인
        int isLiked = gclStore.isGuideCommentLikedByUser(commentId, userId);
        
        if (isLiked > 0) {
            // 좋아요 취소
            gclStore.deleteGuideCommentLike(commentId, userId);
            return false;
        } else {
            // 좋아요 추가
            gclStore.insertGuideCommentLike(commentId, userId);
            return true;
        }
    }
    
    @Override
    public int getGuideCommentLikeCount(int commentId) {
        return gclStore.selectGuideCommentLikeCount(commentId);
    }
    
    @Override
    public boolean isGuideCommentLikedByUser(int commentId, String userId) {
        return gclStore.isGuideCommentLikedByUser(commentId, userId) > 0;
    }
}