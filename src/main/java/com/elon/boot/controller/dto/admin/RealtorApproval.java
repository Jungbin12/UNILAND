package com.elon.boot.controller.dto.admin;

import java.util.List;

import com.elon.boot.domain.realtor.model.vo.Realtor;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class RealtorApproval {
	private List<Realtor> pendingRealtors;   // 승인대기
    private List<Realtor> approvedRealtors;  // 승인완료
    private List<Realtor> rejectedRealtors;  // 거부됨
}
