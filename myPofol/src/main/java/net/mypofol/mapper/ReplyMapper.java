package net.mypofol.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import net.mypofol.model.Pagination;
import net.mypofol.model.ReplyVO;

public interface ReplyMapper {

	/* t_reply 테이블에 댓글 등록 */
	public int create(ReplyVO reply);
	
	/* t_board의 bno를 참조하여 해당 게시글의 모든 댓글 조회 */
	public ReplyVO read(Long bno);
	
	/* 페이지 처리를 위한 객체와 댓글 목록을 가져올 해당 게시물의 bno 칼럼을 @Param을 이용하여 다중 파라미터 처리 */
	public List<ReplyVO> readListWithPaging(@Param("pagi") Pagination pagi, @Param("bno") Long bno);

	/* t_reply 테이블의 해당하는 rno 칼럼에 대한 튜플 삭제 */
	public int delete(Long rno);

	/* t_reply 테이블의 해당 ReplyVO 객체 수정 */ 
	public int update(ReplyVO reply);
}
