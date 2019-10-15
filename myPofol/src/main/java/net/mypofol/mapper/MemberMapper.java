package net.mypofol.mapper;

import org.apache.ibatis.annotations.Param;

import net.mypofol.model.AuthVO;
import net.mypofol.model.MemberVO;

public interface MemberMapper {

	/* Member 테이블의 userid 칼럼으로 해당 튜플 Select */
	public MemberVO read(String userid);
	
	public void insertMember(MemberVO member);	

}
