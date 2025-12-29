package com.elon.boot.domain.interest.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.elon.boot.domain.interest.service.InterestService;
import com.elon.boot.domain.interest.store.InterestMapper;
import com.elon.boot.domain.interest.vo.Interest;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InterestServiceImpl implements InterestService {

	private final InterestMapper iMapper;
	
	@Override
	public int countFavorites(Long propertyNo) {
	    return iMapper.countFavoritesOfProperty(propertyNo);
	}

	@Override
	public boolean isFavorited(Interest interest) {
		Interest found = iMapper.findByUserAndProperty(interest);
		return found != null && "Y".equals(found.getIsFavorite());
	}

    @Override
    @Transactional
    public boolean toggle(Interest interest) {
        Interest found = iMapper.findByUserAndProperty(interest);
        if (found == null) {
        	iMapper.insertFavorite(interest); // 최초 Y
            return true;
        }
        iMapper.toggleFavorite(interest);     // 토글
        return isFavorited(interest);             
    }

	@Override
	public List<Interest> getListById(String userId) {
		
		return iMapper.getListById(userId);
	}

}
