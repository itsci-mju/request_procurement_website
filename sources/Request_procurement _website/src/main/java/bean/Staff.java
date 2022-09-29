package bean;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "staff")
public class Staff {

	@Column(name = "staff_id")
	@Id
	private int staff_id;

	@Column(name = "staff_name", length = 150, nullable = false)
	private String staff_name;

	@Column(name = "email", length = 100, nullable = false)
	private String email;

	@Column(name = "phone_number", length = 10, nullable = false)
	private String phone_number;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "major_id", nullable = false)
	private Major major = new Major();

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "Username", nullable = false)
	private Login login = new Login();

	
	
	public Staff(int staff_id, String staff_name, String email, String phone_number, Major major) {
		super();
		this.staff_id = staff_id;
		this.staff_name = staff_name;
		this.email = email;
		this.phone_number = phone_number;
		this.major = major;
		
	}

	public int getStaff_id() {
		return staff_id;
	}

	public void setStaff_id(int staff_id) {
		this.staff_id = staff_id;
	}

	public String getStaff_name() {
		return staff_name;
	}

	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone_number() {
		return phone_number;
	}

	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}

	public Major getMajor() {
		return major;
	}

	public void setMajor(Major major) {
		this.major = major;
	}

	public Login getLogin() {
		return login;
	}

	public void setLogin(Login login) {
		this.login = login;
	}

	public Staff() {
		super();
		// TODO Auto-generated constructor stub
	}

}
