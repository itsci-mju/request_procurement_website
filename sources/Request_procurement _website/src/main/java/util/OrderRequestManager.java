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
import bean.Staff;

public class OrderRequestManager {

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

	// Auto OrderRequestID
	public int getMaxOrderRequestID() {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		int id = 0;
		try {
			Statement stmt = con.createStatement();
			String sql = "SELECT Max(orderRequest_id) from orderrequest;";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				id = rs.getInt(1);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return id + 1;
	}

	// Auto getMaxFileID
	public int getMaxFileID() {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		int id = 0;
		try {
			Statement stmt = con.createStatement();
			String sql = "SELECT Max(file_id) from file_quotation;";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				id = rs.getInt(1);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return id + 1;
	}

	// เพิ่มข้อมูล ตางรางOrderRequest
	public int insertOrderRequest(OrderRequest od) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Calendar c = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		try {
			Statement stmt = con.createStatement();
			String sql = "insert into orderrequest (orderRequest_id,comment,orderRequest_date,request_type,status,staff_id)  values"
					+ "('" + od.getOrderRequest_id() + "', '" + od.getComment() + "' , '" + sdf.format(c.getTime())
					+ "','" + od.getRequest_type() + "','" + od.getStatus() + "', '" + od.getStaff().getStaff_id()
					+ "')";
			int result = stmt.executeUpdate(sql);
			con.close();
			return result;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	// เพิ่มข้อมูล ตางรางOrderRequest
	public int insertOrderRequest2(OrderRequest od) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		Calendar c = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		try {
			Statement stmt = con.createStatement();
			String sql = "insert into orderrequest (orderRequest_id,comment,orderRequest_date,request_type,status,staff_id)  values"
					+ "('" + od.getOrderRequest_id() + "', '" + od.getComment() + "' , '" + sdf.format(c.getTime())
					+ "','" + od.getRequest_type() + "','" + od.getStatus() + "', '" + od.getStaff().getStaff_id()
					+ "')";
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
	 * public String insertOrderRequest(OrderRequest orderRequest) { try {
	 * SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	 * 
	 * Session session = sessionFactory.openSession(); Transaction t =
	 * session.beginTransaction(); session.save(orderRequest); t.commit();
	 * session.close(); return "successfully saved"; } catch (Exception e) { return
	 * "failed to save orderRequest"; } }
	 */

	// show OrderRequest
	public List<OrderRequest> getAllListOrderRequest() throws java.text.ParseException {
		List<OrderRequest> list = new ArrayList<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		try {
			Statement stmt = con.createStatement();
			String sql = "select o.orderRequest_id,o.orderRequest_date,o.status,o.request_type,s.username  "
					+ "from orderrequest o inner join staff s ON o.staff_id = s.staff_id "
					+ " order by o.orderRequest_date DESC;";
			ResultSet rs = stmt.executeQuery(sql);
			Staff s = new Staff();
			StaffManager sm = new StaffManager();
			while (rs.next()) {
				Integer orderRequest_id = rs.getInt(1);
				String orderRequest_date = rs.getString(2);
				String status = rs.getString(3);
				String request_type = rs.getString(4);
				String username = rs.getString(5);
				s = sm.getStaff(username);
				Calendar caldate = Calendar.getInstance();
				String pattern = "yyyy-MM-dd HH:mm:ss";
				SimpleDateFormat sdf = new SimpleDateFormat(pattern);
				caldate.setTime(sdf.parse(orderRequest_date));

				OrderRequest or = new OrderRequest(orderRequest_id, caldate, status, request_type, "", s);
				list.add(or);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	// delete OrderRequest
	public int deleteOrderRequest(String orderRequest_id) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		try {
			Statement stmt = con.createStatement();
			String sql = "DELETE from orderRequest WHERE orderRequest_id = " + orderRequest_id + ";";
			int result = stmt.executeUpdate(sql);
			con.close();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return -1;
	}

	public OrderRequest OrderRequestByID(String orderRequestByid ) throws java.text.ParseException {
		OrderRequest or = new OrderRequest();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		try {
			Statement stmt = con.createStatement();
			String sql = "SELECT orderRequest_id,orderRequest_date,status,request_type,staff_id	FROM orderrequest	where orderRequest_id = '"+orderRequestByid+"' ;";
			ResultSet rs = stmt.executeQuery(sql);
			Staff s = new Staff();
			StaffManager sm = new StaffManager();
			while (rs.next()) {
				Integer orderRequest_id = rs.getInt(1);
				String orderRequest_date = rs.getString(2);
				String status = rs.getString(3);
				String request_type = rs.getString(4);
				String username = rs.getString(5);
				s = sm.getStaff(username);
				Calendar caldate = Calendar.getInstance();
				String pattern = "yyyy-MM-dd HH:mm:ss";
				SimpleDateFormat sdf = new SimpleDateFormat(pattern);
				caldate.setTime(sdf.parse(orderRequest_date));

				or = new OrderRequest(orderRequest_id, caldate, status, request_type, "", s);

			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return or;
	}

}
