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

import com.google.protobuf.TextFormat.ParseException;

import bean.File_Quotation;
import bean.OrderRequest;
import bean.Product;
import bean.Quantity;
public class FileManager {
	
//	//select list product
//	public List<Product> getAllListProduct() {
//		List<Product> list = new ArrayList<>();
//		ConnectionDB condb = new ConnectionDB();
//		Connection con = condb.getConnection();
//
//		try {
//			Statement stmt = con.createStatement();
//			String sql = "select product_id,product_detail,unit,type,price from product order by product_id";
//			ResultSet rs = stmt.executeQuery(sql);
//			while (rs.next()) {
//				Integer product_id = rs.getInt(1);
//				String product_detail = rs.getString(2);
//				String unit = rs.getString(3);
//				String type = rs.getString(4);
//				String price = rs.getString(5);
//				Product p = new Product();
//				list.add(p);
//			}
//			con.close();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//
//		return list;
//	}
//	
	
	
	//Max File
	public int getMaxFilequotationID() {
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

	//insert File
	public int insertFileQuotaion(File_Quotation f){
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		
		Date date = f.getQuotation_date().getTime(); //date 
		String pattern = "yyyy-MM-dd";
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		Date fileQuotation = f.getQuotation_date().getTime(); //get date 
		fileQuotation.setDate(date.getDate()); //set  date 
		String fd = sdf.format(fileQuotation); // date  string
		
		try {
			Statement stmt = con.createStatement();
			String sql= "insert into file_quotation (file_id,company_name,file_name,quotation_date,quotation_no,status_file,orderRequest_id) "
					+ "values('" + f.getFile_id() + "', '" + f.getCompany_name() + "' , '" +
						f.getFile_name() + "','" + fd + "','" +
						f.getQuotation_no() + "',' " + f.getStatus_file() + "',' " + f.getOrderRequest().getOrderRequest_id() + "')";
			int result = stmt.executeUpdate(sql);
			con.close();
			return result;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public int updateFileQuotaion(File_Quotation f){
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		
		Date date = f.getQuotation_date().getTime(); //date 
		String pattern = "yyyy-MM-dd";
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		Date fileQuotation = f.getQuotation_date().getTime(); //get date 
		fileQuotation.setDate(date.getDate()); //set  date 
		String fd = sdf.format(fileQuotation); // date  string
		
		try {
			Statement stmt = con.createStatement();
			String sql = "update file_quotation "
						+ "set company_name = '"+ f.getCompany_name() +"', "
						+ "file_name = '"+ f.getFile_name() +"', "
						+ "quotation_date = '"+ fd +"', "
						+ "quotation_no = '"+ f.getQuotation_no() +"', "
						+ "status_file = '"+ f.getStatus_file() +"' "
						+ "where file_id = "+ f.getFile_id() +" ";
			int result = stmt.executeUpdate(sql);
			con.close();
			return result;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return -1;
	}
	
	

	//show Data File Quotation Detail
	public List<File_Quotation> getAllQuotation(int OrderRequest_id)throws ParseException, java.text.ParseException {
		List<File_Quotation> list = new ArrayList<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		try {
			Statement stmt = con.createStatement();
			String sql = "select file_id,company_name,file_name,quotation_date,quotation_no,status_file,orderRequest_id from file_quotation where orderRequest_id = "+OrderRequest_id+";";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				Integer file_id = rs.getInt(1);
				String company_name = rs.getString(2);
				String file_name = rs.getString(3);
				String quotation_date = rs.getString(4);
				String quotation_no = rs.getString(5);
				String status_file = rs.getString(6);
				Integer orderrequest = rs.getInt(7);
				
			
				Calendar caldate = Calendar.getInstance();
				String pattern = "yyyy-MM-dd";
				SimpleDateFormat sdf = new SimpleDateFormat(pattern);
				caldate.setTime(sdf.parse(quotation_date));	

				File_Quotation fq = new File_Quotation(file_id,company_name,file_name,quotation_no,caldate,status_file);	
				OrderRequest or = new OrderRequest(orderrequest,null,null,null,null,null);
				list.add(fq);
			
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}
	
	
	
	
}
