package com.elon.boot.domain.community.guide.model.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; // Transactional 임포트

import com.elon.boot.domain.community.guide.model.service.GuideLikeService;
import com.elon.boot.domain.community.guide.model.store.GuideLikeMapper;
import com.elon.boot.domain.community.guide.model.store.GuideMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class GuideLikeServiceImpl implements GuideLikeService {
	
	private final GuideLikeMapper lStore;
	private final GuideMapper gStore;

	@Override
	public int getLikeCount(int guideNo) {
		return lStore.selectLikeCount(guideNo);
	}

	@Override
	public boolean isLikedByUser(int guideNo, String currentUserId) {
		return lStore.isLikedByUser(guideNo, currentUserId) > 0;
	}

	@Override
	@Transactional // 좋아요/취소는 DB 작업을 2번 하므로 트랜잭션 처리
	public boolean toggleLike(int guideNo, String userId) {
		// [수정] TODO 로직을 실제 코드로 구현
        // 1. 현재 좋아요 상태 확인
		boolean isAlreadyLiked = isLikedByUser(guideNo, userId);
		
		if(isAlreadyLiked) {
			// 2. 이미 좋아요를 눌렀다면 -> 좋아요 취소 (delete)
			lStore.deleteLike(guideNo, userId);
			
			// [수정] GUIDE_TBL의 LIKE_COUNT 업데이트
			gStore.updateLikeCount(guideNo);
						
			return false; // "좋아요 취소됨" 상태 반환
		} else {
			// 3. 좋아요를 누르지 않았다면 -> 좋아요 추가 (insert)
			lStore.insertLike(guideNo, userId);
			
			// [수정] GUIDE_TBL의 LIKE_COUNT 업데이트
			gStore.updateLikeCount(guideNo);
			
			return true; // "좋아요 눌림" 상태 반환
		}
	}

}