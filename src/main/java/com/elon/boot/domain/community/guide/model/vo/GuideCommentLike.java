package com.elon.boot.domain.community.guide.model.vo;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GuideCommentLike {
    private int commentId;
    private String userId;
    private Date createdAt;
}