package com.elon.boot.domain.community.notice.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Notice {
	private Integer 	noticeNo;           // 공지사항 번호
	private String 		userId;        		// 작성자 아이디 (USER_ID)
    private String 		noticeSubject;      // 제목
    private String 		noticeContent;      // 내용
    private String 		noticeWriter;		// 작성자
    private Timestamp 	noticeCreateat;   	// 작성일시
    private String 		noticeImportant;	// 중요 공지 여부
    private String 		noticeIsnew;		// 신규 공지 여부
    private Integer 	viewCount;	        // 조회수
    private String 		deleteYn;           // 삭제 여부 (Y/N)
}
