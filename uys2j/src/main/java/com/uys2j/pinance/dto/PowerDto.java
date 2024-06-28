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
public class PowerDto {
	private int powerNo;
	private int userNo;
	private int menuNo;
	private String powerName;
	private String status;
	private DefaultDto defaultDto;
}
