package net.mypofol.mapper;

import java.util.List;

import net.mypofol.model.UploadVO;

public interface UploadMapper {

	public void insert(UploadVO uv);
	
	public void delete(String uuid);
	
	public void deleteAll(Long bno);
	
	public List<UploadVO> selectByBno(Long bno);
	
}
