package com.uys2j.pinance.dto;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

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
public class BoardDto {
	
	private int boardNo;
	private String boardType;
	private String boardName;
	private String status;
	private DefaultDto defaultDto;
	private int postCount;
	private String defaultRole;
	
	private String userName;
	private List<String> selectedMembers;
    private String members = "[]";
    
    public List<String> getSelectedMembers() {
        if (this.members == null || this.members.isEmpty()) {
            return new ArrayList<>();
        }
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.readValue(this.members, new TypeReference<List<String>>() {});
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public void setSelectedMembers(List<String> selectedMembers) {
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            this.members = objectMapper.writeValueAsString(selectedMembers);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
    }
	

}
