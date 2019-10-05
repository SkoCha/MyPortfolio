package net.mypofol.service;

import java.util.List;

import net.mypofol.model.BoardVO;
import net.mypofol.model.Pagination;

public interface IBoardService {
	
	public void register(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public List<BoardVO> readList(Pagination pagi);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);	
	
	public int readTotal(Pagination pagi);
}
