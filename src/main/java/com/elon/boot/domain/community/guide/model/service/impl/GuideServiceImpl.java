package com.elon.boot.domain.community.guide.model.service.impl;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.elon.boot.domain.community.guide.model.service.GuideService;
import com.elon.boot.domain.community.guide.model.store.GuideMapper;
import com.elon.boot.domain.community.guide.model.vo.Guide;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class GuideServiceImpl implements GuideService {
	
	private final GuideMapper gStore;

	@Override
	public List<Guide> getGuideList(String keyword, String searchCategory, int offset, int limit) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return gStore.selectGuideList(keyword, searchCategory, rowBounds);
	}

	@Override
	public List<Guide> getPopularGuides() {
		return gStore.selectPopularGuides();
	}

	@Override
	public int getGuideCount(String keyword, String searchCategory) {
		return gStore.selectGuideCount(keyword, searchCategory);
	}

	@Override
	public Guide getGuideDetail(int guideNo, String currentUserId) {
		// 1. 조회수 증가
		gStore.increaseViewCount(guideNo);
		
		// 2. 가이드 상세 정보 조회 (작성자 닉네임, 카테고리명 포함)
		Guide guide = gStore.selectGuideDetail(guideNo);
		
		// 3. 현재 사용자의 좋아요 여부 확인
		if (guide != null && currentUserId != null) {
			boolean isLiked = gStore.checkUserLike(guideNo, currentUserId) > 0;
			guide.setLikedByUser(isLiked);
		}
		
		return guide;
	}

	@Override
	public Guide getPrevGuide(int guideNo) {
		return gStore.selectPrevGuide(guideNo);
	}

	@Override
	public Guide getNextGuide(int guideNo) {
		return gStore.selectNextGuide(guideNo);
	}

	@Override
	public int insertGuide(Guide guide) {
		return gStore.insertGuide(guide);
	}
	
	@Override
	public int updateGuide(Guide guide) {
		return gStore.updateGuide(guide);
	}
	
	@Override
	public int deleteGuide(int guideNo) {
		// 물리적 삭제 대신 논리적 삭제 (DELETE_YN = 'Y')
		return gStore.deleteGuide(guideNo);
	}
}
