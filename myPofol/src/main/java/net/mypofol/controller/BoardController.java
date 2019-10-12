package net.mypofol.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;
import net.mypofol.model.BoardVO;
import net.mypofol.model.PageDTO;
import net.mypofol.model.Pagination;
import net.mypofol.model.UploadVO;
import net.mypofol.service.IBoardService;

@Controller
@RequestMapping("/board/*")
@Log4j
public class BoardController {

	@Autowired
	private IBoardService service;

	@RequestMapping("/list")
	public void list(Pagination pagi, Model model) {
		int total = service.readTotal(pagi);
		model.addAttribute("list", service.readList(pagi));
		model.addAttribute("pagination", new PageDTO(pagi, total));
	}
	
	@RequestMapping("/register")
	public void register() {	
		
	}
	
	@RequestMapping(value = "/register", method = {RequestMethod.POST})
	public String register(BoardVO board, RedirectAttributes reAttr) {
//		log.info("#############################################");
//		log.info("register : " + board);
//		if(board.getUploadList() != null) {
//			board.getUploadList().forEach(upload -> log.info(upload));
//		}
//		log.info("#############################################");
		service.register(board);
		reAttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
	}
	
	@RequestMapping({"/read", "/modify"})
	public void read(@RequestParam("bno") Long bno, @ModelAttribute("pagi") Pagination pagi, Model model) {
		model.addAttribute("board", service.read(bno));
	}
	
	@RequestMapping(value = "/modify", method = {RequestMethod.POST})
	public String modify(BoardVO board, @ModelAttribute("pagi") Pagination pagi, RedirectAttributes reAttr) {
		if(service.modify(board)) {
			reAttr.addFlashAttribute("result", "true");
		}
		reAttr.addAttribute("pageNum", pagi.getPageNum());
		reAttr.addAttribute("amount", pagi.getAmount());
		reAttr.addAttribute("type", pagi.getType());
		reAttr.addAttribute("keyword", pagi.getKeyword());
		
		return "redirect:/board/list";
	}
	
	@RequestMapping(value = "/remove", method = {RequestMethod.POST})
	public String remove(Long bno, @ModelAttribute("pagi") Pagination pagi, RedirectAttributes reAttr) {
		
		List<UploadVO> uploadList = service.getUploadList(bno);
		if(service.remove(bno)) {
			deleteFiles(uploadList);
			reAttr.addFlashAttribute("result", "true");
		}
		
		return "redirect:/board/list" + pagi.getListLink();
	}
	
	@RequestMapping(value = "/getUploadList", method = {RequestMethod.GET}, produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<List<UploadVO>> getUploadList(Long bno) {
		
		return new ResponseEntity<List<UploadVO>>(service.getUploadList(bno), HttpStatus.OK);
	}
	
	private void deleteFiles(List<UploadVO> uploadList) {
		
		if(uploadList == null || uploadList.size() == 0) {
			return;
		}
		
		uploadList.forEach(upload -> {
			
			try {
				Path file = Paths.get(
						"C:\\upload\\" + upload.getUploadPath() 
						+ "\\" + upload.getUuid()
						+ "_" + upload.getFileName());
				
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbnail = Paths.get("C:\\upload\\" + upload.getUploadPath() 
						+ "\\s_" + upload.getUuid()
						+ "_" + upload.getFileName());
					
					Files.delete(thumbnail);
				}
				
			} catch(Exception e) {
				log.error("Delete error : " + e.getMessage());
			}
			
		});
		
	}
	
}
