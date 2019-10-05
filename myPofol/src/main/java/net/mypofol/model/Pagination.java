package net.mypofol.model;

import lombok.Data;

@Data
public class Pagination {

	private int pageNum;
	private int amount;
	
	public Pagination() {
		this(1,10);
	}
	
	public Pagination(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
