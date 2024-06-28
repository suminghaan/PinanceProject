package com.uys2j.pinance.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.uys2j.pinance.dao.EdocSampleDao;
import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.EdocDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.SampleDto;
import com.uys2j.pinance.dto.SaveApprovalDto;
import com.uys2j.pinance.dto.VacationDto;
import com.uys2j.pinance.dto.VacationTypeDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EdocSampleServiceImpl implements EdocService {
	
	private final EdocSampleDao sampleDao;
	
	@Override
	public List<SampleDto> selectSampleList() {
		return sampleDao.selectSampleList();
	}

	@Override
	public int insertSample(SampleDto sample) {
		int result1 =sampleDao.insertSample(sample); 
		
		int result2 = 1;
		
		List<AttachDto> atList = sample.getAttachList();
		if(!atList.isEmpty()) {
			result2 = 0;
			for(AttachDto at : atList) {
				at.setDefaultDto(sample.getDefaultDto());
				result2 += sampleDao.insertAttach(at);
			}
		}
		
		return result1 * result2;
	}

	@Override
	public SampleDto selectSample(int sampleNo) {
		return sampleDao.selectSample(sampleNo);
	}

	@Override
	public int updateSample(SampleDto sample,String[] delFileNo) {
		int result1 = sampleDao.updateSample(sample);
		int result2 = delFileNo == null ? 1
				: sampleDao.deleteAttach(delFileNo);
		
		List<AttachDto> list = sample.getAttachList();
		int result3 = 0 ;
		for(AttachDto at : list) {
			at.setDefaultDto(sample.getDefaultDto());
			result3 += sampleDao.insertAttach(at);
		}
		
		
		return result1 == 1 && result2 >0 && result3 == list.size() ? 1 : -1;
	}
	
	@Override
	public int deleteSample(int sampleNo) {
		int result1 = sampleDao.deleteSample(sampleNo);
		int result2 = sampleDao.selectAllDelFile(sampleNo) == null ? 1
				: sampleDao.deleteAllAttach(sampleNo);
		
		return result1 == 1 && result2 >0 ? 1 : -1;
	}
	@Override
	public List<AttachDto> selectAllDelFile(int no) {
		return sampleDao.selectAllDelFile(no);
	}
	
	public List<SampleDto> selectCodeList() {
		return sampleDao.selectCodeList();
	}

	
	public List<AttachDto> selectDelFile(String[] delFileNo) {
		return delFileNo != null ? sampleDao.selectDelFile(delFileNo) 
								 : new ArrayList<AttachDto>();
	}
	
	public int ajaxUpdateList(SampleDto sample) {
		return sampleDao.ajaxUpdateList(sample);
	}
	
	
	//상신 ---------------------------------------------


	@Override
	public int insertEdoc(EdocDto edoc) {
		return 0;
	}

	@Override
	public EdocDto selectEdoc(int edocNo) {
		return null;
	}

	@Override
	public int updateEdoc(EdocDto edoc, String[] delFileNo) {
		return 0;
	}


	@Override
	public int deleteEdoc(int edoc) {
		return 0;
	}

	@Override
	public SampleDto ajaxSampleDetail(String sample) {
		return null;
	}

	@Override
	public List<SampleDto> ajaxSampleList(String sampleCategory) {
		return null;
	}

	@Override
	public List<SampleDto> edocInsertPage() {
		return null;
	}

	@Override
	public List<EdocDto> selectUploadApprovalList(MemberDto loginUser) {
		return null;
	}

	@Override
	public List<EdocDto> mainSelectUploadApprovalList(MemberDto loginUser) {
		return null;
	}

	@Override
	public int insertMyApproval(SaveApprovalDto sa) {
		return 0;
	}

	@Override
	public List<EdocDto> selectTempSaveApprovalList(MemberDto loginUser) {
		return null;
	}

	@Override
	public int updateTempSaveEdoc(EdocDto edoc) {
		return 0;
	}

	@Override
	public List<EdocDto> finishApprovalList(MemberDto loginUser) {
		return null;
	}


	@Override
	public List<VacationTypeDto> selectVacType() {
		return null;
	}

	@Override
	public int insertVacation(VacationDto vac) {
		return 0;
	}

	@Override
	public int updateVacation(VacationDto vac) {
		return 0;
	}

	@Override
	public List<SaveApprovalDto> selectMyApproval(MemberDto loginUser) {
		return null;
	}

	@Override
	public List<EdocDto> approvalList(MemberDto loginUser) {
		return null;
	}

	
	//상신 ---------------------------------------------
	

}
