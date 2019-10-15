package net.mypofol.model;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Setter
@Getter
public class AuthVO {

	private String userid;
	private String auth;
	public static final String DEFAULT_AUTH = "ROLE_USER";
	
	public AuthVO() {
		this.auth = DEFAULT_AUTH;
	}
}
