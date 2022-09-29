package bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity 
@Table (name= "Login" )

public class Login {
	@Id 
	@Column (name="Username" , length = 50 , nullable = false)
	
	private String Username;
	
	@Column (name="Password" , length = 15 , nullable = false)
	private String Password ;
	
	@Column (name="Type" , length = 15 , nullable = false)
	private String Type ;
	

	
	public Login(String username, String password, String type) {
		super();
		Username = username;
		Password = password;
		Type = type;
	}


	public Login() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	public String getUsername() {
		return Username;
	}

	public void setUsername(String username) {
		Username = username;
	}

	public String getPassword() {
		return Password;
	}

	public void setPassword(String password) {
		Password = password;
	}

	public String getType() {
		return Type;
	}

	public void setType(String type) {
		Type = type;
	}
	
	
}

