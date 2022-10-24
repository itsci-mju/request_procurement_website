package util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import bean.OrderRequest;
import bean.Product;
import bean.Quantity;
public class ProductManager {
	
	//show Data Product
	public List<Product> getAllListProduct() {
		List<Product> list = new ArrayList<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		try {
			Statement stmt = con.createStatement();
			String sql = "select product_id,product_detail,unit,price from product order by product_id";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				Integer product_id = rs.getInt(1);
				String product_detail = rs.getString(2);
				String unit = rs.getString(3);
				double price = rs.getDouble(4);
				Product p = new Product(product_id,product_detail,unit,price);
				list.add(p);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}
	
	/*
	 //show Type Product
	public List<Product> getTypeProduct() {
		List<Product> list = new ArrayList<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		try {
			Statement stmt = con.createStatement();
			String sql = "select DISTINCT type	 from product order by type;";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				Integer product_id = rs.getInt(1);
				String product_detail = rs.getString(2);
				String unit = rs.getString(3);
				String type = rs.getString(4);
				Double price = rs.getDouble(5);
				Product p = new Product(product_id,product_detail,unit,type,price);
				list.add(p);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}*/
	
	 //show Data Product
	public List<Product> listAllProducts() {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			List<Product> users = session.createQuery("From Product").list();
			session.close();
			
			return users;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	
	//show Data Product Detail
		public List<Quantity> getproductdetail(int OrderRequest_id) {
			List<Quantity> list = new ArrayList<>();
			ConnectionDB condb = new ConnectionDB();
			Connection con = condb.getConnection();

			try {
				Statement stmt = con.createStatement();
				String sql = "SELECT  q.product_id,p.product_detail,q.qty,p.unit,p.price,q.price,q.orderRequest_id\r\n"
						+ "FROM quantity q\r\n"
						+ "inner join product p on q.product_id = p.product_id\r\n"
						+ "inner join orderrequest orrq on q.orderRequest_id = orrq.orderRequest_id\r\n"
						+ "where q.orderRequest_id = "+OrderRequest_id+"\r\n "
						+ "and orrq.request_type = 'ไม่มีใบเสนอราคา'"
						+ "order by orrq.orderRequest_id ";
				ResultSet rs = stmt.executeQuery(sql);
				//System.out.println(OrderRequest_id);
			//	System.out.println(1);
				while (rs.next()) {
					Integer product_id = rs.getInt(1);
					String product_detail = rs.getString(2);
					Integer qty = rs.getInt(3);
					String unit = rs.getString(4);
					double price = rs.getDouble(5);
					double pricetotal = rs.getDouble(6);
					Integer orderrequest = rs.getInt(7);
					Product p = new Product(product_id,product_detail,unit,price);
					OrderRequest or = new OrderRequest(orderrequest,null,null,null,null,null);
					Quantity q = new Quantity(qty,pricetotal,or,p);
					list.add(q);
					
				}
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

			return list;
		}
	
	
		//show Data Product Detail
				public List<Quantity> getproductdetails(int OrderRequest_id) {
					List<Quantity> list = new ArrayList<>();
					ConnectionDB condb = new ConnectionDB();
					Connection con = condb.getConnection();

					try {
						Statement stmt = con.createStatement();
						String sql = "SELECT  q.product_id,p.product_detail,q.qty,p.unit,p.price,q.price,q.orderRequest_id\r\n"
								+ "FROM quantity q\r\n"
								+ "inner join product p on q.product_id = p.product_id\r\n"
								+ "inner join orderrequest orrq on q.orderRequest_id = orrq.orderRequest_id\r\n"
								+ "where q.orderRequest_id = "+OrderRequest_id+"\r\n "
								+ "and orrq.request_type = 'ไม่มีใบเสนอราคา'"
								+ "order by orrq.orderRequest_id ";
						ResultSet rs = stmt.executeQuery(sql);
						//System.out.println(OrderRequest_id);
					//	System.out.println(1);
						while (rs.next()) {
							Integer product_id = rs.getInt(1);
							String product_detail = rs.getString(2);
							Integer qty = rs.getInt(3);
							String unit = rs.getString(4);
							double price = rs.getDouble(5);
							double pricetotal = rs.getDouble(6);
							Integer orderrequest = rs.getInt(7);
							Product p = new Product(product_id,product_detail,unit,price);
							OrderRequest or = new OrderRequest(orderrequest,null,null,null,null,null);
							Quantity q = new Quantity(qty,pricetotal,or,p);
							list.add(q);
							
						}
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}

					return list;
				}
		
		
	
}
