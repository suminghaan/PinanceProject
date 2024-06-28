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
public class CommonDto {
	private int commonNo;
	private String value;
	private String name;
	private String level;
	private String status;
	private DefaultDto defaultDto;
}
