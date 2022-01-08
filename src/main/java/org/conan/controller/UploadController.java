package org.conan.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.conan.domain.AttachFileDTO;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
@AllArgsConstructor
public class UploadController {
	
	@GetMapping("/uploadForm")	// uploadForm.jsp로 찾아감
	public void uploadForm() {
		log.info("upload form");
	}
	
	@PostMapping("/uploadFormAction")		// post방식으로 들어옴
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		String uploadFolder = "c:/upload";
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("uploadPath : " + uploadPath);
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		for(MultipartFile multipartFile:uploadFile) {
			log.info("------------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			File saveFile = new File(uploadPath, multipartFile.getOriginalFilename());
			try {
				multipartFile.transferTo(saveFile);
			}catch(Exception e) {
				log.error(e.getMessage());
			}
		}
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax");
	}
	
	@PostMapping(value="/uploadAjaxAction", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	// Ajax를 이용하여 uploadAjax.jsp에서 script로 post방식으로 들어옴
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		String uploadFolder="c:/upload";
		List<AttachFileDTO> list = new ArrayList<>();
		
		File uploadPath = new File(uploadFolder, getFolder());		// upload경로에 폴더를 만들어서 생성
		log.info("uploadPath : " + uploadPath);
		if(uploadPath.exists() == false) {					// uploadPath 폴더가 이미 있나 없나 확인
			uploadPath.mkdirs();
		}
		for(MultipartFile multipartFile:uploadFile) {			// 선택된 모든 파일 탐색
			log.info("------------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			AttachFileDTO attachDTO = new AttachFileDTO();
			UUID uuid = UUID.randomUUID();
			String uploadFileName = multipartFile.getOriginalFilename();		// 파일 이름 설정
			attachDTO.setFileName(uploadFileName);
			uploadFileName=uuid.toString()+"_"+uploadFileName;
			// 중복처리를 위해 uuid를 랜덤으로 적용하여 파일이름을 고유로 지정
			File saveFile = new File(uploadPath, uploadFileName);
			// 저장할 파일을 폴더경로에 의해 넣어준다
			try {
				multipartFile.transferTo(saveFile);	// 파일을 이동시킴
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(getFolder());
				log.info(checkImageType(saveFile)+"-----------------------");
				if(checkImageType(saveFile)) {
					attachDTO.setImage(true);
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					log.info(thumbnail + "==================");
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				list.add(attachDTO);
				log.info("attachDTO : " + attachDTO);
			}catch(Exception e) {
				log.error(e.getMessage());
			}
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	private String getFolder() {			//오늘 날짜로 폴더를 생성하는 함수
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			log.info(Files.probeContentType(file.toPath()) + "이미지 맞나요?");
			return contentType.startsWith("image");
		}catch(IOException e) {
		e.printStackTrace();
		log.info("이미지 아닌가요????");
		}
		log.info("여기도 찍히나요????");
		return false;
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("fileName : " + fileName);
		File file = new File("c:/upload/"+fileName);
		log.info("file : " + file);
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			//적당한 MIME 타입을 헤더에 추가
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);	
		}catch(IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@GetMapping(value="/download", produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(String fileName){
		Resource resource = new FileSystemResource("c:/upload/" + fileName);
		log.info("resource : " + resource);
		if(resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		String resourceName =resource.getFilename();
		//remove UUID
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
		log.info("resourceOriginalName : "+resourceOriginalName);
		HttpHeaders headers = new HttpHeaders();
		try {
			headers.add("Content-Disposition", "attachment; fileName=" + new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1"));
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		log.info("deleteFile : " + fileName);
		File file;
		try {
			file = new File("c:/upload/"+URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			log.info(type);
			if(type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				log.info("largeFileName : " + largeFileName);
				file = new File(largeFileName);
				file.delete();
			}
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
}
