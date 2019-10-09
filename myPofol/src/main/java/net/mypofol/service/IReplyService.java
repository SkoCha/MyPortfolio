package net.mypofol.service;

import java.util.List;

import net.mypofol.model.Pagination;
import net.mypofol.model.ReplyPageDTO;
import net.mypofol.model.ReplyVO;

public interface IReplyService {

	public int register(ReplyVO rep);
	
	public ReplyVO get(Long bno);
	
	public int modify(ReplyVO rep);
	
	public int remove(Long rno);
	
	public List<ReplyVO> getList(Pagination pagi, Long bno);
	
	public ReplyPageDTO getListPage(Pagination pagi, Long bno);
	
}
