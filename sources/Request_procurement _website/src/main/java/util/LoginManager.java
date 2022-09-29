package util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import bean.Login;

public class LoginManager {
	
	public String doHibernateLogin(Login l) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			List<Login> user = session.createQuery(
					"select * from login where Username='" + l.getUsername() + "'and Password='" + l.getPassword() + "'").list();
			session.close();

			if (user.size() == 1) {
				return "เข้าสู่ระบบสำเร็จ";
			} else {
				return "ชื่อผู้ใช้หรือรหัสผ่าน ไม่ถูกต้อง";
			}
		} catch (Exception e) {
			return "กรุณาลองใหม่อีกครั้ง....";
		}
	}

	public List<Login> getHibernateLogin() {
		List<Login> list = new ArrayList<Login>();
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			
			list = session.createQuery("From Login").list();
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Login verifyLogin(Login l) {
		Login lg = null;
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();

		try {
			Statement stmt = con.createStatement();
			String sql = "select Username,Password FROM login where Username = '"
					+ l.getUsername() + "' and Password = '" + l.getPassword() + "'";

			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next() && rs.getRow() == 1) {
				String Username = rs.getString(1);
				String Password = rs.getString(2);
			
				lg = new Login(Username,Password,"");
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return lg;
	}

}
