package com.uys2j.pinance.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class AttachDto {
	private int fileNo;
	private String filesystemName;
	private String originalName;
	private String filePath;
	private Date uploadDate;
	private int fileLevel;
	private String fileStatus;
	private int refNo;
	private String refType;
	private String seqType;
	private String regId;
	
	private int aprank;
	private DefaultDto defaultDto;

}

