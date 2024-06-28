package com.uys2j.pinance.dto;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.WebSocketSession;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatRoomDto {
  private String roomId;
  private String roomName;  
  private String userId;
  private String targetId;
  private String targetName;
  private String status;
  private List<WebSocketSession> sessions = new ArrayList<>();
}
