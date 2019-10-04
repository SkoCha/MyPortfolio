package net.mypofol.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserVO {

	/* t_user 테이블 Value Object */
	private Long no;
	private String id;
	private String password;
	private String name;
	private String email;
	private Date regDate;
	
}
