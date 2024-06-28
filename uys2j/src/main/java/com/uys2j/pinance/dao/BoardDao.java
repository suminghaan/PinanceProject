package com.uys2j.pinance.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.BoardDto;
import com.uys2j.pinance.dto.DepartmentDto;
import com.uys2j.pinance.dto.PostDto;
import com.uys2j.pinance.dto.ReplyDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Repository
@Slf4j
public class BoardDao {
	
	private final SqlSessionTemplate sqlSessionTemplate;
	
	// 게시글 목록 조회----------------------------------------------
	public List<BoardDto> selectBoardType(String userName) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("userName", userName);
	    return sqlSessionTemplate.selectList("boardMapper.selectBoardType", params);
	}
	
	public List<PostDto> selectPostList(int boardNo){
		return sqlSessionTemplate.selectList("boardMapper.selectPostList", boardNo);
	}
	
	// 게시글 작성----------------------------------------------
	public BoardDto selectBoard(int boardNo) {
		return sqlSessionTemplate.selectOne("boardMapper.selectBoard", boardNo);
	}
	
	public int insertPost(PostDto post) {
		return sqlSessionTemplate.insert("boardMapper.insertPost", post);
	}
	
	public int insertAttachment(AttachDto attach) {
		return sqlSessionTemplate.insert("boardMapper.insertAttach", attach);
	}
	
	// 게시글 조회----------------------------------------------
	public int updateIncreaseCount(int postNo) {
		return sqlSessionTemplate.update("boardMapper.updateIncreaseCount", postNo);
	}

	public PostDto selectPost(int postNo) {
		return sqlSessionTemplate.selectOne("boardMapper.selectPost", postNo);
	}
	
	// 게시글 수정 + 나중에 selectFileList 추가----------------------------------------------
	public int updatePost(PostDto board) {
		return sqlSessionTemplate.update("boardMapper.updatePost", board);
	}
	
	public List<AttachDto> selectDelFileList(String[] delFileNo){
		return sqlSessionTemplate.selectList("boardMapper.selectDelFileList", delFileNo);
	}
	
	public int deleteAttach(String[] delFileNo) {
		return sqlSessionTemplate.delete("boardMapper.deleteAttach", delFileNo);
	}
	
	// 게시글 삭제----------------------------------------------
	public int deletePost(int postNo) {
		return sqlSessionTemplate.update("boardMapper.deletePost", postNo);
	}

	// 댓글----------------------------------------------
	public List<ReplyDto> selectReplyList(int postNo) {
		return sqlSessionTemplate.selectList("boardMapper.selectReplyList", postNo);
	}
	
	// 댓글작성----------------------------------------------
	public int insertReply(ReplyDto reply) {
		return sqlSessionTemplate.insert("boardMapper.insertReply", reply);
	}
	
	// 댓글수정----------------------------------------------
	public int updateReply(ReplyDto reply) {
		return sqlSessionTemplate.update("boardMapper.updateReply",reply);
	}
	
	// 댓글삭제----------------------------------------------
	public int deleteReply(int replyNo) {
		return sqlSessionTemplate.update("boardMapper.deleteReply", replyNo);
	}
	 
	// 게시판 삭제
	public int deleteBoard(int boardNo) {
		return sqlSessionTemplate.update("boardMapper.deleteBoard", boardNo);
	}
	
	// 게시판 조회
	 public List<BoardDto> selectAllBoards() {
        return sqlSessionTemplate.selectList("boardMapper.selectAllBoards");
    }
	
	// 게시판 생성
	 public int insertBoard(BoardDto board) {
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            if (board.getSelectedMembers() == null) {
                board.setSelectedMembers(new ArrayList<>()); // 빈 리스트로 초기화
            }
            String selectedMembersJson = objectMapper.writeValueAsString(board.getSelectedMembers());
            board.setMembers(selectedMembersJson);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return sqlSessionTemplate.insert("boardMapper.insertBoard", board);
    }
	
	 // 게시판 수정
	public int updateBoard(BoardDto board) {
	    ObjectMapper objectMapper = new ObjectMapper();
	    try {
	        if (board.getSelectedMembers() == null) {
	            board.setSelectedMembers(new ArrayList<>()); // 빈 리스트로 초기화
	        }
	        String selectedMembersJson = objectMapper.writeValueAsString(board.getSelectedMembers());
	        board.setMembers(selectedMembersJson);
	    } catch (JsonProcessingException e) {
	        e.printStackTrace();
	    }
	    return sqlSessionTemplate.update("boardMapper.updateBoard", board);
	}

	public List<BoardDto> mainSelectNotice() {
		//log.debug("notice{}", sqlSessionTemplate.selectList("boardMapper.mainSelectNotice"));
		return sqlSessionTemplate.selectList("boardMapper.mainSelectNotice");
	}
	
	public List<DepartmentDto> selectEmp(String keyword){
		return sqlSessionTemplate.selectList("commonMapper.serachDepartment", keyword);
	}
	
	
	
	
}
