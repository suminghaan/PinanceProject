package com.uys2j.pinance.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
import com.uys2j.pinance.dto.CommonDto;
import com.uys2j.pinance.dto.DefaultDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.service.AttachService;
import com.uys2j.pinance.service.MemberService;
import com.uys2j.pinance.util.FileUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/member")
@RequiredArgsConstructor
@Controller
public class MemberController {
	
	private final MemberService memberService;
	private final AttachService attachService;
	private final BCryptPasswordEncoder bcryptPwdEncoder;
	private final FileUtil fileUtil;
	
	@GetMapping("/mypage.page")
	public void mypage(MemberDto m, String searchId, Model model, HttpSession session, AttachDto attach){
		int signCount = 0;
		log.debug("memberDto : {}", m);
		log.debug("searchId : {}", searchId);
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		if(searchId != null) {
			m.setUserId(searchId);
		}
		
		signCount = attachService.countSignMember(loginUser);			
		if(loginUser.getStatus().equals("A") || loginUser.getStatus().equals("G")) {
			if(!Objects.isNull(m.getUserId())) {
				signCount = attachService.countSignMember(m);
				MemberDto member = memberService.selectMember(m);
				String[] addressList = member.getAddress().split(",");
				member.setAddress(addressList[0]);
				member.setAddressDetail(addressList[1]);
				model.addAttribute("member", member);
			}
		}
		if(signCount > 0) { model.addAttribute("signCount", signCount); }
	}
	
	@GetMapping("/login.page")
	public void login(){
	}
	
	@PostMapping("/login.do")
	public String loginPost(MemberDto m
						, HttpSession session
						, HttpServletResponse response
						, String rememberUserId
						, RedirectAttributes redirectAttributes) {
		
		log.debug("아이디 기억 확인 {}", rememberUserId);
		if(rememberUserId == null) {
			rememberUserId = "";
		}
		MemberDto loginUser = memberService.selectMember(m);
		log.debug("로그인 유저 {}", loginUser);
		if(loginUser == null) {
			redirectAttributes.addFlashAttribute("alertMsg","존재하지 않는 사번입니다.");
		}
		redirectAttributes.addFlashAttribute("alertTitle", "로그인");
		if(loginUser != null && bcryptPwdEncoder.matches(m.getUserPwd(), loginUser.getUserPwd())) {
			String[] addressList = loginUser.getAddress().split(",");
			loginUser.setAddress(addressList[0]);
			loginUser.setAddressDetail(addressList[1]);
			Cookie cookie = new Cookie("rememberUserId", loginUser.getUserId());
			if (rememberUserId.equals("true")) {
				response.addCookie(cookie);
				System.out.println("3단계-쿠키 아이디저장 O");
				// 쿠키 확인
				// System.out.println("Service check" + cookie);
			} else {
				System.out.println("3단계-쿠키 아이디저장 X");
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}

			session.setAttribute("loginUser", loginUser);
			redirectAttributes.addFlashAttribute("alertMsg",loginUser.getUserName() + "님 환영합니다");
			return "redirect:/";
		}else {
			if(loginUser != null) {
				redirectAttributes.addFlashAttribute("alertMsg","비밀번호를 잘못입력하셨습니다.");				
			}
			return "redirect:/member/login.page";
		}
		
		
		
	}
	
	@GetMapping("/findPwd.page")
	public void findPwd(){
	}
	
	@PostMapping("findPwd.do")
	public String findPwdDo(HttpSession session
			    		  , String userPwd
			    		  , String updatePwd
			    		  , RedirectAttributes redirectAttributes) {
		int result = 0;
		//현재 내 계정정보
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		//변경전 비밀번호 확인
		if(loginUser != null && bcryptPwdEncoder.matches(userPwd, loginUser.getUserPwd())) {//같다면
			//현재의 내 정보의 비밀번호만 변경
			loginUser.setUserPwd(bcryptPwdEncoder.encode(updatePwd));
			//db로 저장
			result = memberService.updateModifyPwd(loginUser);
			if(result > 0) {//변경 성공
				redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 비밀번호 변경되었습니다.");
				loginUser = memberService.selectMember(loginUser);
				String[] addressList = loginUser.getAddress().split(",");
				loginUser.setAddress(addressList[0]);
				loginUser.setAddressDetail(addressList[1]);
				//변경된 비밀번호로 다시 계정 정보 세팅
				session.setAttribute("loginUser", loginUser);
			} else {//변경 실패
				redirectAttributes.addFlashAttribute("alertMsg", "비밀번호 변경에 실패했습니다.");
			}
		} else {//틀리다면
			redirectAttributes.addFlashAttribute("alertMsg", "비밀번호가 틀렸습니다. 다시 입력해주세요.");
		}
		
		return "redirect:/member/mypage.page";
	}
	
