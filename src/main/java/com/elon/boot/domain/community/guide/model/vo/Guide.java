package com.elon.boot.domain.community.guide.model.vo;

import java.sql.Timestamp;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Guide {
	private int guideNo;
	private String userId;
	private String guideCategory;
	private String guideTitle;          
	private String guideContent;
	private int viewCount;
	private int likeCount;
	private int commentCount;
	private String isHot;
	private Timestamp writeDate;
	private Timestamp updateDate;
	private String deleteYn;
	
    // JSP에서 필요한 추가 필드들
    private String authorNickname;      // 작성자 닉네임 (조인 필요)
    private String categoryName;        // 카테고리명 (조인 필요)
    private boolean isLikedByUser;      // 현재 사용자의 좋아요 여부
}
