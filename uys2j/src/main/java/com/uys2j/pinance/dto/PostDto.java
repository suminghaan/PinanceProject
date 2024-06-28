package com.uys2j.pinance.dto;

import java.util.List;

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
public class PostDto {
	
	private int postNo;
	private int boardNo;
	private String postTitle;
	private String postContent;
	private int postCount;
	private String status;
	private DefaultDto defaultDto;
	
	private List<AttachDto> attachList;
	private String boardType;
	private String userName;

}
