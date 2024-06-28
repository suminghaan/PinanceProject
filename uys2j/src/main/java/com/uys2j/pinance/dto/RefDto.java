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
public class RefDto {
	private int refperNo;
	private int refEdocNo;
	private String refUserId;
	private String refUserName;
	private String status;
	private DefaultDto defaultDto;

}
