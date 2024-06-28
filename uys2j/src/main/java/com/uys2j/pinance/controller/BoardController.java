package com.uys2j.pinance.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.BoardDto;
import com.uys2j.pinance.dto.DefaultDto;
import com.uys2j.pinance.dto.DepartmentDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.PostDto;
import com.uys2j.pinance.dto.ReplyDto;
import com.uys2j.pinance.service.BoardSerivceImpl;
import com.uys2j.pinance.util.FileUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/board")
@RequiredArgsConstructor
@Controller
public class BoardController {
	
	private final BoardSerivceImpl boardService;
	private final FileUtil fileUtil;


	@ModelAttribute("boardList")
    public List<BoardDto> populateBoardList(HttpSession session) {
        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
        if (loginUser != null) {
            String userName = loginUser.getUserName();
            List<BoardDto> boardList = boardService.selectBoardType(userName);
            session.setAttribute("bNo", boardList);
            return boardList;
        }
        return new ArrayList<>();
    }
	
	@GetMapping("/boardList.do")
	public ModelAndView selectPostList(@RequestParam(value="type") int boardNo, ModelAndView mv, HttpSession session) {
	    MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
       	String userName = loginUser.getUserName();

        // 사용자 ID를 기반으로 접근 가능한 게시판 목록을 조회
        List<PostDto> list = boardService.selectPostList(boardNo);
        List<BoardDto> bList = boardService.selectBoardType(userName);
        
        mv.addObject("list", list)
          .addObject("bList", bList)
          .setViewName("board/boardList");

	    return mv;
	}
	
	@GetMapping("/increase.do")
	public String increaseBoard(int no) {
		boardService.updateIncreaseCount(no);
		return "redirect:/board/boardDetail.do?no=" + no;
	}
	
	@GetMapping("/boardDetail.do") 
	public String detail(int no, Model model) { 
		model.addAttribute("board", boardService.selectPost(no));
		return "board/boardDetail";
	}
	
	@GetMapping("/registForm.page")
	public String registForm(int boardNo, Model model) {
		model.addAttribute("board", boardService.selectBoard(boardNo));
		return "board/registForm";
	}
	
	@PostMapping("/regist.do")
	public String insertPost(PostDto post
			   			 , List<MultipartFile> uploadFiles
			   			 , HttpSession session
			   			 , RedirectAttributes redirectAttributes) {
		
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		String userId = loginUser.getUserId();
		DefaultDto defaultDto = new DefaultDto();
		defaultDto.setRegId(userId);
		post.setDefaultDto(defaultDto);
	
		List<AttachDto> attachList = new ArrayList<>();
		for(MultipartFile uploadFile : uploadFiles) {
			if(uploadFile != null && !uploadFile.isEmpty()) {
				Map<String, String> map = fileUtil.fileUpload(uploadFile, "post");
				
				attachList.add( AttachDto.builder()
										 .filePath(map.get("filePath"))
										 .filesystemName(map.get("filesystemName"))
										 .originalName(map.get("originalName"))
										 .refType("1")
										 .refNo(post.getPostNo())
										 .defaultDto(defaultDto)
										 .build() );
			}
		}
		post.setAttachList(attachList);
		
		int result = boardService.insertPost(post);
		
		redirectAttributes.addFlashAttribute("alertTitle", "게시판 작성 서비스");
		
		if(attachList.isEmpty() && result == 1 || !attachList.isEmpty() && result == attachList.size()) {
			
			redirectAttributes.addFlashAttribute("alertMsg", "게시판 작성에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "게시판 작성에 실패하였습니다.");
			
		}
		
		return "redirect:/board/boardList.do?type=" + post.getBoardNo();
	}
	
	@GetMapping("/modifyForm.page")
	public String modifyForm(int no, Model model) {
		model.addAttribute("board", boardService.selectPost(no));
		return "board/modifyForm";
	}
	
	@PostMapping("/modify.do")
	public String updatePost(@RequestParam(value="no") int no
						   , PostDto post
						   , HttpSession session
						   , String[] delFileNo
						   , List<MultipartFile> uploadFiles
					       , RedirectAttributes redirectAttributes) {
		
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		String userId = loginUser.getUserId();
		DefaultDto defaultDto = new DefaultDto();
		defaultDto.setRegId(userId);
		post.setDefaultDto(defaultDto);
		
		List<AttachDto> delFileList = boardService.selectDelFileList(delFileNo);
		log.debug("delFileList {}", delFileList);
		List<AttachDto> addFileList = new ArrayList<>();
		for(MultipartFile uploadFile : uploadFiles) {
			if(uploadFile != null && !uploadFile.isEmpty()) {
				Map<String, String> map = fileUtil.fileUpload(uploadFile, "board");
				addFileList.add( AttachDto.builder()
										  .originalName(map.get("originalName"))
										  .filePath(map.get("filePath"))
										  .filesystemName(map.get("filesystemName"))
										  .refType("1")
										  .refNo(post.getPostNo())
										  .defaultDto(defaultDto)
										  .build() );
			}
		}
		
		post.setAttachList(addFileList);
		
		int result = boardService.updatePost(post, delFileNo);
		
		log.debug("delFileList {}", delFileList);
		redirectAttributes.addFlashAttribute("alertTitle", "게시글 수정 서비스");
		if(result > 0) {
			for(AttachDto at : delFileList) {
				new File( at.getFilePath() + "/" + at.getFilesystemName() ).delete();
			}
			
			redirectAttributes.addFlashAttribute("alertMsg", "게시글이 성공적으로 수정되었습니다.");		
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "게시글 수정에 실패하였습니다.");
		}
		
		return "redirect:/board/boardDetail.do?no=" + no; 
	}
	
