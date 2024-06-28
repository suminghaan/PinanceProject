package com.uys2j.pinance.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.uys2j.pinance.dto.DefaultDto;
import com.uys2j.pinance.dto.DepartmentDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.service.DepartmentServiceImpl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/department")
@RequiredArgsConstructor
@Slf4j
@Controller
public class DepartmentController {
	
	private final DepartmentServiceImpl departmentService;
	
	@GetMapping("/departmentList.page")
	public String departmentList(Model model, String keyword, String checkCode){
		List<MemberDto> empMemlist = departmentService.emptyMemberList();
		model.addAttribute("count", departmentService.selectDeptNullCount()) // 가발령 멤버 카운트
			 .addAttribute("list", departmentService.serachDepartment(keyword))
			 .addAttribute("empMemlist", empMemlist); // 가발령 멤버 리스트
		return "department/departmentList";
	}
	
	@GetMapping("/deptList.do")
	@ResponseBody
	public List<DepartmentDto> ajaxDeptList(String keyword){
		List<DepartmentDto> list = departmentService.serachDepartment(keyword); // jstree 조회 리스트
		return list;
	}
	
	@PostMapping("/memberList.do")
	@ResponseBody
	public List<MemberDto> ajaxMemberList(String dept) {
	    List<MemberDto> memlist = null;
	    if ((dept.charAt(2) == '0' || Character.isDigit(dept.charAt(0)))) {
	    	memlist = null;
	    } else {
	        memlist = departmentService.selectDeptMember(dept);
	    }
	    return memlist;
	}
	
	@PostMapping("/insert.do")
	public String insertDepartment(DepartmentDto Department, HttpSession session) {
		MemberDto m = (MemberDto)session.getAttribute("loginUser");
		DefaultDto d = new DefaultDto();
		d.setRegId(m.getUserId());
		Department.setDefaultDto(d);
		int result = departmentService.insertDepartment(Department);
		return "redirect:/department/departmentList.page";
	}
	
	@PostMapping("/update.do")
	@ResponseBody
	public int updateDepartment(String nodeId, String parentId) {
		
		String newNodeId = null;
		String newParentId = "KB00";
		String check = "";
		if(nodeId.length() == 5) { // 부서 변경 시
		    check= "T";
			char lastCharOfParentId = parentId.charAt(parentId.length() - 1);
		    if(lastCharOfParentId != '#') {
		    	newNodeId = nodeId.substring(0, 2) + lastCharOfParentId + nodeId.substring(3, nodeId.length());
		    }else {
		    	newNodeId = nodeId;
		    }
		}else { // 회원 변경시
			char lastCharOfParentId = parentId.charAt(parentId.length() - 1);
		    if(lastCharOfParentId != '#') {
				newParentId += parentId.charAt(2);
			}else {
				newParentId = parentId;
			}
			newNodeId = nodeId;
		}
	    
		int count = departmentService.delCodeCheck(newNodeId);
		log.debug("count:{}", count);
		 if(count > 0) {
			 return 0;
		 }else {
			 Map<String, String> map = new HashMap<>();
			 map.put("nodeId", nodeId);
			 map.put("parentId", parentId);
			 map.put("newNodeId", newNodeId);
			 map.put("check", check);
			 
			 map.put("newParentId", newParentId);
			 int result = departmentService.updateDepartment(map);
			 log.debug("result:{}", result);
			 return result;
		 }
	}
	
	@ResponseBody
	@GetMapping("/codeCheck.do")
	public String ajaxCodeCheck(String checkCode) {
		int count = departmentService.selectCodeCount(checkCode);
		return count > 0 ? "NNNNN" : "YYYYY";
	}
	
	@GetMapping("/delete.do")
	public String deleteDepartment(String deptValue) {
		int result = departmentService.deleteDepartment(deptValue);
		return "redirect:/department/departmentList.page";
	}
	
	@ResponseBody
	@GetMapping("/delcodeCheck.do")
	public String ajaxDelCodeCheck(String checkCode) {
		int count = departmentService.delCodeCheck(checkCode);
		return count == 0 ? "NNNNN" : "YYYYY";
	}
	
}
