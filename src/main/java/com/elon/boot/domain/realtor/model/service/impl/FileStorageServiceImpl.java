package com.elon.boot.domain.realtor.model.service.impl;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.elon.boot.domain.realtor.model.service.FileStorageService;

@Service // Spring Bean으로 등록하여 주입 가능하도록 설정
public class FileStorageServiceImpl implements FileStorageService {

    // ⚠️ 파일이 실제로 저장될 서버 경로를 지정합니다. (프로젝트 루트 경로 자동 인식)
    private final Path uploadLocation = Paths.get(System.getProperty("user.dir"), "src/main/webapp/assets/profile"); 

    // 생성자: 업로드 디렉토리가 없으면 생성
    public FileStorageServiceImpl() {
        try {
            Files.createDirectories(this.uploadLocation);
        } catch (IOException e) {
            // 디렉토리 생성 실패 시 예외 처리
            throw new RuntimeException("프로필 이미지 저장 디렉토리를 생성할 수 없습니다.", e);
        }
    }

    @Override
    public String saveProfileImage(MultipartFile file) throws IOException {
        String originalFilename = file.getOriginalFilename();
        
        // 1. 파일명 중복 방지를 위해 UUID와 확장자를 조합
        String extension = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        String savedFileName = UUID.randomUUID().toString() + extension;
        
        // 2. 파일을 지정된 경로에 복사하여 저장
        Path destinationFile = this.uploadLocation.resolve(
            Paths.get(savedFileName))
            .normalize().toAbsolutePath();
        
        // 파일의 InputStream을 사용하여 저장
        Files.copy(file.getInputStream(), destinationFile, StandardCopyOption.REPLACE_EXISTING);
        
        // DB에 저장할 파일명 (경로 없이 파일 이름만) 반환
        return savedFileName;
    }
}