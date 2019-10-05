package net.mypofol.support;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import net.mypofol.mapper.BoardMapper;
import net.mypofol.model.BoardVO;
import net.mypofol.model.Pagination;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTest {

	@Autowired
	private BoardMapper mapper;

	
	/*
	 * @Test public void getListTest() {
	 * 
	 * mapper.getList().forEach(board -> log.info(board)); }
	 */	
	
	/*
	 * @Test public void insertTest() { BoardVO board = new BoardVO();
	 * board.setTitle("test 제목2"); board.setContent("test 내용2");
	 * board.setWriter("test작성자2");
	 * 
	 * mapper.insert(board); log.info(board); }
	 */	
	
	
	/*
	 * @Test public void readTest() { BoardVO board = mapper.read(1L);
	 * log.info(board); }
	 */	
	
	
	/*
	 * @Test public void deleteTest() { int deleteCount = mapper.delete(10L);
	 * log.info("isDelete? : " + deleteCount); }
	 */

	
	/*
	 * @Test public void updateTest() { BoardVO board = new BoardVO();
	 * board.setTitle("수정하는 제목"); board.setContent("수정하는 내용");
	 * board.setWriter("수정하는 작성자"); board.setBno(3L); int updateCount =
	 * mapper.update(board); log.info("isUpdate? : " + updateCount); }
	 */
	
	/*
	 * @Test public void pagingTest() { Pagination pagi = new Pagination();
	 * List<BoardVO> list = mapper.readListWithPaging(pagi); list.forEach(board ->
	 * log.info(board)); }
	 */
	
	/*
	 * @Test public void pagingTest() {
	 * 
	 * Pagination pagi = new Pagination(); pagi.setPageNum(2); pagi.setAmount(10);
	 * List<BoardVO> list = mapper.readListWithPaging(pagi); list.forEach(board ->
	 * log.info(board));
	 * 
	 * }
	 */
	
	@Test
	public void searchingTest() {
		Pagination pagi = new Pagination();
		pagi.setKeyword("테스트");
		pagi.setType("TC");
		
		List<BoardVO> list = mapper.readListWithPaging(pagi);
		list.forEach(board -> log.info(board));
	}
}
