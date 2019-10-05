package net.mypofol.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.mypofol.model.BoardVO;
import net.mypofol.model.PageDTO;
import net.mypofol.model.Pagination;
import net.mypofol.service.IBoardService;

@Controller
@RequestMapping("/board/*")
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
		if(service.remove(bno)) {
			reAttr.addFlashAttribute("result", "true");
		}
		reAttr.addAttribute("pageNum", pagi.getPageNum());
		reAttr.addAttribute("amount", pagi.getAmount());
		reAttr.addAttribute("type", pagi.getType());
		reAttr.addAttribute("keyword", pagi.getKeyword());
		
		return "redirect:/board/list";
	}
}
