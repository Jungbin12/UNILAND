package com.elon.boot.domain.realtor.model.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.elon.boot.domain.realtor.model.store.RealtorMapper;
import com.elon.boot.domain.realtor.model.vo.Realtor;
import com.elon.boot.domain.realtor.model.service.RealtorService;

@Service
public class RealtorServiceImpl implements RealtorService {

    @Autowired
    private RealtorMapper realtorMapper;

    @Override
    public boolean isBusinessNumDuplicate(String businessNum) {
        return realtorMapper.countByBusinessNum(businessNum) > 0;
    }
    
    @Override
    public boolean isRealtorRegNumDuplicate(String realtorRegNum) {
        return realtorMapper.countByRealtorRegNum(realtorRegNum) > 0;
    }

    @Override
    @Transactional
    public boolean registerRealtor(Realtor realtor) {
        realtor.setApprovalStatus("PENDING"); 
        return realtorMapper.insertRealtor(realtor) > 0;
    }

    @Override
    public Realtor getRealtorByLogin(String realtorId, String password, String businessNumber) {
        return realtorMapper.findByLoginInfo(realtorId, password, businessNumber);
    }

    @Override
    public Realtor getRealtorById(String realtorId) {
        return realtorMapper.findById(realtorId);
    }

    @Override
    @Transactional
    public boolean updateRealtor(Realtor realtor) {
        int result = realtorMapper.updateRealtor(realtor);
        return result > 0;
    }

    @Override
    @Transactional
    public boolean deleteRealtor(String realtorId) {
        int result = realtorMapper.deleteRealtor(realtorId);
        return result > 0;
    }

    @Override
    @Transactional
    public boolean updateRealtorImage(String realtorId, String savedFileName) {
        Map<String, Object> params = new HashMap<>();
        params.put("realtorId", realtorId);
        params.put("realtorImage", savedFileName);
        int result = realtorMapper.updateRealtorImage(params);
        return result > 0;
    }

    // ⭐ 추가: 이메일로 중개사 조회 (비밀번호 찾기용)
    @Override
    public Realtor getRealtorByEmail(String email) {
        return realtorMapper.findByEmail(email);
    }

    // ⭐ 추가: 전화번호로 중개사 조회 (비밀번호 찾기용)
    @Override
    public Realtor getRealtorByPhone(String phone) {
        return realtorMapper.findByPhone(phone);
    }
}
