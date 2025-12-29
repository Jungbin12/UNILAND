package com.elon.boot.domain.community.guide.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GuideComment {
    private int commentId; 
    private int guideNo;   
    private String userId;  
    private String content;   
    private Date createdAt; 
    private String deleteYn;
    
    // ⭐ 가이드 댓글 좋아요 관련 필드 추가
    private int likeCount;      // 가이드 댓글 좋아요 수
    private boolean Liked;    // 현재 사용자가 가이드 댓글에 좋아요 했는지
}
