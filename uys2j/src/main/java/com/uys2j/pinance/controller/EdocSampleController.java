package com.uys2j.pinance.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.DefaultDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.SampleDto;
import com.uys2j.pinance.service.EdocSampleServiceImpl;
import com.uys2j.pinance.util.FileUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/sample")
@Controller
@RequiredArgsConstructor
public class EdocSampleController {
	
	private final EdocSampleServiceImpl sampleService;
	private final FileUtil fileUtil;
	
	@GetMapping("/sampleList.page")
	public String sampleList(Model model) {
		List<SampleDto> list = sampleService.selectSampleList();
		List<SampleDto> codeList = sampleService.selectCodeList();
		model.addAttribute("list",list);
		model.addAttribute("codeList",codeList);
		return "edoc/sampleList";
	}
	
	@GetMapping("/sampleInsert.page")
	public String sampleInsert(Model m) {
		List<SampleDto> codeList = sampleService.selectCodeList();
		m.addAttribute("codeList",codeList);
		return "edoc/sampleInsert";
	}
	
	@GetMapping("/sampleDetail.page")
	public String sampleDetail(int no, Model m) {
		SampleDto sample = sampleService.selectSample(no);
		m.addAttribute("sample",sample);
		log.debug("sample: " + sample);
		return "edoc/sampleDetail";
	}
	
	@GetMapping("/modify.page")
	public String updateSampleForm(int sampleNo,Model m) {
		SampleDto sample = sampleService.selectSample(sampleNo);
		List<SampleDto> codeList = sampleService.selectCodeList();
		m.addAttribute("sample",sample);
		m.addAttribute("codeList",codeList);
		return "edoc/sampleModify";
	}
	
	@PostMapping("/update.sample")
	public String updateSample(SampleDto sample
							  ,String addSampleCode
							  ,String[] delFileNo
							  ,List<MultipartFile> uploadFiles
							  ,RedirectAttributes redirectAttribute) {
		
		if(!addSampleCode.equals("")) {
			sample.setSampleCode(addSampleCode);
		}
		//삭제할 파일 정보조회
		List<AttachDto> delFileList = sampleService.selectDelFile(delFileNo);
		
		List<AttachDto> addFileList = new ArrayList<>();
		for(MultipartFile uploadFile : uploadFiles) {
			if(uploadFile != null && !uploadFile.isEmpty()) {
				Map<String, String> map = fileUtil.fileUpload(uploadFile, "sample");
				addFileList.add( AttachDto.builder()
										  .originalName(map.get("originalName"))
										  .filePath(map.get("filePath"))
										  .filesystemName(map.get("filesystemName"))
										  .refType("9")
										  .refNo(sample.getSampleNo())
										  .build() );
			}
		}
		sample.setAttachList(addFileList);
		
		int result = sampleService.updateSample(sample,delFileNo);
		if(result>0) {
			for(AttachDto at : delFileList) {
				new File( at.getFilePath() + "/" + at.getFilesystemName() ).delete();
			}
		}
		
		return "redirect:/sample/sampleDetail.page?no=" + sample.getSampleNo();
	}
	
	@PostMapping("/insert.sample")
	public String insertSample(SampleDto sample
								,String addSampleCode
								,List<MultipartFile> uploadFiles) {
		//추가로 분류 입력했을경우
		if(!addSampleCode.equals("")) {
			sample.setSampleCode(addSampleCode);
		}
		
		List<AttachDto> addFileList = new ArrayList<>();
		for(MultipartFile uploadFile : uploadFiles) {
			if(uploadFile != null && !uploadFile.isEmpty()) {
				Map<String, String> map = fileUtil.fileUpload(uploadFile, "sample");
				addFileList.add( AttachDto.builder()
										  .originalName(map.get("originalName"))
										  .filePath(map.get("filePath"))
										  .filesystemName(map.get("filesystemName"))
										  .refType("9")
										  .build() );
			}
		}
		sample.setAttachList(addFileList);
		
		int result = sampleService.insertSample(sample);
		//성공여부따라 alert 
		
		
		return "redirect:/sample/sampleList.page";
	}
	
	@GetMapping("/delete.sample")
	public String deleteSample(int sampleNo) {
		List<AttachDto> delFileList = sampleService.selectAllDelFile(sampleNo);
		int result = sampleService.deleteSample(sampleNo);
		if(result>0) {
			for(AttachDto at : delFileList) {
				new File( at.getFilePath() + "/" + at.getFilesystemName() ).delete();
			}
		}
		return "redirect:/sample/sampleList.page";
	}
	
	@ResponseBody
	@PostMapping("/update.list")
	public int ajaxUpdateList(SampleDto sample) {
		log.debug("ajax요청 sample " + sample);
		return sampleService.ajaxUpdateList(sample);
	}
	
}
