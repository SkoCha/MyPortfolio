package net.mypofol.model;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {

	/* t_board 테이블 Value Object */
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private Date updateDate;
	private int replyCnt;
	
}
