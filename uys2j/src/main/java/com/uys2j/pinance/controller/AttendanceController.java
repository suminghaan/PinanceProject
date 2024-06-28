package com.uys2j.pinance.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.uys2j.pinance.dto.AttendanceDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.VacationDto;
import com.uys2j.pinance.dto.VacationInformationDto;
import com.uys2j.pinance.service.AttendanceService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/attendance")
@RequiredArgsConstructor
@Controller
public class AttendanceController {
	
	private final AttendanceService attendanceService;

    @GetMapping("/myAttendance.page")
    public ModelAndView myAttendanceForm(int no, HttpSession session, ModelAndView mv) {
    	
        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        String userId = loginUser.getUserId();

        List<AttendanceDto> att = attendanceService.selectAttendanceList(userId);
        VacationInformationDto vo = attendanceService.selectVacInfo(no);
        int lateCount = att.isEmpty() ? 0 : att.get(0).getLateCount();
        int earlyLeaveCount = att.isEmpty() ? 0 : att.get(0).getEarlyLeaveCount();
        int absentCount = att.isEmpty() ? 0 : att.get(0).getAbsentCount();
        int workDays = att.isEmpty() ? 0 : att.get(0).getWorkDays();
        int workHours = att.isEmpty() ? 0 : att.get(0).getWorkHours();
       
        mv.addObject("vo", vo)
          .addObject("att", att)
          .addObject("lateCount", lateCount)
          .addObject("earlyLeaveCount", earlyLeaveCount)
          .addObject("absentCount", absentCount)
          .addObject("workDays", workDays)
          .addObject("workHours", workHours)
          .setViewName("attendance/myAttendance");

        return mv;
    }
    
    @ResponseBody
    @GetMapping("/selectAtt.sc")
    public List<AttendanceDto> ajaxAttendance(String regId) {
    	return attendanceService.selectAttendanceList(regId);
    }
    
    @GetMapping("/vacationInfo.page")
	public String vacationInfo(int no, Model model) {
    	model.addAttribute("v", attendanceService.selectVacation(no));
		return "/attendance/vacationInfo";
	}
    
    @ResponseBody
    @GetMapping("/vacationInfo.year")
    public List<VacationInformationDto> ajaxVacationYear(VacationInformationDto vo) {
    	 return attendanceService.selectVacInfoList(vo);
    }
    
    @GetMapping("/attendanceManage.page")
    public String attendanceManage() {
    	return "attendance/attendanceManage";
    }
    
    @ResponseBody
    @GetMapping("/empVac.sc")
    public List<VacationDto> empVacationList(HttpSession session, String vacMonth){
    	MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
	     String userId = loginUser.getUserId();
	     
    	return attendanceService.empVacationList(vacMonth, userId);
    }
    
    @ResponseBody
    @GetMapping("/empAtt.sc")
    public List<AttendanceDto> empAttendanceList(HttpSession session){
    	 
		 MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
	     String userId = loginUser.getUserId();
	     
    	return attendanceService.empAttendanceList(userId);
    }

	@GetMapping("/workIn.do")
	public String workIn(HttpSession session, RedirectAttributes redirectAttributes) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		int result = attendanceService.insertWorkIn(loginUser);
		
		redirectAttributes.addFlashAttribute("alertTitle", "출퇴근");
		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg","출근하셨습니다.");
		} else {
			redirectAttributes.addFlashAttribute("alertMsg","출근에 실패했습니다.");
		}
		return "redirect:/";
	}
	
	@GetMapping("/workOut.do")
	public String workOut(HttpSession session, RedirectAttributes redirectAttributes) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		int result = attendanceService.insertWorkOut(loginUser);
		redirectAttributes.addFlashAttribute("alertTitle", "출퇴근");
		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg","퇴근하셨습니다.");
		} else {
			redirectAttributes.addFlashAttribute("alertMsg","퇴근에 실패했습니다.");
		}
		return "redirect:/";
	}
}
