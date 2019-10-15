package net.mypofol.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.mypofol.mapper.MemberMapper;
import net.mypofol.model.AuthVO;
import net.mypofol.model.MemberVO;

@Service
public class MemberService implements IMemberService{

	@Autowired
	private MemberMapper mapper;	
	
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public void joinMember(MemberVO member) {
		member.setUserpw(passwordEncoder.encode(member.getUserpw()));
		mapper.insertMember(member);
	}

	
}
