package net.mypofol.model;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {

	private Long rno;
	private Long bno;
	private String reply;
	private String writer;
	private Date regDate;
	private Date updateDate;
	
}
