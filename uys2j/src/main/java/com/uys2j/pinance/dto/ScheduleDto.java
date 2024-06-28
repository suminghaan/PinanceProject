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
public class ScheduleDto {
	private int scNo;
	private String scName;
	private String scType;
	private String scContent;
	private String scStart;
	private String scEnd;
	private String scColor;
	private String scCategory;
	private String scShare;
	private String status;
	private String facName;
	private String regId;
	private String regTime;
	private String modId;
	private String modTime;
	private String scStartDate;
	private String scStartTime;
	private String scEndDate;
	private String scEndTime;

}
