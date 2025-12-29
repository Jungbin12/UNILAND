package com.elon.boot.domain.interest.service;

import java.util.List;

import com.elon.boot.domain.interest.vo.Interest;

public interface InterestService {

	int countFavorites(Long propertyNo);

	boolean isFavorited(Interest interest);

	boolean toggle(Interest interest);

	List<Interest> getListById(String userId);

}
