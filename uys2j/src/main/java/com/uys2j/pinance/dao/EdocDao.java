package com.uys2j.pinance.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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

@Repository
@RequiredArgsConstructor
public class EdocDao {
	
	private final SqlSessionTemplate sqlSessionTemplate;

	// 결재상신함 조회
	public List<EdocDto> selectUploadApprovalList(MemberDto loginUser) {
		return sqlSessionTemplate.selectList("edocMapper.selectUploadApprovalList", loginUser);
	}

	// 결재상신_샘플양식카테고리
	public List<SampleDto> edocInsertPage() {
		return sqlSessionTemplate.selectList("edocMapper.edocInsertPage");
	}

	// 결재상신_샘플양식카테고리별 리스트
	public List<SampleDto> ajaxSampleList(String sampleCategory) {
		return sqlSessionTemplate.selectList("edocMapper.ajaxSampleList", sampleCategory);
	}

	// 결재상신_샘플양식 내용 조회
	public SampleDto ajaxSampleDetail(String sample) {
		return sqlSessionTemplate.selectOne("edocMapper.ajaxSampleDetail", sample);
	}
	
	// 결재상신페이지_자주쓰는 결재선 불러오기
	public SaveApprovalDto ajaxSelectMyApproval(int saNo) {
		return sqlSessionTemplate.selectOne("edocMapper.ajaxSelectMyApproval", saNo);
	}

	// 결재상신_등록
	public int insertEdoc(EdocDto edoc) {
		return sqlSessionTemplate.insert("edocMapper.insertEdoc", edoc);		
	}
	// 결재상신_첨부파일등록
	public int insertAttach(AttachDto at) {
		return sqlSessionTemplate.insert("edocMapper.insertAt", at);
	}
	public int getcurentNo() {
		return sqlSessionTemplate.selectOne("edocMapper.getcurentNo");
	}

	// 상신한 결재 문서 조회
	public EdocDto selectEdoc(int docNo) {
		return sqlSessionTemplate.selectOne("edocMapper.selectEdoc", docNo);
	}
	
	

	// 상신한 결재문서 수정
	public int updateEdoc(EdocDto edoc) {
		return sqlSessionTemplate.update("edocMapper.updateEdoc", edoc);
	}
	public List<AttachDto> selectDelFile(String[] delFileNo) {
		return sqlSessionTemplate.selectList("edocMapper.selectDelFile", delFileNo);
	}

	// 상신한 결재문서 삭제
	public int deleteEdoc(int docNo) {
		return sqlSessionTemplate.delete("edocMapper.deleteEdoc", docNo);
	}
	
	// 임시저장함 조회
	public List<EdocDto> selectTempSaveApprovalList(MemberDto loginUser) {
		return sqlSessionTemplate.selectList("edocMapper.selectTempSaveApprovalList", loginUser);
	}

	// 임시저장함에서 등록
	public int updateTempSaveEdoc(EdocDto edoc) {
		return sqlSessionTemplate.update("edocMapper.updateTempSaveEdoc", edoc);
	}

	// 결재 완료함 조회
	public List<EdocDto> finishApprovalList(MemberDto loginUser) {
		return sqlSessionTemplate.selectList("edocMapper.selectFinishApprovalList", loginUser);
	}

	// 결재 대기함 조회
	public List<EdocDto> selectApprovalList(MemberDto loginUser) {
		return sqlSessionTemplate.selectList("edocMapper.selectApprovalList", loginUser);
	}

	// 첨부파일 삭제 
	public int deleteAttach(String[] delFileNo) {
		return sqlSessionTemplate.delete("edocMapper.deleteAttach", delFileNo);
	}

	public List<AttachDto> selectAllDelFile(int docNo) {
		return sqlSessionTemplate.selectList("edocMapper.selectAllDelFile", docNo);
	}

	public int deleteAllAttach(int docNo) {
		return sqlSessionTemplate.delete("edocMapper.deleteAllAttach", docNo);
	}

	public List<VacationTypeDto> selectVacType() {
		return sqlSessionTemplate.selectList("edocMapper.selectVacType");
	}

	public int insertVacation(VacationDto vac) {
		return sqlSessionTemplate.insert("edocMapper.insertVacation",vac);
	}

	public int updateVacation(VacationDto vac) {
		return sqlSessionTemplate.update("edocMapper.updateVacation",vac);
	}

	// 메인페이지 결재상신함 조회
	public List<EdocDto> mainSelectUploadApprovalList(MemberDto loginUser) {
		return sqlSessionTemplate.selectList("edocMapper.mainSelectUploadApprovalList", loginUser);
	}

