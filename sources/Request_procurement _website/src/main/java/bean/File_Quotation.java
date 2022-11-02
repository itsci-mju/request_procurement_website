package bean;

import java.util.Calendar;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity 
@Table (name= "File_Quotation" )
public class File_Quotation {
	
	@Column (name="file_id" )
	@Id 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int file_id;
	
	@Column (name="file_name" , length = 100, nullable = false)
	private String file_name ;
	
	@Column (name="company_name" , length = 150, nullable = false)
	private String company_name ;
	
	@Column (name="quotation_no" ,length = 20, nullable = false)
	private String quotation_no ;
	
	@Column (name="quotation_date" , nullable = false)
	private Calendar quotation_date ;
	
	@Column (name="status_file" ,length = 100, nullable = false)
	private String status_file ;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "orderRequest_id" , nullable = false)
	private OrderRequest orderRequest  = new OrderRequest ();

	
	
	public File_Quotation() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public File_Quotation(int file_id, String file_name, String company_name, String quotation_no,
			Calendar quotation_date, String status_file) {
		super();
		this.file_id = file_id;
		this.file_name = file_name;
		this.company_name = company_name;
		this.quotation_no = quotation_no;
		this.quotation_date = quotation_date;
		this.status_file = status_file;
		
	}

	



	public int getFile_id() {
		return file_id;
	}



	public void setFile_id(int file_id) {
		this.file_id = file_id;
	}



	public String getFile_name() {
		return file_name;
	}



	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}



	public String getCompany_name() {
		return company_name;
	}



	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}



	public String getQuotation_no() {
		return quotation_no;
	}



	public void setQuotation_no(String quotation_no) {
		this.quotation_no = quotation_no;
	}



	public Calendar getQuotation_date() {
		return quotation_date;
	}



	public void setQuotation_date(Calendar quotation_date) {
		this.quotation_date = quotation_date;
	}



	public String getStatus_file() {
		return status_file;
	}



	public void setStatus_file(String status_file) {
		this.status_file = status_file;
	}



	public OrderRequest getOrderRequest() {
		return orderRequest;
	}



	public void setOrderRequest(OrderRequest orderRequest) {
		this.orderRequest = orderRequest;
	}

	
	
	
	
}
