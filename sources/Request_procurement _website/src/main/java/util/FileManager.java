package util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import bean.File_Quotation;
import bean.Product;
public class FileManager {
	
	public List<Product> getAllListProduct() {
		List<Product> list = new ArrayList<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		try {
			Statement stmt = con.createStatement();
			String sql = "select product_id,product_detail,unit,type,price from product order by product_id";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				Integer product_id = rs.getInt(1);
				String product_detail = rs.getString(2);
				String unit = rs.getString(3);
				String type = rs.getString(4);
				String price = rs.getString(5);
				Product p = new Product();
				list.add(p);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}
	
	
	
	
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
	
}
