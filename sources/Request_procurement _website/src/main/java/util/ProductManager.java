package util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import bean.Product;
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
		public List<Product> getproductdetail() {
			List<Product> list = new ArrayList<>();
			ConnectionDB condb = new ConnectionDB();
			Connection con = condb.getConnection();

			try {
				Statement stmt = con.createStatement();
				String sql = "SELECT  q.product_id,p.product_detail,q.qty,p.unit,p.price,q.price,q.orderRequest_id"
						+ "FROM quantity q"
						+ "inner join product p on q.product_id = p.product_id"
						+ "inner join orderrequest orrq on q.orderRequest_id = orrq.orderRequest_id"
						+ "order by orrq.orderRequest_id";
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
	
	
	
}
