package com.uys2j.pinance.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.uys2j.pinance.dao.EqDao;
import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.EqDto;
import com.uys2j.pinance.dto.PostDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class EqServiceImpl implements EqService {
	
	private final EqDao eqDao;

	@Override
	public List<EqDto> eqSelect() {
		return eqDao.eqSelect();
	}

	@Override
	public int eqInsert(EqDto e) {
		
		int result1 = eqDao.eqInsert(e);
		
		int result2 = 0;
		
		List<AttachDto> attachList = e.getAttachList();
		if(!attachList.isEmpty()) {
			result2 = 0;
			for(AttachDto at : attachList) {
				result2 += eqDao.attachInsert(at);
			}
		}
		return result1*result2;
	}

	@Override
	public int eqDelete(EqDto e) {
		return eqDao.eqDelete(e);
	}

	@Override
	public int eqUpdate(EqDto e, String[] delFileNo) {
		
		int result1 = eqDao.eqUpdate(e);
		
		int result2 = (delFileNo == null) ? 1
										: eqDao.deleteAttach(delFileNo);
		
		List<AttachDto> list = e.getAttachList();
		int result3 = 0;
		for(AttachDto at : list) {
			result3 += eqDao.insertAttachment(at);
		}
		
		return result1 == 1 
				&& result2 > 0 
					&& result3 == list.size() 
						? 1 : -1;
	}

	@Override
	public EqDto eqUpdatepage(int eqNo) {
		return eqDao.eqUpdatePage(eqNo);
	}

	@Override
	public List<AttachDto> selectDelFile(String[] delFileNo) {
		return delFileNo != null ? eqDao.selectDelFile(delFileNo)
				 : new ArrayList<AttachDto>();
	}
	
	

}
