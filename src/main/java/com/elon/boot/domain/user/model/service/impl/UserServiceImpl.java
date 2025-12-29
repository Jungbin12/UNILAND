package com.elon.boot.domain.user.model.service.impl;

import org.springframework.stereotype.Service;

import com.elon.boot.controller.dto.user.UserModRequest;
import com.elon.boot.domain.user.model.service.UserService;
import com.elon.boot.domain.user.model.store.UserMapper;
import com.elon.boot.domain.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;

    @Override
    public User login(String userId, String userPassword) {
        User user = new User();
        user.setUserId(userId);
        user.setUserPassword(userPassword);
        return userMapper.selectOneByLogin(user);
    }

    @Override
    public User getUserById(String userId) {
        return userMapper.selectOneById(userId);
    }

    @Override
    public User getUserByEmail(String userEmail) {
        return userMapper.selectOneByEmail(userEmail);
    }

    @Override
    public User getUserByPhone(String userPhone) {
        return userMapper.selectOneByPhone(userPhone);
    }

    @Override
    public int signUp(User user) {
        return userMapper.insertUser(user);
    }

    @Override
    public int updateUser(UserModRequest user) {
        return userMapper.updateUser(user);
    }

    @Override
    public int deleteUser(String userId) {
        return userMapper.deleteUser(userId);
    }

    @Override
    public boolean checkDuplicateId(String userId) {
        User user = userMapper.selectOneById(userId);
        return user != null;  // true면 중복
    }
}
