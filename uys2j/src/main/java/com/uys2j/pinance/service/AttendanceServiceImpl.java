package com.uys2j.pinance.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.uys2j.pinance.dao.AttendanceDao;
import com.uys2j.pinance.dto.AttendanceDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.VacationDto;
import com.uys2j.pinance.dto.VacationInformationDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Service
@Slf4j
public class AttendanceServiceImpl implements AttendanceService {
	private final AttendanceDao attendanceDao;

	@Override
	public int insertWorkIn(MemberDto m) {
		return attendanceDao.insertWorkIn(m);
	}

	@Override
	public int insertWorkOut(MemberDto m) {
		return attendanceDao.insertWorkOut(m);
	}

	@Override
	public AttendanceDto selectWork(MemberDto m) {
		return attendanceDao.selectWork(m);
	}

	@Override
	public VacationInformationDto selectVacInfo(int userNo) {
		return attendanceDao.selectVacInfo(userNo);
	}

	@Override
	public List<AttendanceDto> selectAttendanceList(String regId) {
		List<AttendanceDto> attendanceList = attendanceDao.selectAttendance(regId);

		int lateCount = 0;
		int earlyLeaveCount = 0;
		int absentCount = 0;
		int workDays = 0;
		int workHours = 0;

		for (AttendanceDto attendance : attendanceList) {
			if (attendance.getIsLate() == 1) {
				lateCount++;
			}
			if (attendance.getIsEarlyLeave() == 1) {
				earlyLeaveCount++;
			}
			if (attendance.getIsAbsent() == 1) {
				absentCount++;
			} else {
				workDays++;
				workHours += attendance.getWorkHours();
			}
		}

		for (AttendanceDto attendance : attendanceList) {
			attendance.setLateCount(lateCount);
			attendance.setEarlyLeaveCount(earlyLeaveCount);
			attendance.setAbsentCount(absentCount);
			attendance.setWorkDays(workDays);
			attendance.setWorkHours(workHours);
		}

		return attendanceList;
	}

	@Override
	public List<VacationInformationDto> selectVacInfoList(VacationInformationDto vo) {
		return attendanceDao.selectVacInfoList(vo);
	}

	@Override
	public List<VacationDto> selectVacation(int userNo) {
		return attendanceDao.selectVacation(userNo);
	}

	@Override
	public List<VacationDto> empVacationList(String vacMonth, String userId) {
	    return attendanceDao.empVacationList(vacMonth, userId);
	}

	@Override
	public List<AttendanceDto> empAttendanceList(String userId) {
	    List<AttendanceDto> empAtt = attendanceDao.empAttendanceList(userId);

	    int lateCount = 0;
	    int earlyLeaveCount = 0;
	    int absentCount = 0;
	    int workDays = 0;
	    int workHours = 0;

	    for (AttendanceDto attendance : empAtt) {
	        if (attendance.getIsLate() == 1) {
	            lateCount++;
	        }
	        if (attendance.getIsEarlyLeave() == 1) {
	            earlyLeaveCount++;
	        }
	        if (attendance.getIsAbsent() == 1) {
	            absentCount++;
	        } else {
	            workDays++;
	            workHours += attendance.getWorkHours();
	        }
	    }

	    for (AttendanceDto attendance : empAtt) {
	        attendance.setLateCount(lateCount);
	        attendance.setEarlyLeaveCount(earlyLeaveCount);
	        attendance.setAbsentCount(absentCount);
	        attendance.setWorkDays(workDays);
	        attendance.setWorkHours(workHours);
	    }
	    log.debug("service {}", empAtt);
	    return empAtt;
	}

	@Override
	public int absentDay(MemberDto m) {
		return attendanceDao.absentDay(m);
	}

	@Override
	public List<MemberDto> nullUserId() {
		return attendanceDao.nullUserId();
	}

}
