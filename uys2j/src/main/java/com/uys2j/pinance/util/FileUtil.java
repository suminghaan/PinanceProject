package com.uys2j.pinance.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.mock.web.MockMultipartFile;

@Component
public class FileUtil {
	
	public Map<String, String> fileUpload(MultipartFile uploadFile, String folderName){
		
		// 전달된 파일 업로드 처리 
		// 1) 업로드시킬 폴더 (외부경로 : /upload/profile|board/yyyy/MM/dd)
		String filePath = "/upload/" + folderName + new SimpleDateFormat("/yyyy/MM/dd").format(new Date());
		
		File filePathDir = new File(filePath);
		if(!filePathDir.exists()) {
			filePathDir.mkdirs();
		}
		
		// 2) 파일명 수정 작업 (랜덤값.기존확장자)
		String originalName = uploadFile.getOriginalFilename();
		String ext = originalName.endsWith(".tar.gz") ? ".tar.gz" 
													  : originalName.substring(originalName.lastIndexOf("."));
		String filesystemName = UUID.randomUUID().toString().replace("-", "") + ext;
		
		// 3) 전달된 첨부파일을 1번과정의 폴더에 2번과정의 파일명으로 변환처리해서 업로드 
		try {
			uploadFile.transferTo(new File(filePathDir, filesystemName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		// 4) db에 기록시 필요한 데이터 다시 반환해주기 (Map 담아서)
		Map<String, String> map = new HashMap<>();
		map.put("filePath", filePath);
		map.put("originalName", originalName);
		map.put("filesystemName", filesystemName);
		
		return map;
		
	}
	
	public MultipartFile createMultipartFile(File file, String contentType) throws IOException {
	    Path path = file.toPath();
	    byte[] content = Files.readAllBytes(path);
	    String filename = file.getName();

	    return new MockMultipartFile("file", filename, contentType, content);
	}
	
	public void fileDownload(String filePath, String originName, HttpServletResponse response) throws IOException {
		File f = new File(filePath, originName);
		// file 다운로드 설정
		response.setContentType("application/download");
		response.setContentLength((int)f.length());
		response.setHeader("Content-disposition", "attachment;filename=\"" + originName + "\"");
		// response 객체를 통해서 서버로부터 파일 다운로드
		OutputStream os = response.getOutputStream();
		// 파일 입력 객체 생성
		FileInputStream fis = new FileInputStream(f);
		FileCopyUtils.copy(fis, os);
		fis.close();
		os.close();
	}

}
