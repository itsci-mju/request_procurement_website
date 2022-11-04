package bean;

import java.util.Calendar;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.MapsId;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity 
@Table (name= "ConfirmForm" )
public class ConfirmForm {
	
	@Column (name="form_id" )
	@Id 
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int form_id;
	
	@Column (name="confirm_date" , nullable = false)
	private Calendar confirm_date ;
	
	@Column (name="money_type" , length = 100, nullable = false)
	private String money_type ;
	
	@Column (name="necessity_type" , length = 150, nullable = false)
	private String necessity_type ;
	
	@Column (name="chairman_Board_name" ,length = 50, nullable = false)
	private String chairman_Board_name ;
	
	@Column (name="board_name1" ,length = 50, nullable = false)
	private String board_name1 ;
	
	@Column (name="board_name2" ,length = 50, nullable = false)
	private String board_name2 ;
	

	@Column (name="company_name" ,length = 150)
	private String company_name ;
	

	
	@Column (name="quotation_date" )
	private Calendar quotation_date ;
	
	@Column (name="quotation_no" ,length = 20)
	private String quotation_no ;

	

	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name="orderRequest_id",nullable=false,referencedColumnName="orderRequest_id")
    private OrderRequest orderRequest;

	
	
	public ConfirmForm() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ConfirmForm(int form_id, Calendar confirm_date, String money_type, String necessity_type,
			String chairman_Board_name, String board_name1, String board_name2,String company_name,Calendar quotation_date,String quotation_no, OrderRequest orderRequest) {
		super();
		this.form_id = form_id;
		this.confirm_date = confirm_date;
		this.money_type = money_type;
		this.necessity_type = necessity_type;
		this.chairman_Board_name = chairman_Board_name;
		this.board_name1 = board_name1;
		this.board_name2 = board_name2;
		this.company_name = company_name;
		this.quotation_date = quotation_date;
		this.quotation_no = quotation_no;
		this.orderRequest = orderRequest;
	}

	public int getForm_id() {
		return form_id;
	}

	public void setForm_id(int form_id) {
		this.form_id = form_id;
	}

	public Calendar getConfirm_date() {
		return confirm_date;
	}

	public void setConfirm_date(Calendar confirm_date) {
		this.confirm_date = confirm_date;
	}

	public String getMoney_type() {
		return money_type;
	}

	public void setMoney_type(String money_type) {
		this.money_type = money_type;
	}

	public String getNecessity_type() {
		return necessity_type;
	}

	public void setNecessity_type(String necessity_type) {
		this.necessity_type = necessity_type;
	}

	public String getChairman_Board_name() {
		return chairman_Board_name;
	}

	public void setChairman_Board_name(String chairman_Board_name) {
		this.chairman_Board_name = chairman_Board_name;
	}

	public String getBoard_name1() {
		return board_name1;
	}

	public void setBoard_name1(String board_name1) {
		this.board_name1 = board_name1;
	}

	public String getBoard_name2() {
		return board_name2;
	}

	public void setBoard_name2(String board_name2) {
		this.board_name2 = board_name2;
	}

	public OrderRequest getOrderRequest() {
		return orderRequest;
	}

	public void setOrderRequest(OrderRequest orderRequest) {
		this.orderRequest = orderRequest;
	}

	public String getCompany_name() {
		return company_name;
	}

	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}

	public Calendar getQuotation_date() {
		return quotation_date;
	}

	public void setQuotation_date(Calendar quotation_date) {
		this.quotation_date = quotation_date;
	}

	public String getQuotation_no() {
		return quotation_no;
	}

	public void setQuotation_no(String quotation_no) {
		this.quotation_no = quotation_no;
	}
	
	
	
	
}
