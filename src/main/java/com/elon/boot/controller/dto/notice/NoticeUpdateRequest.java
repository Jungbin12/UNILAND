package com.elon.boot.controller.dto.notice;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class NoticeUpdateRequest {
    private int noticeNo;
    private String noticeSubject;
    private String noticeContent;
    private String noticeImportant;  // Y/N
    private String noticeIsNew;      // Y/N
}
