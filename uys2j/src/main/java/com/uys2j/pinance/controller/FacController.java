package com.uys2j.pinance.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.DefaultDto;
import com.uys2j.pinance.dto.EqDto;
import com.uys2j.pinance.dto.FacDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.ScheduleDto;
import com.uys2j.pinance.service.FacService;
import com.uys2j.pinance.util.FileUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@RequestMapping("/fac")
@Controller
@Slf4j
public class FacController {

	private final FacService facService;
	private final FileUtil fileUtil;

	@RequestMapping("/fac.page")
	public String fac() {
		return "fac/faclist";
	}
	
	@RequestMapping("/fac_stock.page")
	public String fac_stock() {
		return "fac/fac_stock";
	}
	
	@PostMapping("/insert.fac")
	public String facInsert(FacDto f
							, List<MultipartFile> uploadFiles
				  			, HttpSession session
				  			, RedirectAttributes redirectAttributes) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		f.setRegId(loginUser.getUserId());
		DefaultDto dd = new DefaultDto();
		dd.setRegId(loginUser.getUserId());
		List<AttachDto> attachList = new ArrayList<>();
		for(MultipartFile uploadFile : uploadFiles) {
			if(uploadFile != null && !uploadFile.isEmpty()) {
				Map<String, String> map = fileUtil.fileUpload(uploadFile, "fac");
				
				attachList.add( AttachDto.builder()
						.filePath(map.get("filePath"))
						.filesystemName(map.get("filesystemName"))
						.originalName(map.get("originalName"))
						.refType("5")
						.refNo(f.getFacNo())
						.defaultDto(dd)
						.build() );
			}
		}
		f.setAttachList(attachList);
		
		int result = facService.facInsert(f);
		
		redirectAttributes.addFlashAttribute("alertTitle", "시설 등록");
		if(attachList.isEmpty() && result == 1 || !attachList.isEmpty() && result == attachList.size()) {
			redirectAttributes.addFlashAttribute("alertMsg", "시설 등록에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "시설 등록에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("historyBackYN", "Y");
		}
		
		return "redirect:/fac/fac.page";
		
	}
	
	@GetMapping("/facUpdate.page")
    public String facUpdatepage(@RequestParam("facNo") int facNo, Model model) {
		FacDto facDto = facService.facUpdatepage(facNo);
		log.debug("facDto:{}", facDto);
        model.addAttribute("facdto", facDto);
        return "fac/fac_update";
    }
	
	@PostMapping("/delete.fac")
    public String facDelete(FacDto f, HttpSession session) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		f.setModId(loginUser.getUserId());
    	int result = facService.facDelete(f);
        if(result > 0) {
            return "redirect:/fac/fac.page";
        } else {
            return "redirect:/fac/fac.page";
        }
    }
	
	@GetMapping("/select.fac")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> facSelect() {
	    List<FacDto> list = facService.facSelect();
	    List<ScheduleDto> sclist = facService.scSelect();
	    
	    Map<String, Object> map = new HashMap<>();
	    map.put("faclist", list);
	    map.put("sclist", sclist);
	    log.debug("map:{}", map);
	    
	    return ResponseEntity.ok(map);
	}
	
	@PostMapping("/insert.fl")
    public String faclistInsert(ScheduleDto s, HttpSession session) {
    	MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
    	s.setRegId(loginUser.getUserId());
    	log.debug("S:{}", s);
        int result;
        if (s.getScNo() == 0) {
        	result = facService.faclistInsert(s);
        } else {
        	result = facService.faclistUpdate(s);
        }
        if(result > 0) {
        	return "redirect:/fac/fac.page";
        } else {
        	return "redirect:/fac/fac.page";
        }
    }
	
	@GetMapping("/selectReservationsByDate.fac")
	@ResponseBody
	public ResponseEntity<List<ScheduleDto>> selectReservationsByDate(@RequestParam("date") String date, HttpSession session) {
	    MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
	    String searchDate = date.substring(0, 8);
	    log.debug("date:{}", date);
	    Map<String, Object> map = new HashMap<>();
	    map.put("date", date);
	    map.put("userId", loginUser.getUserId());
	    map.put("searchDate", searchDate);
	    List<ScheduleDto> reservations = facService.getReservationsByDate(map);
	    for(ScheduleDto re : reservations) {
	    	re.setScStart(re.getScStart().substring(16, 21));
	    	re.setScEnd(re.getScEnd().substring(16, 21));
	    }
	    return ResponseEntity.ok(reservations);
	}
	
	@ResponseBody
	@PostMapping("/delete.fl")
    public String faclistDelete(ScheduleDto s) {
		log.debug("s:{}", s);
    	int result = facService.faclistDelete(s);
        if(result > 0) {
        	return "redirect:/fac/fac.page";
        } else {
            return "redirect:/fac/fac.page";
        }
    }


}
