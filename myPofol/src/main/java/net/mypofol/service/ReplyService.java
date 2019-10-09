package net.mypofol.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;
import net.mypofol.mapper.BoardMapper;
import net.mypofol.mapper.ReplyMapper;
import net.mypofol.model.Pagination;
import net.mypofol.model.ReplyPageDTO;
import net.mypofol.model.ReplyVO;

@Service
@Log4j
public class ReplyService implements IReplyService{

	@Autowired
	private ReplyMapper mapper;
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Transactional
	@Override
	public int register(ReplyVO reply) {
		log.info("@ReplyMapper.register");
		boardMapper.updateReplyCnt(reply.getBno(), 1);
		return mapper.create(reply);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("@ReplyMapper.get : " + rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO reply) {
		log.info("@ReplyMapper.modify");
		return mapper.update(reply);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("@ReplyMapper.remove");
		ReplyVO reply = mapper.read(rno);
		boardMapper.updateReplyCnt(reply.getBno(), -1);
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Pagination pagi, Long bno) {
		log.info("@ReplyMapper.getList By Bno : " + bno);
		return mapper.readListWithPaging(pagi, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Pagination pagi, Long bno) {
		return new ReplyPageDTO(mapper.readCountByBno(bno), mapper.readListWithPaging(pagi, bno));
	}

	
	
}
