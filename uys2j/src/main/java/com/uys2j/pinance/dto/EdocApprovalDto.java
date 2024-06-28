package com.uys2j.pinance.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class EdocApprovalDto {
	private int aprvlNo;
	private int documentNo;
	private String status;
	private String aprvlComment;
	private String aprvlDate;
	private int aprvlRank;
	private String aprvluserName;
	private String aprvluserCr;
	private String aprvluserId;
	
	private DefaultDto defaultDto;
	
	private AttachDto attachDto;
	
}
