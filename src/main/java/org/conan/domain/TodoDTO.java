package org.conan.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class TodoDTO {
	private String title;
	
	
//	@InitBinder
//	public void initBinder(WebDataBinder binder) {
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//		binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat,false));
//	} // 컨트롤러의 이닛바인더와 같은 기능 
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date dueDate;
}
