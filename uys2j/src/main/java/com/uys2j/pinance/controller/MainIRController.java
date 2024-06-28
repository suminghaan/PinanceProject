package com.uys2j.pinance.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainIRController { 
	
	String Ikey = "ES7MNKIU3V0TWHSGD3EB";
	
	
	@ResponseBody
	@GetMapping(value="/main/IR.do", produces = "application/json; characterset=utf-8;")
	public String IR(String location) throws IOException { // 금리
		LocalDate currentDate = LocalDate.now();
		LocalDate DateAgo = currentDate.minusMonths(20);
		
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMM");
	    String formattedDate = currentDate.format(formatter);
	    String formattedDateAgo = DateAgo.format(formatter);
	    
		String url = "https://ecos.bok.or.kr/api/StatisticSearch/" + Ikey + "/json/kr/1/21/722Y001/M/" + formattedDateAgo + "/" + formattedDate + "/0101000";
		URL requestUrl = new URL(url);
		HttpURLConnection urlConnection = (HttpURLConnection)requestUrl.openConnection(); 
		urlConnection.setRequestMethod("GET");
		  
		BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
		  
		String responseText = "";
		    String line;
		    while((line = br.readLine()) != null) {
		       responseText += line;
		    }
		      
		    br.close();
		    urlConnection.disconnect();
		    
		    return responseText;
		      
	}
	
	@ResponseBody
	@GetMapping(value="/main/exchange.do", produces = "application/json; ")
	public Map<String, Object> exchange(String location, Model model) throws IOException, ParseException { // 환율
	//public String exchange(String location, Model model) throws IOException { // 환율
		LocalDate currentDate = LocalDate.now();
		LocalDate DateAgo = currentDate.minusDays(15);
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
	    String formattedDate = currentDate.format(formatter);
	    String formattedDateAgo = DateAgo.format(formatter);
	    
	    String[] urls = {
	        "https://ecos.bok.or.kr/api/StatisticSearch/" + Ikey + "/json/kr/1/16/731Y001/D/" + formattedDateAgo + "/" + formattedDate + "/0000001",
	        "https://ecos.bok.or.kr/api/StatisticSearch/" + Ikey + "/json/kr/1/16/731Y001/D/" + formattedDateAgo + "/" + formattedDate + "/0000053",
	        "https://ecos.bok.or.kr/api/StatisticSearch/" + Ikey + "/json/kr/1/16/731Y001/D/" + formattedDateAgo + "/" + formattedDate + "/0000002",
	        "https://ecos.bok.or.kr/api/StatisticSearch/" + Ikey + "/json/kr/1/16/731Y001/D/" + formattedDateAgo + "/" + formattedDate + "/0000003"
        };
	    
	    Map<String, Object> map = new HashMap<>();
	    
	    for (int i = 0; i < urls.length; i++) {
	        URL requestUrl = new URL(urls[i]);
	        HttpURLConnection urlConnection = (HttpURLConnection) requestUrl.openConnection();
	        urlConnection.setRequestMethod("GET");

	        BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
	        String line;
	        while ((line = br.readLine()) != null) {
	        	map.put(getCurrencyName(i), new org.json.simple.parser.JSONParser().parse(line));
	        }
	        
	        br.close();
	        urlConnection.disconnect();
	    }
	    
	    return map;
	}
	
	private String getCurrencyName(int index) {
	    switch (index) {
	        case 0:
	            return "dollar";
	        case 1:
	            return "yen";
	        case 2:
	            return "yuan";
	        case 3:
	            return "euro";
	        default:
	            return "";
	    }
	}

}
