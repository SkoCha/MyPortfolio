package net.mypofol.model;

import lombok.Data;

@Data
public class Pagination {

	private int pageNum;
	private int amount;
	private String type;
	private String keyword;
	
	public Pagination() {
		this(1,10);
	}
	
	public Pagination(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
}
