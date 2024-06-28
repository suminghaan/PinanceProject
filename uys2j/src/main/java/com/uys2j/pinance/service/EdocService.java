package com.uys2j.pinance.service;

import java.util.List;

import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.EdocDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.SampleDto;
import com.uys2j.pinance.dto.SaveApprovalDto;
import com.uys2j.pinance.dto.VacationDto;
import com.uys2j.pinance.dto.VacationTypeDto;

public interface EdocService {

	List<SampleDto> selectSampleList();
	
	int insertSample(SampleDto sample);
	
	SampleDto selectSample(int sampleNo);
	
	int updateSample(SampleDto sample,String[] delFileNo);
	
	int deleteSample(int sampleNo);
	
	// 전자결재 상신함 조회
	List<EdocDto> selectUploadApprovalList(MemberDto loginUser);
	
	// 전자결재 상신 
	int insertEdoc(EdocDto edoc);
	
	// 상신한 전자결재 내용 조회
	EdocDto selectEdoc(int edocNo);
	
	// 상신한 전자결재 수정
	int updateEdoc(EdocDto edoc, String[] delFileNo);
	
	// 상신한 전자결재 삭제
	int deleteEdoc(int edoc);

	// 결재상신_샘플양식 내용 조회
	SampleDto ajaxSampleDetail(String sample);

	// 결재상신_샘플양식카테고리별 리스트
	List<SampleDto> ajaxSampleList(String sampleCategory);

	// 결재상신_샘플양식카테고리
	List<SampleDto> edocInsertPage();
	
	List<AttachDto> selectAllDelFile(int no);
	
	// 메인페이지 전자결재 상신함 조회
	List<EdocDto> mainSelectUploadApprovalList(MemberDto loginUser);

	// 자주쓰는 결재선 등록
	int insertMyApproval(SaveApprovalDto sa);

	// 임시저장함 조회
	List<EdocDto> selectTempSaveApprovalList(MemberDto loginUser);

	// 임시저장함에서 등록
	int updateTempSaveEdoc(EdocDto edoc);

	// 결재 완료함 조회
	List<EdocDto> finishApprovalList(MemberDto loginUser);

	// 결재 대기함 조회
	List<EdocDto> approvalList(MemberDto loginUser);

	List<VacationTypeDto> selectVacType();

	int insertVacation(VacationDto vac);

	int updateVacation(VacationDto vac);

	// 자주쓰는 결재선 조회
	List<SaveApprovalDto> selectMyApproval(MemberDto loginUser);

	
}
