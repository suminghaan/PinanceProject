package com.uys2j.pinance.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.MemberDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Repository
public class AttachDao {
	
	private final SqlSessionTemplate sqlSessionTemplate;
	
	public int insertFile(AttachDto file) {
		return sqlSessionTemplate.insert("insertFile", file);
	}

	public int updateFile(AttachDto file) {
		return sqlSessionTemplate.update("updateFile", file);
	}

	public int deleteFile(String[] fileNo) {
		return sqlSessionTemplate.delete("deleteFile", fileNo);
	}

	public int insertSignMember(AttachDto signAtt) {
		return sqlSessionTemplate.insert("attachMapper.insertSignMember", signAtt);
	}
	
	public int countSignMember(MemberDto m) {
		return sqlSessionTemplate.selectOne("attachMapper.countSignMember", m);
	}

	public AttachDto deleteSignMember(AttachDto signAtt) {
		log.debug("sign:{}", signAtt);
		return sqlSessionTemplate.selectOne("attachMapper.selectDelFileList", signAtt);
	}
	
}
