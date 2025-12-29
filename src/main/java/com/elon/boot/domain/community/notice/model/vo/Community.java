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
public class Community {
	private int communityNo;
    private String userId;
    private String title;
    private String content;
    private Timestamp createdAt;
}