	@GetMapping("signup.page")
	public void signup(Model model) {
		model.addAttribute("userId", memberService.selectNewId());
	}
	
	@PostMapping("/signup.do")
	public String signupPost(MemberDto member
						   , MultipartFile profileImgFile
						   , RedirectAttributes redirectAttributes) {
		List<String> addressList = new ArrayList<>();
		Map<String, String> map = new HashMap<String, String>();
		AttachDto attach = new AttachDto();
		int result2 = 1;
		
		//회원 정보 주소 하나로 합침
		addressList.add(member.getAddress());
		addressList.add(member.getAddressDetail());
		member.setAddress(String.join(",", addressList));
		
		//프로필 이미지가 존재 한다면
		if(profileImgFile != null && !profileImgFile.isEmpty()) {
			map = fileUtil.fileUpload(profileImgFile, "profile");
			attach = AttachDto.builder()
							  .filePath(map.get("filePath"))
							  .refType("1")
							  .seqType("seq_memno")
							  .originalName(map.get("originalName"))
							  .filesystemName(map.get("filesystemName"))
							  .build();
			result2 = attachService.insertSignMember(attach);
			member.setProfilePath(map.get("filePath") + "/" + map.get("filesystemName"));
		}
		
		
		//비밀번호 암호화
		member.setUserPwd(bcryptPwdEncoder.encode(member.getUserPwd()));
		int result = memberService.insertMember(member);
		redirectAttributes.addFlashAttribute("alertTitle", "사원 추가");
		if(result * result2 > 0) {
			redirectAttributes.addFlashAttribute("alertMsg","사원 추가에 성공했습니다.");
			 //=> HomeController의 mainPage메소드 실행 => main.jsp 포워딩
		} else {
			redirectAttributes.addFlashAttribute("alertMsg","사원 추가에 실패했습니다.");
			redirectAttributes.addFlashAttribute("historyBackYN","Y");
		}
		return "redirect:/";
	}
	
	@PostMapping("/modify.do")
	public String modify(MemberDto m
					   , MultipartFile profileImgFile
					   , Model model
					   , HttpSession session
					   , RedirectAttributes redirectAttributes) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		List<String> addressList = new ArrayList<>();
		Map<String, String> map = new HashMap<String, String>();
		Map<String, MemberDto> updateMember = new HashMap<String, MemberDto>();
		String originalProfileURL = loginUser.getProfilePath();
		
		if(loginUser.getUserId().equals(m.getUserId())) {
			m.setStatus(loginUser.getStatus());
		}		
		
		addressList.add(m.getAddress());
		addressList.add(m.getAddressDetail());
		m.setAddress(String.join(",", addressList));
		
		// 회원 프로필 업데이트
		if(!profileImgFile.isEmpty()) {
			//기존 파일이 있다면
			if(originalProfileURL != null) {
				//기존 파일 삭제
				new File(originalProfileURL).delete();								
			}
			// 새로운 파일 업로드
			map = fileUtil.fileUpload(profileImgFile, "profile");
			// 파일 업로드
			m.setProfilePath(map.get("filePath") + "/" + map.get("filesystemName"));
		}
		
		updateMember.put("member", m);
		updateMember.put("loginUser", loginUser);
		
		int result = memberService.updateMember(updateMember);
		log.debug("result" + result);
		
