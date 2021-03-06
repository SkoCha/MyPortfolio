package net.mypofol.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import net.mypofol.model.BoardVO;
import net.mypofol.model.Pagination;

public interface BoardMapper {

	/* t_board 테이블 조회 */
	public List<BoardVO> readList();

	/* t_board 테이블 페이징 조회 */
	public List<BoardVO> readListWithPaging(Pagination pagi);

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
	
	/* t_board 테이블 전체 튜플 수 리턴 */ 
	public int readTotalCount(Pagination pagi);
	
	/* t_board 테이블의 해당 칼럼에 참조되어 있는 댓글 개수를 반영할 기능 */
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int mount);
}
