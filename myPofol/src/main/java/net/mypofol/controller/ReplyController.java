package net.mypofol.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import net.mypofol.model.Pagination;
import net.mypofol.model.ReplyVO;
import net.mypofol.service.IReplyService;

@RestController
@RequestMapping("/replies/")
public class ReplyController {

	@Autowired
	private IReplyService service;
	
//	json 타입의 데이터를 브라우저로부터 받아서 ReplyVO 객체 타입으로 DB에 insert하고 결과를 String으로 반환
//	삼항 연산자를 이용해서 쿼리 실행 반환 결과가 1이면 브라우저에 200, 아니면 500 상태 반환 
	@RequestMapping(value = "/new", method = {RequestMethod.POST},
				consumes = "application/json",
				produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO reply) {
		
		int count = service.register(reply);		
		return count == 1 ? new ResponseEntity<String>("success", HttpStatus.OK)
							: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
//	특정 게시물의 댓글 리스트 조회
	@RequestMapping(value = "/pages/{bno}/{page}", 
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("bno") Long bno, @PathVariable("page") int page) {
		
		Pagination pagi = new Pagination(page, 10);		// 페이징처리, 페이지 당 댓글 수는 10개로 Set
		return new ResponseEntity<List<ReplyVO>>(service.getList(pagi, bno), HttpStatus.OK);
	}
	
//	reply 테이블의 rno 칼럼으로 특정 댓글 조회
	@RequestMapping(value = "/{rno}",
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {
		
		return new ResponseEntity<ReplyVO>(service.get(rno), HttpStatus.OK);
	}
	
//	reply 테이블의 rno 칼럼으로 특정 댓글 삭제, DeleteMapping
	@RequestMapping(value = "/{rno}", method = {RequestMethod.DELETE}, produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno) {
		
		return service.remove(rno) == 1 ? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
//	json 타입의 데이터를 받아서(@RequestBody) 특정 댓글 수정, Put 방식 또는 Patch 방식
	@RequestMapping(value = "/{rno}", method = {RequestMethod.PUT, RequestMethod.PATCH},
				consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@PathVariable("rno") Long rno, @RequestBody ReplyVO reply) {
		
		reply.setRno(rno);
		return service.modify(reply) == 1 ? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
