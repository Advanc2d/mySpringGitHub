package org.conan.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import lombok.extern.log4j.Log4j;

@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {
	@ExceptionHandler(Exception.class)
	public String except(Exception ex, Model model) {
		log.error("Exception..." + ex.getMessage());
		model.addAttribute("exception",ex);
		log.error(model);
		return "/sample/error_page";	//views 안에서 처리된다. 따라서 경로설정을 해줘야한다.
	}
}
