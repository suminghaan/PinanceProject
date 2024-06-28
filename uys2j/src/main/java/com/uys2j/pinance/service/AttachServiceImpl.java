package com.uys2j.pinance.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.uys2j.pinance.dao.AttachDao;
import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.MemberDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class AttachServiceImpl implements AttachService {
	
	private final AttachDao attachDao;
	
	@Override
	public int insertFile(AttachDto file) {
		return attachDao.insertFile(file);
	}

	@Override
	public int updateFile(AttachDto file) {
		return attachDao.updateFile(file);
	}

	@Override
	public int deleteFile(String[] fileNo) {
		return attachDao.deleteFile(fileNo);
	}

	@Override
	public int insertSignMember(AttachDto signAtt) {
		log.debug("attdao:{}", attachDao.insertSignMember(signAtt));
		return attachDao.insertSignMember(signAtt);
	}

	@Override
	public int countSignMember(MemberDto m) {
		return attachDao.countSignMember(m);
	}

	@Override
	public AttachDto deleteSignMember(AttachDto signAtt) {
		return attachDao.deleteSignMember(signAtt);
		
	}
	
}
