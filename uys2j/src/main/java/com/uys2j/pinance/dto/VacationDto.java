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
public class VacationDto {
	
	private int vacNo;
	private int userNo;
	private int vactypeNo;
	private String vacStart;
	private String vacEnd;
	private String vacStatus;
	private DefaultDto defaultDto;
	private int refNo;
	private int distanceDay;
	private String userName;
	private String vacMonth;
}
