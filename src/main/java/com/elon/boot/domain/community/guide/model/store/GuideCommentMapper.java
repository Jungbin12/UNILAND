package com.elon.boot.domain.community.guide.model.store;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.elon.boot.domain.community.guide.model.vo.GuideComment;

@Mapper
public interface GuideCommentMapper {

	List<GuideComment> selectCommentsByGuideNo(@Param("guideNo") int guideNo);

	int insertComment(GuideComment comment);

	int deleteComment(@Param("commentId") int commentId, @Param("userId") String userId);

	GuideComment selectCommentById(@Param("commentId") int commentId);

	void updateCommentCount(@Param("guideNo") int guideNo, @Param("increment") int increment);

	int updateComment(@Param("commentId") int commentId,
            @Param("userId") String userId,
            @Param("content") String content);
	
}
