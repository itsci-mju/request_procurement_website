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
	

	//เพิ่มข้อมูล ตางรางOrderRequest 
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
	/*
	//show RequestDetail
			public List<Quantity> getAllListQuantityProduct() throws java.text.ParseException {
				List<Quantity> list = new ArrayList<>();
				ConnectionDB condb = new ConnectionDB();
				Connection con = condb.getConnection();
				
				try {
					Statement stmt = con.createStatement();
					String sql = "select q.Qid,q.price,q.qty,o.orderRequest_id,p.product_id  "
							+ "from quatity q inner join orderrequest o ON q.orderRequest_id = o.orderRequest_id "
							+ "inner join product p ON q.product_id = p.product_id"
							+ " order by q.Qid;";
					ResultSet rs = stmt.executeQuery(sql);
					Quantity q = new Quantity();
					Staff s = new Staff();
					Product p = new Product();
					OrderRequest qr = new OrderRequest();
					while (rs.next()) {
						Integer Qid = rs.getInt(1);
						Integer qty = rs.getInt(3);
						double price = rs.getDouble(2);
						Integer orderRequest_id = rs.getInt(4);
						String product_id = rs.getString(5);
						
						
		
						//Quantity or = new OrderRequest(qty,price,qr.getOrderRequest_id(),p.getProduct_id());
						list.add(or);
					}
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}

				return list;
			}*/
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
