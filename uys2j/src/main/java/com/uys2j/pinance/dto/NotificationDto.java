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
public class NotificationDto {
	private int notificationNo;
	private String notificationContent;
	private String notificationIcon;
	private String refType;
	private String refAddress;
	private String status;
	private DefaultDto defaultDto;
}
