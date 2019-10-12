package net.mypofol.service;

import java.util.List;

import javax.swing.border.Border;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;
import net.mypofol.mapper.BoardMapper;
import net.mypofol.mapper.UploadMapper;
import net.mypofol.model.BoardVO;
import net.mypofol.model.Pagination;
import net.mypofol.model.UploadVO;

@Service
@Log4j
public class BoardService implements IBoardService {

	@Autowired
	private BoardMapper mapper;
	
	@Autowired
	private UploadMapper uploadMapper;

	/* 파라미터로 받은 board를 게시글로 등록, 첨부 파일과 같이 Insert 할 것이므로 트랜잭션 처리 */
	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("@BoardService.register : " + board);
		mapper.insertBySelectKey(board);
		
		if(board.getUploadList() == null || board.getUploadList().size() <= 0) {
			return;
		}
		
		board.getUploadList().forEach(upload ->{
			upload.setBno(board.getBno());
			uploadMapper.insert(upload);
		});
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

	/* 파라미터로 받은 board 수정, 첨부 파일의 삭제가 이루어 진다면 모든 첨부파일 삭제 후 나머지 파일 재삽입 */
	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		log.info("@BoardService.modify + " + board);
		uploadMapper.deleteAll(board.getBno());
		boolean modifyResult = mapper.update(board) == 1;
		
		if(modifyResult && board.getUploadList() != null && board.getUploadList().size() > 0) {
			
			board.getUploadList().forEach(upload -> {
				upload.setBno(board.getBno());
				uploadMapper.insert(upload);
			});
			
		}
		return modifyResult;
	}

	/* 해당 번호 튜플 삭제, t_upload 테이블의 튜플도 삭제 (트랜잭션) */
	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("@BoardService.remove + " + bno);
		uploadMapper.deleteAll(bno);
		return mapper.delete(bno) == 1;
	}

	/* 전체 게시글 개수 리턴 */
	@Override
	public int readTotal(Pagination pagi) {
		log.info("@BoardService.readTotalCount");
		return mapper.readTotalCount(pagi);
	}

	/* bno에 해당하는 게시물의 첨부 파일 목록 리턴 */
	@Override
	public List<UploadVO> getUploadList(Long bno) {
		log.info("@BoradService.getUploadList By : " + bno);
		return uploadMapper.selectByBno(bno);
	}
	

}
