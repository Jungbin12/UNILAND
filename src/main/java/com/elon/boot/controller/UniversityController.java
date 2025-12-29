package com.elon.boot.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/api")
public class UniversityController {

    @Value("${university.api.key}")
    private String apiKey;

    @Value("${university.api.url}")
    private String apiUrl;

    @GetMapping("/universities")
    public ResponseEntity<String> getUniversities(@RequestParam String region) {
        try {
            // API URL 생성
            String url = String.format(
                "%s?apiKey=%s&svcType=api&svcCode=SCHOOL&gubun=univ_list&contentType=json&region=%s&sch1=100323&perPage=100",
                apiUrl, apiKey, region
            );

            System.out.println("Requesting URL: " + url);

            // RestTemplate으로 API 호출 (리다이렉트 따라가기)
            RestTemplate restTemplate = new RestTemplate();
            
            HttpHeaders headers = new HttpHeaders();
            headers.add("User-Agent", "Mozilla/5.0");
            HttpEntity<String> entity = new HttpEntity<>(headers);
            
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
            
            System.out.println("Response status: " + response.getStatusCode());
            System.out.println("Response body: " + response.getBody());

            return ResponseEntity.ok(response.getBody());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError()
                .body("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
}