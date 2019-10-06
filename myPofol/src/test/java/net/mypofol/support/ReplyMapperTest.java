package net.mypofol.support;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import net.mypofol.mapper.BoardMapper;
import net.mypofol.mapper.ReplyMapper;
import net.mypofol.model.BoardVO;
import net.mypofol.model.Pagination;
import net.mypofol.model.ReplyVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTest {

	@Autowired
	private ReplyMapper mapper;

	/*
	 * @Test public void mapperTest() { log.info(mapper); }
	 */
	
	/*
	 * @Test public void createTest() {
	 * 
	 * Long[] bnoArr = {149L,148L,147L,146L,145L};
	 * 
	 * IntStream.rangeClosed(1, 10).forEach(i -> {
	 * 
	 * ReplyVO re = new ReplyVO(); re.setBno(bnoArr[i % 5]); re.setReply("Reply 테스트"
	 * + i); re.setWriter("Tester" + i); mapper.create(re); });
	 * 
	 * }
	 */
	
	/*
	 * @Test public void readTest() { Long num = 3L; ReplyVO re = mapper.read(num);
	 * log.info(re); }
	 */
	
	/*
	 * @Test public void deleteTest() { int num = 2; int result =
	 * mapper.delete(num); log.info(result); }
	 */
	
	/*
	 * @Test public void updateTest() { ReplyVO re = mapper.read(3L);
	 * re.setReply("JUnit ReplyMapper 테스트"); int result = mapper.update(re);
	 * log.info(result); }
	 */
	
	@Test
	public void readListPagingTest() {
		Pagination pagi = new Pagination();
		Long[] bnoArr = {149L,148L,147L,146L,145L};
		List<ReplyVO> res = mapper.readListWithPaging(pagi, bnoArr[0]);
		res.forEach(reply -> log.info(reply));
	}
	
}
