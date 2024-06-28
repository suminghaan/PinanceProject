package com.uys2j.pinance.dto;


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
public class ReplyDto {
	
	private int replyNo;
	private int postNo;
	private String replyContent;
	private String status;
	private int replyUpstair;
	private DefaultDto defaultDto;
	
	private String userName;
}
