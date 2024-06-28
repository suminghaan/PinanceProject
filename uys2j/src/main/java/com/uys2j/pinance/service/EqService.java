package com.uys2j.pinance.service;

import java.util.List;

import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.EqDto;
import com.uys2j.pinance.dto.PostDto;

public interface EqService {
	
	// 비품 조회
	List<EqDto> eqSelect();
	   
   // 비품 추가
   int eqInsert(EqDto e);
   
   // 비품 삭제
   int eqDelete(EqDto e);
      
   // 비품 수정
   
   int eqUpdate(EqDto e, String[] delFileNo);
   EqDto eqUpdatepage(int eqNo);
   List<AttachDto> selectDelFile(String[] delFileNo);

}