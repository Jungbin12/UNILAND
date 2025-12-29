package com.elon.boot.domain.community.guide.model.store;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface GuideLikeMapper {

    int selectLikeCount(@Param("guideNo") int guideNo);

    int isLikedByUser(@Param("guideNo") int guideNo, @Param("userId") String userId);

    // [추가] 1단계 XML에서 추가한 쿼리를 호출할 메소드 선언
    void insertLike(@Param("guideNo") int guideNo, @Param("userId") String userId);
    
    // [추가]
    int deleteLike(@Param("guideNo") int guideNo, @Param("userId") String userId);
}