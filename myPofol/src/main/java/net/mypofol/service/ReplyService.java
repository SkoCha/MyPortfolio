package net.mypofol.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import net.mypofol.mapper.ReplyMapper;
import net.mypofol.model.Pagination;
import net.mypofol.model.ReplyVO;

@Service
@Log4j
public class ReplyService implements IReplyService{

	@Autowired
	private ReplyMapper mapper;
	
	@Override
	public int register(ReplyVO reply) {
		log.info("@ReplyMapper.register");
		return mapper.create(reply);
	}

	@Override
	public ReplyVO get(Long bno) {
		log.info("@ReplyMapper.get : " + bno);
		return mapper.read(bno);
	}

	@Override
	public int modify(ReplyVO reply) {
		log.info("@ReplyMapper.modify");
		return mapper.update(reply);
	}

	@Override
	public int remove(Long rno) {
		log.info("@ReplyMapper.remove");
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Pagination pagi, Long bno) {
		log.info("@ReplyMapper.getList By Bno : " + bno);
		return mapper.readListWithPaging(pagi, bno);
	}

	
	
}
