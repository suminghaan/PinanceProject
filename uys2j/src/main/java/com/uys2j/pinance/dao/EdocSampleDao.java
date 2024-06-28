package com.uys2j.pinance.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.SampleDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class EdocSampleDao {

	private final SqlSessionTemplate sqlSessionTemplate;

	public int insertSample(SampleDto sample) {
		return sqlSessionTemplate.insert("sampleMapper.insertSample",sample);
	}
	
	public SampleDto selectSample(int sampleNo) {
		return sqlSessionTemplate.selectOne("sampleMapper.selectSample",sampleNo);
	}
	
	public List<SampleDto> selectSampleList() {
		return sqlSessionTemplate.selectList("sampleMapper.selectSampleList");
	}
	
	public int updateSample(SampleDto sample) {
		return sqlSessionTemplate.update("sampleMapper.updateSample", sample);
	}

	public List<SampleDto> selectCodeList() {
		return sqlSessionTemplate.selectList("sampleMapper.codeList");
	}

	public int deleteSample(int sampleNo) {
		return sqlSessionTemplate.update("sampleMapper.deleteSample",sampleNo);
	}

	public int insertAttach(AttachDto at) {
		return sqlSessionTemplate.insert("sampleMapper.insertAt",at);
	}

	public List<AttachDto> selectDelFile(String[] delFileNo) {
		return sqlSessionTemplate.selectList("sampleMapper.selectDelFile",delFileNo);
	}

	public int deleteAttach(String[] delFileNo) {
		return sqlSessionTemplate.delete("sampleMapper.deleteAttach",delFileNo);
	}
	
	public int ajaxUpdateList(SampleDto sample) {
		return sqlSessionTemplate.update("sampleMapper.updateList",sample);
	}

	public List<AttachDto> selectAllDelFile(int sampleNo) {
		return sqlSessionTemplate.selectList("sampleMapper.selectAllDelFile",sampleNo);
	}

	public int deleteAllAttach(int sampleNo) {
		return sqlSessionTemplate.delete("sampleMapper.deleteAllAttach",sampleNo);
	}
	
	
}
