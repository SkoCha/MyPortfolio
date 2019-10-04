package net.mypofol.support;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import net.mypofol.model.BoardVO;
import net.mypofol.service.BoardService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTest {

	@Autowired
	private BoardService service;

	/*
	 * @Test public void serviceTest() { log.info(service); assertNotNull(service);
	 * }
	 */

	/*
	 * @Test public void registerTest() { BoardVO testBoard = new BoardVO();
	 * testBoard.setTitle("테스트에서 작성하는 제목"); testBoard.setContent("테스트에서 작성하는 내용");
	 * testBoard.setWriter("Tester"); service.register(testBoard);
	 * log.info(testBoard.getBno() + "번 글 생성."); }
	 */

	/*
	 * @Test public void readTest() { log.info(service.read(3L));
	 * 
	 * }
	 */

	/*
	 * @Test public void updateTest() { BoardVO testBoard = service.read(1L); if
	 * (testBoard == null) return; testBoard.setTitle("제목 수정 테스트");
	 * log.info("isModify? : " + service.modify(testBoard));
	 * 
	 * }
	 */
	
	@Test
	public void deleteTest() {
		boolean isRemove = service.remove(2L);
		log.info("isRemove? : " + isRemove);
	}
}
