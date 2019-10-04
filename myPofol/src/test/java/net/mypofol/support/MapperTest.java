package net.mypofol.support;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import net.mypofol.mapper.UserMapper;
import net.mypofol.model.UserVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MapperTest {

	@Autowired
	private UserMapper mapper;
	
	@Autowired
	private UserVO user;
	
	@Test
	public void mapperTest() {
		log.info(mapper.getClass().getName());	
		log.info("============================");
		log.info(mapper.getCurrentTime());
		log.info("============================");
	}
}
