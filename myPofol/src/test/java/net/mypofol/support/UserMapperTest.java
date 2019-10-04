package net.mypofol.support;

import java.util.ArrayList;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import net.mypofol.mapper.UserMapper;
import net.mypofol.model.UserVO;
import net.mypofol.model.UserVOList;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserMapperTest {

	@Autowired
	private UserMapper mapper;	
	
	@Test
	public void createUserTest() {		
		UserVO user = new UserVO();
		user.setId("test2");
		user.setName("testName");
		user.setPassword("1111");
		user.setEmail("test2@email.com");
		
		mapper.createUser(user);
		mapper.getList().forEach(users -> log.info(user));
	}
}
