package net.mypofol.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {

	@GetMapping("/login")
	public void loginPage(String error, String logout, Model model) {
		
		log.info("error : " + error);
		log.info("logout : " + logout);
		
		if(error != null) {
			model.addAttribute("error", "Login error check your Account");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "Logout ok.");
		}
		
	}
	
	@GetMapping("/logout")
	public void logoutGET() {
		log.info("custom logout. bye.");
	}
	
	@PostMapping("/Logout")
	public void logoutPOST() {
		log.info("post custom logout");
	}
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("access denied : " + auth);		
		model.addAttribute("msg", "Access Denied");
	}
}
