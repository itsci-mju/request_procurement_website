package bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity 
@Table (name="Major")
public class Major {
	@Id 
	@Column (name="major_id")
	private int major_id;
	
	@Column (name="major_name" , length = 150 , nullable = false)
	private String major_name ;

	public int getMajor_id() {
		return major_id;
	}

	
	
	
	
	public Major() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Major(int major_id, String major_name) {
		super();
		this.major_id = major_id;
		this.major_name = major_name;
	}


	public void setMajor_id(int major_id) {
		this.major_id = major_id;
	}

	public String getMajor_name() {
		return major_name;
	}

	public void setMajor_name(String major_name) {
		this.major_name = major_name;
	}
	
	
}