	@GetMapping("/delete.do")
	public String deldetePost(@RequestParam(value="no") int no
							, @RequestParam(value="type") int boardNo
			 				, RedirectAttributes redirectAttributes) {
		
		int result = boardService.deletePost(no);
		
		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "게시글이 성공적으로 삭제되었습니다.");		
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "게시글 삭제에 실패하였습니다.");
		}
		return "redirect:/board/boardList.do?type=" + boardNo; 
	}
	
	@ResponseBody
	@GetMapping(value="/replyList.do", produces="application/json; charset=utf-8")
	public List<ReplyDto> ajaxReplyList(int no) {
		return boardService.selectReplyList(no);
	}
	
	@ResponseBody
	@PostMapping("/registReply.do")
	public String ajaxInsertReply(ReplyDto reply, HttpSession session) {
	    MemberDto m = (MemberDto) session.getAttribute("loginUser");
	    
	    DefaultDto defaultDto = new DefaultDto();
	    defaultDto.setRegId(m.getUserId());

	    reply.setDefaultDto(defaultDto);
	    
	    return boardService.insertReply(reply) > 0 ? "SUCCESS" : "FAIL";
	}


	
	@ResponseBody
	@PostMapping("/updateReply.do")
	public String ajaxUpdateReply(ReplyDto reply, HttpSession session) {
		MemberDto m = (MemberDto) session.getAttribute("loginUser");
	    
	    DefaultDto defaultDto = new DefaultDto();
	    defaultDto.setRegId(m.getUserId());

	    reply.setDefaultDto(defaultDto);
		
		return boardService.updateReply(reply) > 0 ? "SUCCESS" : "FAIL";
	}
	
	@ResponseBody
	@GetMapping("/removeReply.do")
	public String ajaxDeleteReply(int no) {
		return boardService.deleteReply(no) > 0 ? "SUCCESS" : "FAIL";
	}
	
	@GetMapping("/boardManage.do")
    public String boardManage(Model model, HttpSession session) {
		 List<BoardDto> boardList = boardService.selectAllBoards();
		 model.addAttribute("boardList", boardList);
        return "board/boardManage";
    }

    @ResponseBody
    @GetMapping("/removeBoard.do")
    public String ajaxDeleteBoard(int no) {
        return boardService.deleteBoard(no) > 0 ? "SUCCESS" : "FAIL";
    }

    @GetMapping("/boardCreate.page")
    public String boardCreateForm() {
        return "board/boardCreate";
    }

    @PostMapping("/registBoard.do")
    public String boardInsert(BoardDto board, @RequestParam(value="selectedMembers", required=false) String selectedMembersJson, @RequestParam("defaultRoleHidden") String defaultRoleHidden, RedirectAttributes redirectAttributes, HttpSession session) throws IOException {
        MemberDto m = (MemberDto) session.getAttribute("loginUser");

        DefaultDto defaultDto = new DefaultDto();
        defaultDto.setRegId(m.getUserId());

        board.setDefaultDto(defaultDto);

        if (selectedMembersJson == null || selectedMembersJson.isEmpty()) {
            selectedMembersJson = "[]"; // 빈 리스트로 초기화
        }
        List<String> selectedMembers = new ObjectMapper().readValue(selectedMembersJson, new TypeReference<List<String>>() {});
        board.setSelectedMembers(selectedMembers);

        // Assign default role
        board.setDefaultRole(defaultRoleHidden);

        int result = boardService.insertBoard(board);
        if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "게시판이 성공적으로 생성되었습니다.");		
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "게시판 생성에 실패하였습니다.");
		}
        return "redirect:/board/boardManage.do";
    }

	@GetMapping("/modifyBoard.page")
	public String boardModifyForm(int no, Model model, HttpSession session) {
	    BoardDto board = boardService.selectBoard(no);
	    model.addAttribute("b", board);
	    log.debug("DD {}", board);

	    // 선택된 멤버 정보를 JSON 형식으로 변환하여 모델에 추가
	    ObjectMapper objectMapper = new ObjectMapper();
	    try {
	        List<String> selectedMembers = board.getSelectedMembers();
	        if (selectedMembers == null) {
	            selectedMembers = new ArrayList<>();  
	        }
	        String selectedMembersJson = objectMapper.writeValueAsString(selectedMembers);
	        model.addAttribute("selectedMembersJson", selectedMembersJson);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	    return "board/boardModify";
	}
	
	@PostMapping("/modifyBoard.do")
	public String boardUpdate(BoardDto board, @RequestParam(value="selectedMembers", required=false) String selectedMembersJson, @RequestParam("defaultRoleHidden") String defaultRoleHidden, RedirectAttributes redirectAttributes, HttpSession session) throws IOException {
	    MemberDto m = (MemberDto) session.getAttribute("loginUser");

	    DefaultDto defaultDto = new DefaultDto();
	    defaultDto.setRegId(m.getUserId());

	    board.setDefaultDto(defaultDto);

	    if (selectedMembersJson == null || selectedMembersJson.isEmpty()) {
	        selectedMembersJson = "[]"; // 빈 리스트로 초기화
	    }
	    List<String> selectedMembers = new ObjectMapper().readValue(selectedMembersJson, new TypeReference<List<String>>() {});
	    board.setSelectedMembers(selectedMembers);

	    // Assign default role
	    board.setDefaultRole(defaultRoleHidden);

	    int result = boardService.updateBoard(board);
	    if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "게시판이 성공적으로 수정되었습니다.");		
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "게시판 수정에 실패하였습니다.");
		}
	    return "redirect:/board/boardManage.do";
	}
	
	@GetMapping("/deptList.do")
	@ResponseBody
	public List<DepartmentDto> ajaxDeptList(String keyword){
		List<DepartmentDto> list = boardService.selectEmp(keyword);
		return list;
	}

	
	
	

}
