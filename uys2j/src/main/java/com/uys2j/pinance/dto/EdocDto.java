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
public class EdocDto {
	private int docNo;
	private String docTitle;
	private String docContent;
	private String docCode;
	private String tempSave;
	private String status;
	private String preservePeriod;
	private String secCode;
	private Date finTime;
	
	private String apUserid;
	private String refUserid;
	private String eaStatus;
	
	private DefaultDto defaultDto;
	private List<AttachDto> attachList;
	private SampleDto sampleDto;
	
}
