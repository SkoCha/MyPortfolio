package net.mypofol.model;

import lombok.Data;

@Data
public class UploadVO {

	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	private Long bno;
	
}
