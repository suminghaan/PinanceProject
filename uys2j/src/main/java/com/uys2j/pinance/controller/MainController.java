package com.uys2j.pinance.controller;

import java.util.List;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.uys2j.pinance.dto.AttendanceDto;
import com.uys2j.pinance.dto.BoardDto;
import com.uys2j.pinance.dto.EdocDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.MenuDto;
import com.uys2j.pinance.dto.VacationInformationDto;
import com.uys2j.pinance.service.AttendanceService;
import com.uys2j.pinance.service.BoardService;
import com.uys2j.pinance.service.EdocServiceImpl;
import com.uys2j.pinance.service.MemberService;
import com.uys2j.pinance.service.MenuService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Controller
@Slf4j
public class MainController {
	private final MemberService memberService;
	private final BoardService boardService;
	private final AttendanceService attendanceService;
	private final MenuService menuService;
	private final EdocServiceImpl edocService;
	
	@RequestMapping(value={"/", "/main.page"})	
	public String main(HttpServletRequest request, Model model) {
		List<MemberDto> all = memberService.selectMemberList();
		model.addAttribute("all", all);
		
		MemberDto loginUser = (MemberDto)request.getSession().getAttribute("loginUser");
		
		List<EdocDto> edolist = edocService.mainSelectUploadApprovalList(loginUser);
		List<MenuDto> menuList = menuService.selectMenu();
		log.debug("메뉴목록:{}",menuList);
		request.getSession().setAttribute("edolist", edolist);
		request.getSession().setAttribute("menuList", menuList);
		
		List<MemberDto> memlist = memberService.selectBrithMember();
		request.getSession().setAttribute("memlist", memlist);
		
		if(loginUser != null) {
			AttendanceDto at = attendanceService.selectWork(loginUser);
			request.getSession().setAttribute("attend", at);
		}
		
		if (loginUser != null) {
			VacationInformationDto vacation = memberService.selectVacation(loginUser);
			request.getSession().setAttribute("vacation", vacation);
		}
		
		if (loginUser != null) {
			AttendanceDto att = memberService.selectAttendance(loginUser);
			request.getSession().setAttribute("att", att);
		}
		
		 if (loginUser != null) {
            String userName = loginUser.getUserName();
            List<BoardDto> boardList = boardService.selectBoardType(userName);
            request.getSession().setAttribute("bNo", boardList);
		}
		
		return "main";
		
	}
	
	@ResponseBody
	@GetMapping("/main/notice.do")
	public List<BoardDto> mainSelectNotice() {
		return boardService.mainSelectNotice();
	}
	
	@GetMapping("/chat/chat.page")
	public String chat() {
		return "chat/chat";
	}
	
	@GetMapping("/menu/update.do")
	public String updateMenu(String[] menuNo) {
		int result = 0;
		if(Objects.isNull(menuNo)) {
			result = menuService.updateMenuAll();
		} else {
			result = menuService.updateMenu(menuNo);
		}
		if(result > 0) {
			
		} else {
			
		}
		return "redirect:/";			
	}
	

}
