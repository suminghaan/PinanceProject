package com.uys2j.pinance.dto;

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
public class DepartmentDto {
	private int deptNo;
	private String deptValue;
	private String deptUpstair;
	private String status;
	private String commonName;
	private String department;
	private String upstairName;
	private String childName;
	
	private DefaultDto defaultDto;
	
}
