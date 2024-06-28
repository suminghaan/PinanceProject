package com.uys2j.pinance.dto;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class SaveApprovalDto {

	private int saNo;
	private String saTitle;
	private String saRank;
	private String saUserId;
	private String status;
	private String regTime;
	private String userName;
	
	
	private DefaultDto defaultDto;
}
