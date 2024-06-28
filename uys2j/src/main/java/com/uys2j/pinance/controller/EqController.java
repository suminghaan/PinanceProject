package com.uys2j.pinance.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.service.EqService;
import com.uys2j.pinance.util.FileUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@RequestMapping("/eq")
@Controller
@Slf4j
public class EqController {

	private final EqService eqService;
	private final FileUtil fileUtil;

	@RequestMapping("/eq.page")
	public String eq() {
		return "eq/eqlist";
	}
	
	@RequestMapping("/eq_stock.page")
	public String eq_stock() {
		return "eq/eq_stock";
	}

	@GetMapping("/select.eq")
	@ResponseBody
	public ResponseEntity<List<EqDto>> eqSelect() {
		List<EqDto> list = eqService.eqSelect();
		log.debug("list : {}", list);
		return ResponseEntity.ok(list);
	}
	
	@PostMapping("/insert.eq")
	public String eqInsert(EqDto e
							, List<MultipartFile> uploadFiles
				  			 , HttpSession session
				  			 , RedirectAttributes redirectAttributes) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		e.setRegId(loginUser.getUserId());
		DefaultDto dd = new DefaultDto();
		dd.setRegId(loginUser.getUserId());
		List<AttachDto> attachList = new ArrayList<>();
		for(MultipartFile uploadFile : uploadFiles) {
			if(uploadFile != null && !uploadFile.isEmpty()) {
				Map<String, String> map = fileUtil.fileUpload(uploadFile, "eq");
				
				attachList.add( AttachDto.builder()
						.filePath(map.get("filePath"))
						.filesystemName(map.get("filesystemName"))
						.originalName(map.get("originalName"))
						.refType("5")
						.refNo(e.getEqNo())
						.defaultDto(dd)
						.build() );
			}
		}
		e.setAttachList(attachList);
		
		int result = eqService.eqInsert(e);
		
		redirectAttributes.addFlashAttribute("alertTitle", "비품 등록");
		if(attachList.isEmpty() && result == 1 || !attachList.isEmpty() && result == attachList.size()) {
			redirectAttributes.addFlashAttribute("alertMsg", "비품 등록에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "비품 등록에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("historyBackYN", "Y");
		}
		
		return "redirect:/eq/eq.page";
		
	}
	
	@GetMapping("/eqUpdate.page")
    public String eqUpdatepage(@RequestParam("eqNo") int eqNo, Model model) {
		EqDto eqDto = eqService.eqUpdatepage(eqNo);
		
		log.debug("eqDto:{}", eqDto);
        model.addAttribute("eqdto", eqDto);
        return "eq/eq_update";
    }
	
	@PostMapping("/update.eq")
	public String eqUpdate(@RequestParam("eqNo") int no
						   , EqDto e
						   , String[] delFileNo
						   , List<MultipartFile> uploadFiles
						   , HttpSession session
					       , RedirectAttributes redirectAttributes) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		e.setModId(loginUser.getUserId());
		List<AttachDto> delFile = eqService.selectDelFile(delFileNo);
		log.debug("delFileList {}", delFile);
		DefaultDto dd = new DefaultDto();
		dd.setRegId(loginUser.getUserId());
		List<AttachDto> addFile = new ArrayList<>();
		for(MultipartFile uploadFile : uploadFiles) {
			if(uploadFile != null && !uploadFile.isEmpty()) {
				Map<String, String> map = fileUtil.fileUpload(uploadFile, "eq");
				addFile.add( AttachDto.builder()
										  .originalName(map.get("originalName"))
										  .filePath(map.get("filePath"))
										  .filesystemName(map.get("filesystemName"))
										  .refType("1")
										  .refNo(e.getEqNo())
										  .defaultDto(dd)
										  .build()
										  );
			}
		}
		
		e.setAttachList(addFile);
		
		int result = eqService.eqUpdate(e, delFileNo);
		
		log.debug("delFileList {}", delFile);
		redirectAttributes.addFlashAttribute("alertTitle", "비품 수정 서비스");
		if(result > 0) {
			for(AttachDto at : delFile) {
				new File( at.getFilePath() + "/" + at.getFilesystemName() ).delete();
			}
			
			redirectAttributes.addFlashAttribute("alertMsg", "비품이 성공적으로 수정되었습니다.");		
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "비품 수정에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("historyBackYN", "Y");
		}
		
		return "redirect:/eq/eq.page"; 
	}
	
	@GetMapping("/delete.eq")
    public String eqDelete(EqDto e, HttpSession session) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		e.setModId(loginUser.getUserId());
    	int result = eqService.eqDelete(e);
        if(result > 0) {
            return "redirect:/eq/eq.page";
        } else {
            return "redirect:/eq/eq.page";
        }
    }

}
