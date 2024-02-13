package com.example.demo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

@Controller
public class Api {
	  @Value("${api.serviceKey}") // application.properties에서 serviceKey 값을 가져옴
	    private String serviceKey;

	    @GetMapping("/bookLoanBest")
	    public String getBookLoanBest(Model model) {
	        // API 호출을 위한 URL
	        String apiUrl = "http://apis.data.go.kr/6260000/BookLoanBestService/getBookLoanBest";
	        // URL에 쿼리 파라미터 추가
	        String url = apiUrl + "?serviceKey=" + serviceKey + "&numOfRows=10&pageNo=1&resultType=xml";

	        // RestTemplate을 사용하여 API 호출
	        RestTemplate restTemplate = new RestTemplate();
	        String response = restTemplate.getForObject(url, String.class);

	        // 모델에 API 응답 결과를 추가하여 JSP로 전달
	        model.addAttribute("apiResponse", response);

	        return "book/bookLoanBest"; // bookLoanBest.jsp로 forward
	    }
}
