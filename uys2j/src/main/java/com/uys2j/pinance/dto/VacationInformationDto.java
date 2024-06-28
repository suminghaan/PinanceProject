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
public class VacationInformationDto {
	
	private int userNo;
	private String vacYear;
	private int vacTotal;
	private double vacLeft;
	private String vac;
	
	private DefaultDto defaultDto;
}
