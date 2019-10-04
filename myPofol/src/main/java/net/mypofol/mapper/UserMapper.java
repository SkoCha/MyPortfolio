package net.mypofol.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import net.mypofol.model.UserVO;

@Mapper
public interface UserMapper {

	public UserVO getUser();
	
	public UserVO getUserById(String id);
	
	public List<UserVO> getList();
	
	public void createUser(UserVO user);
	
	public String getCurrentTime();
	
}
