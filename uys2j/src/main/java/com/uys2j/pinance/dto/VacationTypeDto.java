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
public class VacationTypeDto {
	
	private int vactypeNo;
	private String vactypeName;
	private DefaultDto defaultDto;

}
