package com.uys2j.pinance.dto;

import java.sql.Date;
import java.util.List;

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
public class SampleDto {
	private int sampleNo;
	private String sampleCode;
	private String codeList;
	private String userName;
	private String sampleTitle;
	private String sampleDesc;
	private String sampleContent;
	private String status;
	private List<AttachDto> attachList;
	private DefaultDto defaultDto;
}
