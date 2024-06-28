package com.uys2j.pinance.service;

import java.util.List;

import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.BoardDto;
import com.uys2j.pinance.dto.DepartmentDto;
import com.uys2j.pinance.dto.PostDto;
import com.uys2j.pinance.dto.ReplyDto;

public interface BoardService {
	
	// 게시글 타입 조회
	List<BoardDto> selectBoardType(String userName);
	List<BoardDto> selectAllBoards();
	
	// 게시글 목록조회
	List<PostDto> selectPostList(int boardNo);
	
	// 게시글 등록 페이지
	int insertPost(PostDto post);
	BoardDto selectBoard(int boardNo);
	
	// 게시글 상세페이지
	int updateIncreaseCount(int postNo);
	PostDto selectPost(int postNo);
	
	// 게시글 수정 페이지
	int updatePost(PostDto post, String[] delFileNo);
	List<AttachDto> selectDelFileList(String[] delFileNo);
	
	// 게시글 삭제
	int deletePost(int postNo);
	
	// 댓글리스트 조회
	List<ReplyDto> selectReplyList(int postNo);
	
	// 댓글 작성
	int insertReply(ReplyDto reply);
	
	// 댓글 수정
	int updateReply(ReplyDto reply);
	
	// 댓글 삭제
	int deleteReply(int replyNo);
	
	// 게시판 생성
	int insertBoard(BoardDto board);
	
	// 게시판 수정
	int updateBoard(BoardDto board);
	
	// 게시판 삭제
	int deleteBoard(int boardNo);
	
	// 메인 공지사항 조회
	List<BoardDto> mainSelectNotice();
	
	List<DepartmentDto> selectEmp(String keyword);

}
