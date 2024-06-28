package com.uys2j.pinance.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.uys2j.pinance.dao.EdocDao;
import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.EdocApprovalDto;
import com.uys2j.pinance.dto.EdocDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.RefDto;
import com.uys2j.pinance.dto.SampleDto;
import com.uys2j.pinance.dto.SaveApprovalDto;
import com.uys2j.pinance.dto.VacationDto;
import com.uys2j.pinance.dto.VacationTypeDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EdocServiceImpl implements EdocService {
	
	private final EdocDao edocDao;
	
	//----------샘플양식용 메소드 start------------------------//
	@Override
	public List<SampleDto> selectSampleList() {
		return null;
	}

	@Override
	public int insertSample(SampleDto sample) {
		return 0;
	}

	@Override
	public SampleDto selectSample(int sampleNo) {
		return null;
	}

	@Override
	public int updateSample(SampleDto sample, String[] delFileNo) {
		return 0;
	}

	@Override
	public int deleteSample(int sampleNo) {
		return 0;
	}
	//----------샘플양식용 메소드 end------------------------//

	//----------결재 상신/조회 메소드 start------------------//
	
	// 결재 상신함 조회
	@Override
	public List<EdocDto> selectUploadApprovalList(MemberDto loginUser) {		
		return edocDao.selectUploadApprovalList(loginUser);
	}

	// 결재 상신
	@Override
	public int insertEdoc(EdocDto edoc) {
		int result1 = edocDao.insertEdoc(edoc);
		
		int result2 = 1;
		
		List<AttachDto> atList = edoc.getAttachList();
		if(!atList.isEmpty()) {
			result2 = 0;
			for(AttachDto at : atList) {
				result2 += edocDao.insertAttach(at);
			}
		}
		
		return result1 * result2;
	}

	// 상신한 결재문서 조회
	@Override
	public EdocDto selectEdoc(int edocNo) {
		return edocDao.selectEdoc(edocNo);
	}

	// 상신한 결재문서 수정
	@Override
	public int updateEdoc(EdocDto edoc, String[] delFileNo) {
		int result1 = edocDao.updateEdoc(edoc);
		int result2 = delFileNo == null ? 1
										: edocDao.deleteAttach(delFileNo);
		
		List<AttachDto> list = edoc.getAttachList();
		int result3 = 0;
		for(AttachDto at : list) {
			result3 += edocDao.insertAttach(at);
		}
		
		return result1 == 1 && result2 > 0 && result3 == list.size() ? 1 : -1;
	}
	public List<AttachDto> selectDelFile(String[] delFileNo) {
		return delFileNo != null ? edocDao.selectDelFile(delFileNo)
								 : new ArrayList<AttachDto>();
	}

	// 상신한 결재문서 삭제
	@Override
	public int deleteEdoc(int docNo) {
		int result1 = edocDao.deleteEdoc(docNo);
		int result2 = edocDao.selectAllDelFile(docNo) == null ? 1
											: edocDao.deleteAllAttach(docNo);
		
		return result1 == 1 && result2 > 0 ? 1 : -1;
		
	}

	// 결재상신_샘플양식카테고리
	@Override
	public List<SampleDto> edocInsertPage() {
		return edocDao.edocInsertPage();
	}

	// 결재상신_샘플양식카테고리별 리스트
	@Override
	public List<SampleDto> ajaxSampleList(String sampleCategory) {
		return edocDao.ajaxSampleList(sampleCategory);
	}

	// 결재상신_샘플양식 내용 조회
	@Override
	public SampleDto ajaxSampleDetail(String sample) {
		return edocDao.ajaxSampleDetail(sample);
	}
	
	// 결재상신페이지_자주쓰는 결재선 불러오기
	public SaveApprovalDto ajaxSelectMyApproval(int saNo) {
		return edocDao.ajaxSelectMyApproval(saNo);
	}

	// 임시저장함 조회
	@Override
	public List<EdocDto> selectTempSaveApprovalList(MemberDto loginUser) {
		return edocDao.selectTempSaveApprovalList(loginUser);
	}

	// 임시저장함에서 등록
	@Override
	public int updateTempSaveEdoc(EdocDto edoc) {
		int result1 = edocDao.updateTempSaveEdoc(edoc);
		int result2 = 1;
		
		List<AttachDto> atList = edoc.getAttachList();
		if(!atList.isEmpty()) {
			result2 = 0;
			for(AttachDto at : atList) {
				result2 += edocDao.insertAttach(at);
			}
		}
		return result1 * result2;
	}

	// 결재 완료함 조회
	@Override
	public List<EdocDto> finishApprovalList(MemberDto loginUser) {
		return edocDao.finishApprovalList(loginUser);
	}

	// 결재 대기함 조회
	@Override
	public List<EdocDto> approvalList(MemberDto loginUser) {
		return edocDao.selectApprovalList(loginUser);
	}

	// 삭제할 파일 전체조회
	@Override
	public List<AttachDto> selectAllDelFile(int no) {
		return edocDao.selectAllDelFile(no);
	}

	@Override
	public List<VacationTypeDto> selectVacType() {
		return edocDao.selectVacType();
	}

	@Override
	public int insertVacation(VacationDto vac) {
		return edocDao.insertVacation(vac);
	}

	@Override
	public int updateVacation(VacationDto vac) {
		return edocDao.updateVacation(vac);
	}
	
	// 메인페이지 결재 상신함 조회
	@Override
	public List<EdocDto> mainSelectUploadApprovalList(MemberDto loginUser) {
		return edocDao.mainSelectUploadApprovalList(loginUser);
	}

	// 자주쓰는 결재선 조회
	@Override
	public List<SaveApprovalDto> selectMyApproval(MemberDto loginUser) {
		return edocDao.selectMyApproval(loginUser);
	}
	
	// 자주쓰는 결재선 등록
	@Override
	public int insertMyApproval(SaveApprovalDto sa) {
		return edocDao.insertMyapproval(sa);
	}

	// 자주쓰는 결재선 삭제
	public int deleteMyApproval(int saNo) {
		return edocDao.deleteMyApproval(saNo);
	}

	// 자주쓰는 결재선 수정
	public SaveApprovalDto approvalDetail(String saNo) {
		return edocDao.approvalDetail(saNo);
	}

	// 자주쓰는 결재선 조회
	public List<SaveApprovalDto> seleteMyApproval(MemberDto loginUser) {
		return edocDao.selectMyApproval(loginUser);
	}

	// 결재상신_결재라인, 참조자 등록
	public int insertEdocApproval(List<EdocApprovalDto> ealist, List<RefDto> reflist ) {
		return edocDao.insertEdocApproval(ealist,reflist);
	}

	// 전자결재 상세조회_ 결재선 목록
	public List<EdocApprovalDto> selectEdocEa(int no) {
		return edocDao.selectEdocEa(no);
	}

	// 전자결재 상세조회_ 참조자 목록
	public List<RefDto> selectEdocRef(int no) {
		return edocDao.selectEdocRef(no);
	}

	// 결재버튼 클릭시 status 값 update
	public int ajaxUpdateApBtn(int docNo, MemberDto loginUser) {
		return edocDao.ajaxUpdateApBtn(docNo, loginUser);
	}

	// 결재버튼 클릭시 update성공했을 경우 sing이미지 가져오기
	public AttachDto ajaxSelectApBtn(int docNo,MemberDto loginUser) {
		return edocDao.ajaxSelectApBtn(docNo, loginUser);
	}

	/* 상신한 결재목록 조회_사인 목록
	public List<AttachDto> selectSignAtList() {
		return edocDao.selectSignAtList();
	}
	*/

	// 반려버튼 클릭시 status 값 update 
	public int ajaxUpdateRejBtn(int docNo, MemberDto loginUser) {
		return edocDao.ajaxUpdateRejBtn(docNo, loginUser);
	}

	// 결재버튼_사인이없는 경우
	public EdocApprovalDto selectEa(int docNo, MemberDto loginUser) {
		return edocDao.selectEa(docNo, loginUser);
	}

	// 결재수정_결재라인, 참조자 등록
	public int modifyInsertEdocApproval(List<EdocApprovalDto> ealist, List<RefDto> reflist) {
		return edocDao.modifyInsertEdocApproval(ealist, reflist);
	}

	// 결재수정페이지 접속시 결재선 삭제 
	public int deleteEdocApproval(int no) {
		return edocDao.deleteEdocApproval(no);
	}

	

	

	

	


	
	
	//----------결재 상신/조회 메소드 end------------------//

}
