package com.elon.boot.domain.community.guide.model.store;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import com.elon.boot.domain.community.guide.model.vo.Guide;

@Mapper
public interface GuideMapper {

	List<Guide> selectGuideList(@Param("keyword") String keyword, 
								@Param("category") String searchCategory, 
								RowBounds rowBounds);

	 List<Guide> selectPopularGuides();

	 int selectGuideCount(@Param("keyword") String keyword, 
			 			  @Param("category") String searchCategory);

	
	 Guide selectGuideDetail(@Param("guideNo") int guideNo);
	
	
	 int increaseViewCount(@Param("guideNo") int guideNo);
	
	
	 int checkUserLike(@Param("guideNo") int guideNo, @Param("userId") String userId);
	
	
	 Guide selectPrevGuide(@Param("guideNo") int guideNo);
	
	
	 Guide selectNextGuide(@Param("guideNo") int guideNo);
	 
	 void updateLikeCount(@Param("guideNo") int guideNo);
	 
	int insertGuide(Guide guide);
	
	int updateGuide(Guide guide);
	
	int deleteGuide(@Param("guideNo") int guideNo);
}