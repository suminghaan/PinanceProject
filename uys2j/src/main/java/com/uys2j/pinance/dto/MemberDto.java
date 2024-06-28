package com.uys2j.pinance.dto;

import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class MemberDto {
	private int userNo;
	private String userId;
	private String userPwd;
	private String userName;
	private String email;
	private String phone;
	private String address;
	private String addressDetail;
	private String post;
	private String birth;
	private String position;
	private String positionName;
	private String rank;
	private String rankName;
	private String department;
	private String departmentName;
	private String branchOffice;
	private String branchOfficeName;
	private String direction;
	private String status;
	private String employDate;
	private String accountName;
	private String accountNo;
	private String profilePath;
	private int signCount;
	private String memStatus;
	
	private String dept;
	
	
	private DefaultDto defaultDto;
}
