package com.uys2j.pinance.service;

import java.util.List;

import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.MemberDto;

public interface AttachService {
	
	//파일 추가
	int insertFile(AttachDto file);
	
	//파일 수정
	int updateFile(AttachDto file);
	
	//파일 삭제
	int deleteFile(String[] fileNo);
	
	// sign 이미지파일 추가
	int insertSignMember(AttachDto signAtt);
	
	// sign 조회
	int countSignMember(MemberDto m);
	
	// sign 삭제
	AttachDto deleteSignMember(AttachDto signAtt);
	
	
}
