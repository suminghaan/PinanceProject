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
public class AttendanceDto {
	
	private int workNo;
	private String workIn;
	private String workOut;
	private DefaultDto defaultDto;
	
	private String workInCount;
	private String weekdayCount;
	
	private int lateCount;
	private int isLate;
	private int earlyLeaveCount;
    private int isEarlyLeave;
    private int absentCount;
    private int isAbsent;
    private int workHours;
    private int workDays;
    private String workDate;
    private String userName; 
    private String workMonth;
    private String department;
}
