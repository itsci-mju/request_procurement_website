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

import bean.ConfirmForm;
import bean.File_Quotation;
import bean.OrderRequest;
import bean.Product;
import bean.Quantity;
import bean.Staff;
public class ConfirmManager {
	
	
	//  Select ConfirmForm
	public ConfirmForm ConfirmFormByID(String orderRequestByid ) throws java.text.ParseException {
		ConfirmForm cf = new ConfirmForm();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		try {
			Statement stmt = con.createStatement();
			String sql = "SELECT form_id,confirm_date,money_type,necessity_type,chairman_Board_name,board_name1,board_name2,company_name,quotation_no,quotation_date,orderRequest_id FROM confirmform where orderRequest_id = '"+orderRequestByid+"' ;";
			ResultSet rs = stmt.executeQuery(sql);
			
			StaffManager sm = new StaffManager();
			while (rs.next()) {
				Integer form_id = rs.getInt(1);
				String confirm_date = rs.getString(2);
				String money_type = rs.getString(3);
				String necessity_type = rs.getString(4);
				String chairman_Board_name = rs.getString(5);
				String board_name1 = rs.getString(6);
				String board_name2 = rs.getString(7);
				
				String company_name =   rs.getString(8);
				String quotation_no =   rs.getString(9);
				String quotation_date =   rs.getString(10);
				
			
				
				Calendar caldate = Calendar.getInstance();
				String pattern = "yyyy-MM-dd HH:mm:ss";
				SimpleDateFormat sdf = new SimpleDateFormat(pattern);
				caldate.setTime(sdf.parse(confirm_date));
				
				Calendar caldatefile = Calendar.getInstance();
				String pattern2 = "yyyy-MM-dd HH:mm:ss";
				SimpleDateFormat sdf2 = new SimpleDateFormat(pattern2);
				caldatefile.setTime(sdf2.parse(quotation_date));
				
				OrderRequestManager orm = new OrderRequestManager();
				OrderRequest o = orm.OrderRequestByID(orderRequestByid);
				cf = new ConfirmForm(form_id,caldate, money_type, necessity_type, chairman_Board_name,board_name1,board_name2,company_name,caldatefile,quotation_no,o);

			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return cf;
	}
	
	
	


	
	
	
	
}
