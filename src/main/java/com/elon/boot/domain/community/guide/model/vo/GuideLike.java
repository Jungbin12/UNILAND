package com.elon.boot.domain.community.guide.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GuideLike {
    
    private int likeNo;       // 좋아요 번호
    private int guideNo;      // 게시글 번호
    private String userId;    // 사용자 ID
    private Date likeDate;    // 좋아요 날짜
}
