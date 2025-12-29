package com.elon.boot.domain.community.guide.model.service;

import java.util.List;

import com.elon.boot.domain.community.guide.model.vo.GuideComment;

public interface GuideCommentService {

	List<GuideComment> getCommentsByGuideNo(int guideNo);

	int addComment(GuideComment comment);

	int deleteComment(int commentId, String userId);

	/**
     * 댓글 내용을 수정하는 메소드
     * @param commentId 수정할 댓글 ID
     * @param userId 수정을 시도하는 사용자 ID (작성자 확인용)
     * @param content 수정할 새 내용
     * @return 수정 성공 시 1, 실패 시 0
     */
    int updateComment(int commentId, String userId, String content);

}
