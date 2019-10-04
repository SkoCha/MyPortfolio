package net.mypofol.model;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class UserVOList {

	private List<UserVO> list;
	
	public UserVOList() {
		list = new ArrayList<UserVO>();
	}
	
}
