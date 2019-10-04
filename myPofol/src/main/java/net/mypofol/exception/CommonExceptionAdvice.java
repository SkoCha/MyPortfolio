package net.mypofol.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.experimental.ExtensionMethod;
import lombok.extern.log4j.Log4j;

@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {

	/*
	 * @ExceptionHandler(NoHandlerFoundException.class)
	 * 
	 * @ResponseStatus(HttpStatus.NOT_FOUND) // 404 Error Page 처리 public String
	 * notFoundPage(NoHandlerFoundException e) { return "error404"; }
	 */
}
