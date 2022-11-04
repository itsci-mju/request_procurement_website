package util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.google.protobuf.TextFormat.ParseException;

import bean.OrderRequest;
import bean.Product;
import bean.Quantity;
import bean.Staff;



public class QuantityManager {
	

	//insert OrderRequest 
	public int insertQuantity(Quantity q){
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		
		try {
			Statement stmt = con.createStatement();
			String sql= "insert into quantity (Qid,price,qty,orderRequest_id,product_id)  values"
					+ "( '" + q.getQid() +  "','" + q.getPrice() + 
					"', '" + q.getQty() + "' , '" +
					q.getOrderRequest().getOrderRequest_id() + "','" + q.getProduct().getProduct_id()+"')";
			int result = stmt.executeUpdate(sql);
			con.close();
			return result;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
}
	
	
	

	
	//show Update Product
	public int deleteProduct(String qid) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		try {
			Statement stmt = con.createStatement();
			String sql = "	DELETE from quantity WHERE orderRequest_id = '"+qid+"';";
			int result = stmt.executeUpdate(sql);
			con.close();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return -1;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
