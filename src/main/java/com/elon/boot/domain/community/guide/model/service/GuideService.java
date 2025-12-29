package com.elon.boot.domain.community.guide.model.service;

import java.util.List;

import com.elon.boot.domain.community.guide.model.vo.Guide;

public interface GuideService {

	List<Guide> getGuideList(String keyword, String searchCategory, int offset, int limit);

	List<Guide> getPopularGuides();

	int getGuideCount(String keyword, String searchCategory);

	Guide getGuideDetail(int guideNo, String currentUserId);

	Guide getPrevGuide(int guideNo);

	Guide getNextGuide(int guideNo);

	int insertGuide(Guide guide);
	
	int updateGuide(Guide guide);
	
	int deleteGuide(int guideNo);

}
