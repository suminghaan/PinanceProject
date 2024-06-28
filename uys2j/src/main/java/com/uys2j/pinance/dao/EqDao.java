package com.uys2j.pinance.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.EqDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class EqDao {
	
	private final SqlSessionTemplate sqlSessionTemplate;
	
	// 비품 목록 조회
	public List<EqDto> eqSelect(){
		return sqlSessionTemplate.selectList("eqMapper.eqSelect");
	}
	
	// 비품 추가
	public int eqInsert(EqDto e) {
		return sqlSessionTemplate.insert("eqMapper.eqInsert", e);
	}
	
	public int attachInsert(AttachDto attach) {
		return sqlSessionTemplate.insert("eqMapper.attachInsert", attach);
	}

	// 비품 삭제
	public int eqDelete(EqDto e) {
		return sqlSessionTemplate.update("eqMapper.eqDelete", e);
	}

	// 비품 수정
	public int eqUpdate(EqDto e) {
		return sqlSessionTemplate.update("eqMapper.eqUpdate", e);
	}
	
	public EqDto eqUpdatePage(int eqNo) {
		return sqlSessionTemplate.selectOne("eqMapper.eqUpdatePage", eqNo);
	}
	
	public List<AttachDto> selectDelFile(String[] delFileNo){
		return sqlSessionTemplate.selectList("eqMapper.selectDelFile", delFileNo);
	}
	
	public int deleteAttach(String[] delFileNo) {
		return sqlSessionTemplate.delete("eqMapper.attachDelete", delFileNo);
	}
	
	public int insertAttachment(AttachDto attach) {
		return sqlSessionTemplate.insert("eqMapper.attachInsert", attach);
	}

}
