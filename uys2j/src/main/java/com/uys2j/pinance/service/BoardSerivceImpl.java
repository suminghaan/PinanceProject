package com.uys2j.pinance.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.uys2j.pinance.dao.BoardDao;
import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.BoardDto;
import com.uys2j.pinance.dto.DepartmentDto;
import com.uys2j.pinance.dto.PostDto;
import com.uys2j.pinance.dto.ReplyDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Service
@Slf4j
public class BoardSerivceImpl implements BoardService {
	
	private final BoardDao boardDao;
	

	@Override
	public List<BoardDto> selectBoardType(String userName) {
		return boardDao.selectBoardType(userName);
	}
	
	@Override
	public List<PostDto> selectPostList(int boardNo) {
		return boardDao.selectPostList(boardNo);
	}
	
	@Override
	public BoardDto selectBoard(int boardNo) {
		return boardDao.selectBoard(boardNo);
	}

	@Override
	public int insertPost(PostDto post) {
		
		int result1 = boardDao.insertPost(post);
		
		int result2 = 1;
		List<AttachDto> attachList = post.getAttachList();
		if(!attachList.isEmpty()) {
			result2 = 0;
			for(AttachDto at : attachList) {
				result2 += boardDao.insertAttachment(at);
			}
		}
		return result1 * result2;
	}
	
	@Override
	public int updateIncreaseCount(int postNo) {
		return boardDao.updateIncreaseCount(postNo);
	}

	@Override
	public PostDto selectPost(int postNo) {
		return boardDao.selectPost(postNo);
	}

	@Override
	public int updatePost(PostDto post, String[] delFileNo) {
		
		int result1 = boardDao.updatePost(post);
		
		int result2 = delFileNo == null ? 1
										: boardDao.deleteAttach(delFileNo);
		
		List<AttachDto> list = post.getAttachList();
		int result3 = 0;
		for(AttachDto at : list) {
			result3 += boardDao.insertAttachment(at);
		}
		
		return result1 == 1 
				&& result2 > 0 
					&& result3 == list.size() 
						? 1 : -1;
	}
	
	@Override
	public List<AttachDto> selectDelFileList(String[] delFileNo) {
		return delFileNo != null ? boardDao.selectDelFileList(delFileNo)
								 : new ArrayList<AttachDto>();
	}

	@Override
	public int deletePost(int postNo) {
		return boardDao.deletePost(postNo);
	}

	@Override
	public List<ReplyDto> selectReplyList(int postNo) {
		return boardDao.selectReplyList(postNo);
	}

	@Override
	public int insertReply(ReplyDto reply) {
		return boardDao.insertReply(reply);
	}

	@Override
	public int updateReply(ReplyDto reply) {
		return boardDao.updateReply(reply);
	}

	@Override
	public int deleteReply(int replyNo) {
		return boardDao.deleteReply(replyNo);
	}

	@Override
	public int deleteBoard(int boardNo) {
		return boardDao.deleteBoard(boardNo);
	}
	
	 public List<BoardDto> selectAllBoards(){
		 return boardDao.selectAllBoards();
	 }
	 
    public int insertBoard(BoardDto board) {
        return boardDao.insertBoard(board);
    }

	@Override
	public int updateBoard(BoardDto board) {
		return boardDao.updateBoard(board);
	}

	public List<BoardDto> mainSelectNotice() {
		return boardDao.mainSelectNotice();
	}
	
	public List<DepartmentDto> selectEmp(String keyword) {
		return boardDao.selectEmp(keyword);
	}

	

}