		log.debug("status : " + loginUser.getStatus());
		redirectAttributes.addFlashAttribute("alertTitle", "회원 정보 변경");
		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "회원 정보 변경에 성공했습니다.");
			if(loginUser.getStatus().equals("A") || loginUser.getStatus().equals("G")) {
				return "redirect:/member/mypage.page?searchId=" + m.getUserId();
			} else {
				return "redirect:/member/mypage.page?searchId=" + m.getUserId();
			}			
		} else {
			redirectAttributes.addFlashAttribute("alertMsg", "회원 정보 변경에 실패했습니다.");
			new File(map.get("filePath") + "/" + map.get("filesystemName")).delete();
		}
		
		return "redirect:/member/mypage.page";
	}
	
	@PostMapping("/insertSign.do")
	public String insertSignMember(@RequestParam("imageData") String imageData, HttpSession session) {
		AttachDto signAtt = new AttachDto();
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		DefaultDto dd = new DefaultDto();
		dd.setRegId(loginUser.getUserId());
		signAtt.setDefaultDto(dd);
		
		if (imageData != null && !imageData.isEmpty()) {
            // Base64 데이터에서 실제 이미지 데이터 부분만 추출
            String base64Image = imageData.split(",")[1];
            byte[] imageBytes = Base64.getDecoder().decode(base64Image);

            try {
                // 임시 파일 생성
                File tempFile = File.createTempFile("upload_", ".png");
                try (FileOutputStream fos = new FileOutputStream(tempFile)) {
                    fos.write(imageBytes);
                }

                // 파일을 MultipartFile로 변환 (예: CommonsMultipartFile 등을 사용)
                MultipartFile uploadFile = fileUtil.createMultipartFile(tempFile, "image/png");

                // 파일 업로드 로직 실행
                Map<String, String> map = fileUtil.fileUpload(uploadFile, "sign");
                signAtt = AttachDto.builder()
                                   .filePath(map.get("filePath"))
                                   .filesystemName(map.get("filesystemName"))
                                   .refType("7")
                                   .originalName(map.get("originalName"))
                                   .defaultDto(dd)
                                   .build();
                tempFile.delete(); // 임시 파일 삭제
            } catch (IOException e) {
                e.printStackTrace();
                return "error"; // 에러 처리
            }
        }
		
		AttachDto result2 = attachService.deleteSignMember(signAtt);
		
		int result = attachService.insertSignMember(signAtt);
		
		if(result2 != null && !result2.getFilePath().isEmpty() && result > 0){
			// 성공시 => 삭제할 첨부파일이 있었다면 => 해당 파일 찾아서 삭제되도록
			new File(result2.getFilePath() + "/" + result2.getFilesystemName()).delete(); 
		}
		
		return "redirect:/member/mypage.page";
	}
	
	
	
	@ResponseBody
	@GetMapping("/otherId.do")
	public MemberDto ajaxOtherId(String userId) {
		MemberDto m = new MemberDto();
		log.debug("userId :{}", userId);
		m.setUserId(userId);
		MemberDto member = memberService.selectMember(m);
		log.debug("member:{}", member);
		if(member == null) {
			return member;
		}
		member.setSignCount(attachService.countSignMember(m));
		String[] addressList = member.getAddress().split(",");
		member.setAddress(addressList[0]);
		member.setAddressDetail(addressList[1]);
		log.debug("member:{}", member);
		return member;
	}
	
	@RequestMapping("/signout.do")
	public String signout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("/delete.do")
	public String delete(String userId, RedirectAttributes redirectAttributes) {
		MemberDto m = new MemberDto();
		m.setUserId(userId);
		int result = memberService.deleteMember(m);
		redirectAttributes.addFlashAttribute("alertTitle", "회원 정보 제거");
		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "회원 정보 삭제에 성공했습니다.");
		} else {
			redirectAttributes.addFlashAttribute("alertMsg", "회원 정보 삭제에 실패했습니다.");
			redirectAttributes.addFlashAttribute("historyBackYN","Y");
		}
		return "redirect:/";
	}
	
	@ResponseBody
	@GetMapping("/idcheck.do")
	public String ajaxIdCheck(String checkId) {
		int count = memberService.selectUserIdCount(checkId);
		return count > 0 ? "NNNNN" : "YYYYY";
	}
	
	@ResponseBody
	@GetMapping("/common.data")
	public List<CommonDto> ajaxCommonData(String keyword){
		log.debug("keyword : {}", keyword);
		return memberService.selectCommonData(keyword);
	}
}
