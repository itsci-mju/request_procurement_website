package bean;


import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity 
@Table (name= "Quantity" )
public class Quantity {
	
	@Id 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int Qid ;
	
	@Column (name="qty" , nullable = false)
	private int qty ;
	
	@Column (name="price" , nullable = false)
	private double price  ;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name="orderRequest_id",nullable=false,referencedColumnName="orderRequest_id")
	private OrderRequest orderRequest;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name="product_id",nullable=false,referencedColumnName="product_id")
	private Product product;
	
	
	
	public Quantity( int qty, double price, OrderRequest orderRequest, Product product) {
		super();
		this.qty = qty;
		this.price = price;
		this.orderRequest = orderRequest;
		this.product = product;
	}

	
	public Quantity(int qid, int qty, double price, OrderRequest orderRequest, Product product) {
		super();
		Qid = qid;
		this.qty = qty;
		this.price = price;
		this.orderRequest = orderRequest;
		this.product = product;
	}


	public int getQid() {
		return Qid;
	}

	public void setQid(int qid) {
		Qid = qid;
	}

	public OrderRequest getOrderRequest() {
		return orderRequest;
	}

	public void setOrderRequest(OrderRequest orderRequest) {
		this.orderRequest = orderRequest;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Quantity() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}


	
	
}
