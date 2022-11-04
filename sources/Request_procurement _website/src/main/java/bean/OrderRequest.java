package bean;

import java.util.Calendar;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity 
@Table (name="OrderRequest")
public class OrderRequest {
	
	@Id
	@Column (name="orderRequest_id " )
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int orderRequest_id ;
	
	@Column (name="orderRequest_date " , nullable = false)
	private Calendar orderRequest_date  ;
	
	@Column (name="status" , length = 100, nullable = false)
	private String status ;
	
	@Column (name="request_type" , length = 50, nullable = false)
	private String request_type ;
	
	@Column (name="comment" ,length = 255, nullable = false)
	private String comment ;
	
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "staff_id", nullable = false)
	private Staff staff = new Staff();
	
	@OneToOne(mappedBy = "orderRequest", cascade = CascadeType.ALL)
	@PrimaryKeyJoinColumn
	private ConfirmForm confirmform;


	

	public OrderRequest(int orderRequest_id, Calendar orderRequest_date, String status, String request_type,
			String comment, Staff staff) {
		super();
		this.orderRequest_id = orderRequest_id;
		this.orderRequest_date = orderRequest_date;
		this.status = status;
		this.request_type = request_type;
		this.comment = comment;
		this.staff = staff;
	}

	public OrderRequest() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getOrderRequest_id() {
		return orderRequest_id;
	}

	public void setOrderRequest_id(int orderRequest_id) {
		this.orderRequest_id = orderRequest_id;
	}

	public Calendar getOrderRequest_date() {
		return orderRequest_date;
	}

	public void setOrderRequest_date(Calendar orderRequest_date) {
		this.orderRequest_date = orderRequest_date;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRequest_type() {
		return request_type;
	}

	public void setRequest_type(String request_type) {
		this.request_type = request_type;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Staff getStaff() {
		return staff;
	}

	public void setStaff(Staff staff) {
		this.staff = staff;
	}

	public ConfirmForm getConfirmform() {
		return confirmform;
	}

	public void setConfirmform(ConfirmForm confirmform) {
		this.confirmform = confirmform;
	}

	
	
	
	
}
