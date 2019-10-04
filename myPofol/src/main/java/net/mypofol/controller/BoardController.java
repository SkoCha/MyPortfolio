package net.mypofol.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.mypofol.model.BoardVO;
import net.mypofol.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Autowired
	private BoardService service;

	@RequestMapping("/list")
	public void list(Model model) {
		model.addAttribute("list", service.readList());
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
	public void read(@RequestParam("bno") Long bno, Model model) {
		model.addAttribute("board", service.read(bno));
	}
	
	@RequestMapping(value = "/modify", method = {RequestMethod.POST})
	public String modify(BoardVO board, RedirectAttributes reAttr) {
		if(service.modify(board)) {
			reAttr.addFlashAttribute("result", "true");
		}
		return "redirect:/board/list";
	}
	
	@RequestMapping(value = "/remove", method = {RequestMethod.POST})
	public String remove(Long bno, RedirectAttributes reAttr) {
		if(service.remove(bno)) {
			reAttr.addFlashAttribute("result", "true");
		}
		return "redirect:/board/list";
	}
}
