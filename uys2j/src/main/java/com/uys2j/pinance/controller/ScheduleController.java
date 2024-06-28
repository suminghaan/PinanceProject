package com.uys2j.pinance.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.ScheduleDto;
import com.uys2j.pinance.service.ScheduleService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@RequestMapping("/schedule")
@Controller
@Slf4j
public class ScheduleController {
    
    private final ScheduleService scheduleService;
    
    @RequestMapping("/schedule.page")    
    public String schedule() {
        return "schedule/schedule";
    }
    
    @PostMapping("/insert.sc")
    public String scheduleInsert(ScheduleDto s, HttpSession session) {
    	MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
    	s.setRegId(loginUser.getUserId());
    	log.debug("S:{}", s);
        int result = scheduleService.scheduleInsert(s);
        if(result > 0) {
            return "redirect:/schedule/schedule.page";
        } else {
            return "redirect:/schedule/schedule.page";
        }
    }
    
    @GetMapping("/select.sc")
    @ResponseBody
    public ResponseEntity<List<ScheduleDto>> scheduleSelect(HttpSession session) {
    	MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
        List<ScheduleDto> list = scheduleService.scheduleSelect(loginUser);
        for (ScheduleDto s : list) {
	        String[] starts = s.getScStart().split("T");
	        s.setScStartDate(starts[0]);
	        s.setScStartTime(starts[1]);
	        String[] ends = s.getScEnd().split("T");
	        s.setScEndDate(ends[0]);
	        s.setScEndTime(ends[1]);
        }
        return ResponseEntity.ok(list);
    }
    
    @PostMapping("/update.sc")
    public String scheduleUpdate(ScheduleDto s, HttpSession session) {
    	MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
    	s.setRegId(loginUser.getUserId());
    	int result = scheduleService.scheduleUpdate(s);
        if(result > 0) {
            return "redirect:/schedule/schedule.page";
        } else {
            return "redirect:/schedule/schedule.page";
        }
    }
    
    @PostMapping("/delete.sc")
    public String scheduleDelete(ScheduleDto s) {
    	int result = scheduleService.scheduleDelete(s);
        if(result > 0) {
            return "redirect:/schedule/schedule.page";
        } else {
            return "redirect:/schedule/schedule.page";
        }
    }
    
    @GetMapping("/selectFiltered.sc")
    @ResponseBody
    public ResponseEntity<List<ScheduleDto>> scheduleSelectFiltered(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) Boolean showCompany,
            @RequestParam(required = false) Boolean showPersonal,
            HttpSession session) {

        if (category == null || "-".equals(category)) {
            category = null;
        }
        if (showCompany == null) {
            showCompany = false;
        }
        if (showPersonal == null) {
            showPersonal = false;
        }

        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        Map<String, Object> params = new HashMap<>();
        params.put("category", category);
        params.put("showCompany", showCompany);
        params.put("showPersonal", showPersonal);
        params.put("userId", loginUser.getUserId());
        List<ScheduleDto> list = scheduleService.scheduleSelectFiltered(params);
        for (ScheduleDto s : list) {
            String[] starts = s.getScStart().split("T");
            s.setScStartDate(starts[0]);
            s.setScStartTime(starts[1]);
            String[] ends = s.getScEnd().split("T");
            s.setScEndDate(ends[0]);
            s.setScEndTime(ends[1]);
        }
        return ResponseEntity.ok(list);
    }





}