	// 자주쓰는 결재선 조회
	public List<SaveApprovalDto> selectMyApproval(MemberDto loginUser) {
		return sqlSessionTemplate.selectList("edocMapper.selectMyApproval", loginUser);
	}
	
	// 자주쓰는 결재선 등록
	public int insertMyapproval(SaveApprovalDto sa) {
		return sqlSessionTemplate.insert("edocMapper.insertMyapproval", sa);

	
	}

	// 자주쓰는 결재선 삭제
	public int deleteMyApproval(int saNo) {
		return sqlSessionTemplate.delete("edocMapper.deleteMyApproval", saNo);
	}

	// 자주쓰는 결재선 수정
	public SaveApprovalDto approvalDetail(String saNo) {
		return sqlSessionTemplate.selectOne("edocMapper.approvalDetail", saNo);
	}

	// 결재상신_결재선, 참조선 등록
	public int insertEdocApproval(List<EdocApprovalDto> ealist, List<RefDto> reflist ) {
		int result1 = 0;
		int result2 = 1;
		
		for(EdocApprovalDto ea : ealist) {
			result1 = sqlSessionTemplate.insert("edocMapper.insertEdocEa", ea);
		}
		
		if(reflist != null && !reflist.isEmpty())
			for(RefDto ref : reflist) {
				result2 = sqlSessionTemplate.insert("edocMapper.insertEdocRef", ref);
			}
		
		return result1 * result2;
	}

	// 상세조회_결재선
	public List<EdocApprovalDto> selectEdocEa(int no) {
		return sqlSessionTemplate.selectList("edocMapper.selectEdocEa", no);
	}

	// 상세조회_참조자목록
	public List<RefDto> selectEdocRef(int no) {
		return sqlSessionTemplate.selectList("edocMapper.selectEdocRef", no);
	}

	// 결재버튼 클릭시 status값 update
	public int ajaxUpdateApBtn(int docNo, MemberDto loginUser) {
		int result1 = sqlSessionTemplate.update("edocMapper.updateApBtnEdoc", docNo);
		loginUser.setUserNo(docNo);
		int result2 = sqlSessionTemplate.update("edocMapper.updateApBtnEa", loginUser);
		return result1 * result2;
	}

	// 결재버튼 클릭 update 성공시 sign이미지 가져오기
	public AttachDto ajaxSelectApBtn(int docNo, MemberDto loginUser) {
		loginUser.setUserNo(docNo);
		return sqlSessionTemplate.selectOne("edocMapper.selectApBtn", loginUser);
	}

	/* 상신한 결재목록 조회_사인 목록
	public List<AttachDto> selectSignAtList() {
		return sqlSessionTemplate.selectList("edocMapper.selectSignAtList");
	}
	*/

	// 반려버튼 클릭시 status값 update
	public int ajaxUpdateRejBtn(int docNo, MemberDto loginUser) {
		int result1 = sqlSessionTemplate.update("edocMapper.ajaxUpdateRejEdoc", docNo);
		loginUser.setUserNo(docNo);
		int result2 = sqlSessionTemplate.update("edocMapper.ajaxUpdateRejEa", loginUser);
		return result1 * result2;
	}

	// 결재버튼_사인이미지없을경우
	public EdocApprovalDto selectEa(int docNo, MemberDto loginUser) {
		loginUser.setUserNo(docNo);
		return sqlSessionTemplate.selectOne("edocMapper.selectEa", loginUser);
	}

	// 결재수정_결재라인, 참조자 등록
	public int modifyInsertEdocApproval(List<EdocApprovalDto> ealist, List<RefDto> reflist) {
		int result1 = 0;
		int result2 = 1;
		
		for(EdocApprovalDto ea : ealist) {
			result1 = sqlSessionTemplate.insert("edocMapper.modifyInsertEdocEa", ea);
		}
		for(RefDto ref : reflist) {
			result2 = sqlSessionTemplate.insert("edocMapper.modifyInsertEdocRef", ref);
		}
		
		return result1 * result2;
	}

	// 결재수정페이지 접속시 결재선 삭제 
	public int deleteEdocApproval(int no) {
		int result1 = sqlSessionTemplate.delete("edocMapper.deleteEdocApproval", no);
		int result2 = sqlSessionTemplate.delete("edocMapper.deleteEdocRef", no);
		return result1 * result2;
	}

	

	

	

	
	

}
