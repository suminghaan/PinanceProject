package com.uys2j.pinance.scheduler;

import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.service.AttendanceService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Component
public class AttendanceScheduler {
	
	private final AttendanceService attendanceService;
	
	@Scheduled(cron = "59 59 23 * * MON-FRI")
    public void insertAbsentDays() {
        List<MemberDto> absentEmployees = attendanceService.nullUserId();
        if (absentEmployees == null || absentEmployees.isEmpty()) {
            log.debug("No absent employees found");
        } else {
            for (MemberDto employee : absentEmployees) {
                attendanceService.absentDay(employee);
                log.debug("Inserted absent record for user: {}", employee.getUserId());
            }
        }

        log.debug("Scheduler completed");
    }
	
	
}
