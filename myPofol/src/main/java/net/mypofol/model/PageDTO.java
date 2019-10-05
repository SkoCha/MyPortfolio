package net.mypofol.model;

import lombok.Data;

@Data
public class PageDTO {

	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int total;
	private Pagination pagi;
	
	public PageDTO(Pagination pagi, int total) {
		
		this.pagi = pagi;
		this.total = total;
		this.endPage = (int) (Math.ceil((pagi.getPageNum() / 10.0)) * 10);
		this.startPage = endPage - 9;
		int pageCount =  (int) Math.ceil((total * 1.0) / pagi.getAmount());
		if(pageCount < this.endPage) {
			this.endPage = pageCount;
		}
		this.prev = this.startPage > 1;
		this.next = this.endPage < pageCount;
		
		
	}
	
}
