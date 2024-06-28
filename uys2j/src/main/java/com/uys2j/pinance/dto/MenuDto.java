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
public class MenuDto {
	private int menuNo;
	private String menuType;
	private String menuName;
	private String menuTop;
	private String menuShow;
	private String status;
	private DefaultDto defaultDto;
}
