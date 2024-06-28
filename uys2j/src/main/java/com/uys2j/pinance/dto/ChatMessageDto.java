package com.uys2j.pinance.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class ChatMessageDto {
  private int messageNo;
  private String roomId;
  private String writer;
  private String userId;
  private String message;
  private String type;
  private String sendTime;
  private String profilePath;

}
