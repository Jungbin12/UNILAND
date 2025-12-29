package com.elon.boot.domain.community.guide.model.service;

public interface GuideLikeService {

	int getLikeCount(int guideNo);

	boolean isLikedByUser(int guideNo, String currentUserId);

	boolean toggleLike(int guideNo, String userId);

}
