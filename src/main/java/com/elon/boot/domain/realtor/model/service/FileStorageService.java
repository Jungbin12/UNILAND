package com.elon.boot.domain.realtor.model.service;
import java.io.IOException;
import org.springframework.web.multipart.MultipartFile;

//FileStorageService.java
public interface FileStorageService {
 // ⭐ 반드시 throws IOException이 포함되어야 합니다.
 String saveProfileImage(MultipartFile file) throws IOException; 
}