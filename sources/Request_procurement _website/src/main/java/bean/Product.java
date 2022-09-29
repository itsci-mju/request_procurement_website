package bean;



import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity 
@Table (name="product")
public class Product {
	
	@Id 
	@Column (name="product_id")
	private int product_id;
	
	@Column (name="product_detail" , length = 150, nullable = false)
	private String product_detail ;
	
	@Column (name="unit" , length = 20, nullable = false)
	private String unit ;
	
	
	@Column (name="price" , nullable = false)
	private double price ;

	public Product() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Product(int product_id, String product_detail, String unit, double price) {
		super();
		this.product_id = product_id;
		this.product_detail = product_detail;
		this.unit = unit;
		this.price = price;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public String getProduct_detail() {
		return product_detail;
	}

	public void setProduct_detail(String product_detail) {
		this.product_detail = product_detail;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}


	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}
	
	
}
