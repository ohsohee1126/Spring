package com.example.controller;

import java.io.File;
import java.nio.file.Files;

import javax.annotation.Resource;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FileController {
	@Resource(name = "uploadPath")
	String path;

	// 이미지파일 브라우저에 출력
	@RequestMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> display(String fileName) throws Exception {
		ResponseEntity<byte[]> result = null;
		// display fileName이 있는 경우
		if (!fileName.equals("")) {
			File file = new File(path + fileName);
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}
		return result;
	}
}
