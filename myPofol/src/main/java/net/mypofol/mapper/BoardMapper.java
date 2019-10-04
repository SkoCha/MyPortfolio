package net.mypofol.mapper;

import java.util.List;

import net.mypofol.model.BoardVO;

public interface BoardMapper {

	/* t_board 테이블 조회 */
	public List<BoardVO> readList();

	/* t_board 테이블에서 튜플 조회 */
	public BoardVO read(Long bno);

	/* t_board 테이블에 튜플 삽입 */
	public void insert(BoardVO board);

	/* t_board 테이블에서 bno 칼럼 조회 후 해당 튜플 조회 */
	public void insertBySelectKey(BoardVO board);

	/* t_board 테이블에서 해당 칼럼 삭제 */
	public int delete(Long bno);
	
	/* t_board 테이블에서 해당 칼럼 수정 */
	public int update(BoardVO board);
}
