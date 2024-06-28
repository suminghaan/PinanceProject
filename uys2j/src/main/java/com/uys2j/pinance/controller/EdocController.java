package com.uys2j.pinance.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpSession;

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
import com.uys2j.pinance.dto.EdocApprovalDto;
import com.uys2j.pinance.dto.EdocDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.RefDto;
import com.uys2j.pinance.dto.SampleDto;
import com.uys2j.pinance.dto.SaveApprovalDto;
import com.uys2j.pinance.dto.VacationDto;
import com.uys2j.pinance.dto.VacationTypeDto;
import com.uys2j.pinance.service.EdocServiceImpl;
import com.uys2j.pinance.service.MemberService;
import com.uys2j.pinance.util.FileUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/edoc")
@RequiredArgsConstructor
@Controller
public class EdocController {
	
	private final EdocServiceImpl edocService;
	private final MemberService memberService;
	private final FileUtil fileUtil;
	
	// 결재 상신함 조회 
	@GetMapping("/uploadApprovalList.page")
	public String uploadApprovalList(Model model, HttpSession session) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		List<EdocDto> list = edocService.selectUploadApprovalList(loginUser);
		//log.debug("list:"+list);
		model.addAttribute("list",list);
		return "edoc/uploadApprovalList";		
	}
	
	
	// 결재상신페이지_샘플양식구분 받아오기
	@GetMapping("/edocInsert.page")
	public String edocInsert(Model model, HttpSession session) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		List<SaveApprovalDto> saAp = edocService.seleteMyApproval(loginUser);
		List<SampleDto> sampleCode = edocService.edocInsertPage();
		//log.debug("samplecode"+sampleCode);
		model.addAttribute("sampleCode",sampleCode);
		model.addAttribute("saAp", saAp);
		return "edoc/edocInsert";
	}
	
	// 결재상신페이지_샘플양식구분에 따른 종류
	@ResponseBody
	@PostMapping("/sampleList.do")
	public List<SampleDto> ajaxSampleList(String sampleCategory, Model model) {
		return edocService.ajaxSampleList(sampleCategory);
		
	}
	
	// 결재상신페이지_샘플양식 내용 불러오기
	@ResponseBody
	@PostMapping("/sampleDetail.do")
	public SampleDto ajaxSampleDetail(String sample){
		return edocService.ajaxSampleDetail(sample);
	}
	
	// 결재상신페이지_자주쓰는 결재선
	@ResponseBody
	@PostMapping("/ajaxSelectMyApproval.do")
	public Map<String,Object> ajaxSelectMyApproval(int saNo){
		log.debug("saNo:{}", saNo);
		SaveApprovalDto save = edocService.ajaxSelectMyApproval(saNo);
		String[] user = save.getSaUserId().split(",");
		List<MemberDto> edocUser = new ArrayList<>();
		
		for(int i = 0; i < user.length; i++) {
			MemberDto m = new MemberDto();
			m.setUserId(user[i]);
			edocUser.add(memberService.selectMember(m)); 
		}
		Map<String,Object> saveData = new HashMap<>();
		saveData.put("edocUser", edocUser);
		
		saveData.put("save", save);
		return saveData;
	}
	
	
	
	// 결재상신
	@PostMapping("/insertEdoc.do")
	public String insertEdoc(EdocDto edoc
							, String vacType , String vacDay
							, int[] aprvlRank, String[] aprvluserName
							, String[] aprvluserCr, String[] aprvluserId
							, String[] refUserId, String[] refUserName
							, Model model, HttpSession session
							, List<MultipartFile> uploadFile) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		//휴가신청서일 경우 진행
		int vacResult =1;
		int vacTypeNo = 0;
				
		
		DefaultDto dd = new DefaultDto();
		dd.setRegId(loginUser.getUserId());
		//log.debug("loginuser:{}",loginUser);		
		edoc.setDefaultDto(dd);		
		log.debug("edoc:{}", edoc);
		//log.debug("dd:{}", dd);
		//log.debug("file:{}", uploadFile);
		
		// 결재자 ealist로 담아두기 
		List<EdocApprovalDto> ealist = new ArrayList<>();
		if(aprvlRank != null) {	
			for(int i = 0; i < aprvlRank.length; i++) {
				EdocApprovalDto ea = new EdocApprovalDto();
				ea.setAprvlRank(aprvlRank[i]);
				ea.setAprvluserName(aprvluserName[i]);
				ea.setAprvluserCr(aprvluserCr[i]);
				ea.setAprvluserId(aprvluserId[i]);
				ea.setDefaultDto(dd);
				ealist.add(ea);
			};
		}
		
		log.debug("ealist:{}", ealist);
		
		// 참조자 reflist로 담아두기
		List<RefDto> reflist = new ArrayList<>();
		
		if(refUserId != null) {
			for(int i = 0; i < refUserId.length; i++) {
				RefDto ref = new RefDto();
				ref.setRefUserId(refUserId[i]);
				ref.setRefUserName(refUserName[i]);
				ref.setDefaultDto(dd);
				reflist.add(ref);
			}
		};
		
		
		log.debug("reflist:{}", reflist);
		List<AttachDto> addFileList = new ArrayList<>();
		
		
		if(uploadFile != null) {
			for(MultipartFile uploadFiles : uploadFile) {
				if(uploadFiles != null && !uploadFiles.isEmpty()) {
					Map<String, String> map = fileUtil.fileUpload(uploadFiles, "edoc");
					addFileList.add( AttachDto.builder()
											  .originalName(map.get("originalName"))
											  .filePath(map.get("filePath"))
											  .filesystemName(map.get("filesystemName"))
											  .refType("3")
											  .defaultDto(dd)
											  .build() );
				}
			}
		}
		edoc.setAttachList(addFileList);
		
		int result1 = edocService.insertEdoc(edoc);
		
		
		int result2 = 1;
		if("N".equals(edoc.getTempSave())) {
			result2 = edocService.insertEdocApproval(ealist, reflist);
		}	
		
		
		
		//문서 insert후 휴가신청서면 휴가테이블에도 insert
		if(edoc.getDocCode().equals("1") && !edoc.getTempSave().equals("Y")) {
			List<VacationTypeDto> type = edocService.selectVacType();
			for(VacationTypeDto v : type) {
				if(vacType.contains(v.getVactypeName())) {
					vacTypeNo = v.getVactypeNo();
				}
			}
			String start = vacDay.replaceAll("\\s+", "");
			String[] days = start.split("-");
			String startDay = "";
			String endDay = "";
			if(days.length >0) {
				startDay = days[0];
				endDay = days[1].split("\\(")[0];
			}
			VacationDto vac = new VacationDto();
			vac.setUserNo(loginUser.getUserNo());
			vac.setVactypeNo(vacTypeNo);
			vac.setVacStart(startDay);
			vac.setVacEnd(endDay);
			vac.setVacStatus("Y");
			DefaultDto d = new DefaultDto();
			vac.setDefaultDto(d);
			vac.getDefaultDto().setModId(loginUser.getUserId());
			
			log.debug("휴가일=" + vacDay);
			log.debug("공백제거후=" + start);
			log.debug("시작일=" + startDay);
			log.debug("끝일=" + endDay);
			log.debug("휴가타입=" + vacType);
			
			vacResult = edocService.insertVacation(vac);
		}
		
		if(result1 > 0 && result2 > 0) {
			return "redirect:/edoc/edocDetail.do?no="+edoc.getDocNo();
		}else {			
			return "redirect:/edoc/edocInsert";
		}	
	}
	
	// 상신한 결재 상세 조회
	@GetMapping("/edocDetail.do")
	public String edocDetail(@RequestParam("no") int no, Model model) {
		model.addAttribute("edoc", edocService.selectEdoc(no))
			 .addAttribute("edocEa", edocService.selectEdocEa(no))
			 .addAttribute("edocRef", edocService.selectEdocRef(no));
			 //.addAttribute("signAtList", edocService.selectSignAtList());
		log.debug("detaillog:{},{},{}", edocService.selectEdoc(no), edocService.selectEdocEa(no), edocService.selectEdocRef(no) );
		return "edoc/edocDetail";
	}
	
	// 상신한 결재 수정 페이지
	@GetMapping("/edocModify.page")
	public String edocModify(@RequestParam("no") int no, Model model, HttpSession session) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		//log.debug("no:{}", no);
		//log.debug("edoc:{}", edocService.selectEdoc(no));
		
		
		
		model.addAttribute("edoc", edocService.selectEdoc(no))		
			 .addAttribute("saAp", edocService.seleteMyApproval(loginUser))
			 .addAttribute("sampleCode",edocService.edocInsertPage());
		/*
		model.addAttribute("edocEa", edocService.selectEdocEa(no))
			 .addAttribute("edocRef", edocService.selectEdocRef(no));
		*/
		List<EdocApprovalDto> ea = edocService.selectEdocEa(no);
		List<RefDto> ref = edocService.selectEdocRef(no);
		if(ea != null || ref != null) {
			// 페이지 접속 시 결재선 삭제
			edocService.deleteEdocApproval(no);
		}
		
		return "edoc/edocModify";
	}
	
	// 상신수정
	@PostMapping("/modifyEdoc.do")
	public String modifyEdoc(EdocDto edoc
						   , String vacType , String vacDay
						   , int[] aprvlRank, String[] aprvluserName
						   , String[] aprvluserCr, String[] aprvluserId
						   , String[]refUserId, String[] refUserName
						   , Model model
						   , String[] delFileNo
						   , List<MultipartFile> uploadFile
						   , HttpSession session
						   , RedirectAttributes redirectAttributes) {
		//log.debug("edoc: {}", edoc);
		//model.addAttribute("result", editorTxt);
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		DefaultDto dd = new DefaultDto();
		dd.setRegId(loginUser.getUserId());		
		edoc.setDefaultDto(dd);	
		
		int vacResult =1;
		int vacTypeNo = 0;
		if(edoc.getDocCode().equals("1")) {
			List<VacationTypeDto> type = edocService.selectVacType();
			for(VacationTypeDto v : type) {
				if(vacType.contains(v.getVactypeName())) {
					vacTypeNo = v.getVactypeNo();
				}
			}
			String start = vacDay.replaceAll("\\s+", "");
			String[] days = start.split("-");
			String startDay = "";
			String endDay = "";
			if(days.length >0) {
				startDay = days[0];
				endDay = days[1].split("\\(")[0];
			}
			VacationDto vac = new VacationDto();
			vac.setVacNo(edoc.getDocNo());
			vac.setUserNo(loginUser.getUserNo());
			vac.setVactypeNo(vacTypeNo);
			vac.setVacStart(startDay);
			vac.setVacEnd(endDay);
			vac.setVacStatus("Y");
			DefaultDto d = new DefaultDto();
			vac.setDefaultDto(d);
			vac.getDefaultDto().setModId(loginUser.getUserId());
			
			vacResult = edocService.updateVacation(vac);
		}
		
		// 삭제할 파일 정보 조회
		List<AttachDto> delFileList = edocService.selectDelFile(delFileNo);				
		
		List<AttachDto> addFileList = new ArrayList<>();
		for(MultipartFile uploadFiles : uploadFile) {
			if(uploadFiles != null && !uploadFiles.isEmpty()) {
				Map<String, String> map = fileUtil.fileUpload(uploadFiles, "edoc");
				addFileList.add( AttachDto.builder()
										  .originalName(map.get("originalName"))
										  .filePath(map.get("filePath"))
										  .filesystemName(map.get("filesystemName"))
										  .refType("3")
										  .refNo(edoc.getDocNo())
										  .defaultDto(dd)
										  .build() );
			}
		}
		edoc.setAttachList(addFileList);
		
		// 결재자 ealist로 담아두기 
		List<EdocApprovalDto> ealist = new ArrayList<>();
			
		for(int i = 0; i < aprvlRank.length; i++) {
			EdocApprovalDto ea = new EdocApprovalDto();
			ea.setAprvlRank(aprvlRank[i]);
			ea.setAprvluserName(aprvluserName[i]);
			ea.setAprvluserCr(aprvluserCr[i]);
			ea.setAprvluserId(aprvluserId[i]);
			ea.setDocumentNo(edoc.getDocNo());
			ea.setDefaultDto(dd);
			ealist.add(ea);
		};		
		log.debug("ealist:{}", ealist);
		
		// 참조자 reflist로 담아두기
		List<RefDto> reflist = new ArrayList<>();
		
		if(refUserId != null) {
			for(int i = 0; i < refUserId.length; i++) {
				RefDto ref = new RefDto();
				ref.setRefUserId(refUserId[i]);
				ref.setRefUserName(refUserName[i]);
				ref.setDefaultDto(dd);
				ref.setRefEdocNo(edoc.getDocNo());
				reflist.add(ref);
			}
		};
		log.debug("reflist:{}", reflist);
		
		int result1 = edocService.updateEdoc(edoc, delFileNo);
		int result2 = edocService.modifyInsertEdocApproval(ealist,reflist);
		if(result1 * result2 > 0) {
			for(AttachDto at : delFileList) {
				new File( at.getFilePath() + "/" + at.getFilesystemName() ).delete();
			}			
			return "redirect:/edoc/edocDetail.do?no=" + edoc.getDocNo();

		} else {
			redirectAttributes.addFlashAttribute("historyBackYN", "Y");
			return "main";
		}
		
	}
	
	// 결재상신 삭제
	@PostMapping("/edocDelete.do")
	public String deleteEdoc(int docNo, String[] delFileNo) {
		//log.debug("delFileNo: {}", delFileNo);
		
		// 삭제할 파일 정보 조회
		List<AttachDto> delFileList = edocService.selectDelFile(delFileNo);	
		log.debug("fileList:{}",delFileList);
		
		int result = edocService.deleteEdoc(docNo);
		if(result > 0) {
			for(AttachDto at : delFileList) {
				new File( at.getFilePath() + "/" + at.getFilesystemName() ).delete();
			}
		}
		return "redirect:/edoc/uploadApprovalList.page";
	}
	
	// 임시저장함 조회
	@GetMapping("/tempSaveApprovalList.page")
	public String tempSaveApprovalList(Model model, HttpSession session) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		List<EdocDto> list = edocService.selectTempSaveApprovalList(loginUser);
		//log.debug("list:"+list);
		model.addAttribute("list",list);
		return "edoc/tempSaveApprovalList";		
	}
	
	/* 임시저장함에서 등록
	@PostMapping("/insertTempSaveEdoc.do")
	public String insertTempSaveEdoc(EdocDto edoc
							, String vacType , String vacDay
							, int[] aprvlRank, String[] aprvluserName
						    , String[] aprvluserCr, String[] aprvluserId
						    , String[]refUserId, String[] refUserName
						    , Model model
							, String[] delFileNo
							, HttpSession session
							, List<MultipartFile> uploadFile
							, RedirectAttributes redirectAttributes) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		DefaultDto dd = new DefaultDto();
		dd.setRegId(loginUser.getUserId());	
		edoc.setDefaultDto(dd);		
		
		//휴가신청서 정보 휴가테이블에 insert
		int vacResult =1;
		int vacTypeNo = 0;
		if(edoc.getDocCode().equals("1")) {
			List<VacationTypeDto> type = edocService.selectVacType();
			for(VacationTypeDto v : type) {
				if(vacType.contains(v.getVactypeName())) {
					vacTypeNo = v.getVactypeNo();
				}
			}
			String start = vacDay.replaceAll("\\s+", "");
			String[] days = start.split("-");
			String startDay = "";
			String endDay = "";
			if(days.length >0) {
				startDay = days[0];
				endDay = days[1].split("\\(")[0];
			}
			VacationDto vac = new VacationDto();
			vac.setVacNo(edoc.getDocNo());
			vac.setUserNo(loginUser.getUserNo());
			vac.setVactypeNo(vacTypeNo);
			vac.setVacStart(startDay);
			vac.setVacEnd(endDay);
			vac.setVacStatus("Y");
			DefaultDto d = new DefaultDto();
			vac.setDefaultDto(d);
			vac.getDefaultDto().setModId(loginUser.getUserId());
			
			vacResult = edocService.insertVacation(vac);
		}//휴가신청서 정보 휴가테이블에 insert end 
		
		
		List<AttachDto> addFileList = new ArrayList<>();
		
		for(MultipartFile uploadFiles : uploadFile) {
			if(uploadFiles != null && !uploadFiles.isEmpty()) {
				Map<String, String> map = fileUtil.fileUpload(uploadFiles, "edoc");
				addFileList.add( AttachDto.builder()
										  .originalName(map.get("originalName"))
										  .filePath(map.get("filePath"))
										  .filesystemName(map.get("filesystemName"))
										  .refType("3")
										  .defaultDto(dd)
										  .build() );
			}
		}
		edoc.setAttachList(addFileList);

		
		int result = edocService.updateTempSaveEdoc(edoc);
		//log.debug("r"+result);
		if(result > 0) {
			return "redirect:/edoc/edocDetail.do?no="+edoc.getDocNo();
		}else {			
			return "redirect:/edoc/tempSaveApprovalList";
		}	
	}
	*/
	
	
	// 결재 완료함
	@GetMapping("/finishApprovalList.page")
	public String finishApprovalList(Model model, HttpSession session) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		List<EdocDto> list = edocService.finishApprovalList(loginUser);
		model.addAttribute("list",list);
		return "edoc/finishApprovalList";		
	}
	
	// 결재대기함
	@GetMapping("/approvalList.page")
	public String approvalList(Model model, HttpSession session) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		List<EdocDto> list = edocService.approvalList(loginUser);
		log.debug("list:{}", list);
		model.addAttribute("list",list);
		return "edoc/approvalList";
	}
	
	// 결재버튼 클릭 ajax
	@PostMapping("/ajaxUpdateApBtn.do")
	@ResponseBody
	public Map<String, Object> ajaxUpdateApBtn(int docNo, HttpSession session) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		int result = edocService.ajaxUpdateApBtn(docNo, loginUser);
		
		Map<String, Object> resData = new HashMap<>();
		AttachDto a = new AttachDto();
		if(result > 0) {
			a = edocService.ajaxSelectApBtn(docNo, loginUser);
			if(Objects.isNull(a)) {
				a = new AttachDto();
				EdocApprovalDto ea = edocService.selectEa(docNo, loginUser);
				log.debug("ea {}", ea);
				a.setAprank(ea.getAprvlRank());
			}
			resData.put("success", true);
			resData.put("data", a);
		}else {
			resData.put("success", false);
			resData.put("message", "결재버튼 업데이트 실패");
		}
		
		return resData;
	}
	
	// 반려버튼 클릭 ajax
	@PostMapping("/ajaxUpdateRejBtn.do")
	@ResponseBody
	public Map<String, Object> ajaxUpdateRejBtn(int docNo, HttpSession session) {
		log.debug("유저 {}",docNo);
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		int result = edocService.ajaxUpdateRejBtn(docNo, loginUser);
		
		Map<String, Object> resData = new HashMap<>();
		
		if(result > 0) {			
			EdocApprovalDto ea = edocService.selectEa(docNo, loginUser);
			log.debug("ea : {}", ea);
			resData.put("data", ea);
		}else {
			resData.put("message", "결재버튼 업데이트 실패");
		}
		
		return resData;
		
	}
	
	
	// 자주쓰는 결재선
	@GetMapping("/myApproval.page")
	public String myApproval(Model model, HttpSession session) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		List<SaveApprovalDto> list = edocService.selectMyApproval(loginUser);
		model.addAttribute("list",list);
		log.debug("aplist:{}", list);
		return "edoc/myApproval";
	}
	
	
	// 자주쓰는 결재선 등록
	@PostMapping("/insertMyApproval.do")
	public String ajaxInsertMyApproval(SaveApprovalDto sa
									, HttpSession session) {
		log.debug("sa : {} ",sa);
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		DefaultDto dd = new DefaultDto();
		dd.setRegId(loginUser.getUserId());		
		sa.setDefaultDto(dd);	
		
		
		int result = edocService.insertMyApproval(sa);
		
		return "redirect:/edoc/myApproval.page";
	}
	
	// 자주쓰는 결재선 삭제 
	@GetMapping("/myApprovalDelete.do")
	public String deleteMyApproval(int saNo) {
		int result = edocService.deleteMyApproval(saNo);
		return "redirect:/edoc/myApproval.page";
	}
	
	// 자주쓰는 결재선 수정
	@ResponseBody
	@GetMapping("/approvalDetail.do")
	public Map<String, Object> approvalDetail(String saNo){
		SaveApprovalDto approvalLine = edocService.approvalDetail(saNo);
        
        Map<String, Object> response = new HashMap<>();
        response.put("saTitle", approvalLine.getSaTitle());
        response.put("saUserList", approvalLine.getSaUserId());
        response.put("saRank", approvalLine.getSaRank());
        response.put("saNo", approvalLine.getSaNo());
        
        log.debug("res:{}", response);
        return response;
	}
	
	
	
}
