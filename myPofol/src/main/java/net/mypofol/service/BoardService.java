package net.mypofol.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import net.mypofol.mapper.BoardMapper;
import net.mypofol.model.BoardVO;
import net.mypofol.model.Pagination;

@Service
@Log4j
public class BoardService implements IBoardService {

	@Autowired
	private BoardMapper mapper;

	/* 파라미터로 받은 board를 게시글로 등록 */
	@Override
	public void register(BoardVO board) {
		log.info("@BoardService.register : " + board);
		mapper.insertBySelectKey(board);
	}

	/* bno 칼럼을 파라미터로 받아서 해당 번호 튜플 조회 */ 
	@Override
	public BoardVO read(Long bno) {
		log.info("@BoardService.read : " + bno);
		return mapper.read(bno);		
	}

	@Override
	public List<BoardVO> readList(Pagination pagi) {
		log.info("@BoardService.readList");
		return mapper.readListWithPaging(pagi);
	}

	/* 파라미터로 받은 board 수정 */
	@Override
	public boolean modify(BoardVO board) {
		log.info("@BoardService.modify + " + board);
		return mapper.update(board) == 1;
	}

	/* 해당 번호 튜플 삭제 */
	@Override
	public boolean remove(Long bno) {
		log.info("@BoardService.remove + " + bno);
		return mapper.delete(bno) == 1;
	}

	/* 전체 게시글 개수 리턴 */
	@Override
	public int readTotal(Pagination pagi) {
		log.info("@BoardService.readTotalCount");
		return mapper.readTotalCount(pagi);
	}

}
