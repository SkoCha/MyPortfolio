package net.mypofol.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;
import net.mypofol.mapper.MemberMapper;
import net.mypofol.model.MemberVO;
import net.mypofol.service.IMemberService;

@Controller
@Log4j
public class CommonController {

	@Autowired
	private IMemberService memberService;
	
	@RequestMapping("/login")
	public void loginPage(String error, String logout, Model model) {
		
		log.info("error : " + error);
		log.info("logout : " + logout);
		
		if(error != null) {
			model.addAttribute("error", "로그인이 정상적으로 실행되지 않음");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "로그아웃");
		}
		
	}
	
	@RequestMapping("/logout")
	public void logoutGET() {
//		log.info("custom logout. bye.");
	}
	
	@RequestMapping(value = "/Logout", method = {RequestMethod.POST})
	public void logoutPOST() {
//		log.info("post custom logout");
	}
	
	@RequestMapping("/join")
	public void joinGet() {
		
	}
	
	@PreAuthorize("isAnonymous()")
	@PostMapping("/join")
	public String joinPOST(MemberVO member, Model model) {
		log.info("From join  : " + member.toString());
		memberService.joinMember(member);
		return "/login";
	}
	
	@RequestMapping("/error/accessError")
	public void accessDenied(Authentication auth, Model model) {
//		log.info("access denied : " + auth);		
	}
}
