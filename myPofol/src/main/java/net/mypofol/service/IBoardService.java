package net.mypofol.service;

import java.util.List;

import net.mypofol.model.BoardVO;

public interface IBoardService {
	
	public void register(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public List<BoardVO> readList();
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	
	
	
}
