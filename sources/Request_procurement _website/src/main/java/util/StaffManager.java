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
import bean.Product;
import bean.Staff;

public class StaffManager {
	
	//select Staff
	public Staff getStaff(String username) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			Staff users = (Staff) session.createQuery("From Staff where Username = '"+username+"' ").getSingleResult();
			session.close();
			
			return users;
			
		} catch (Exception e) {
			return null;
		}
	}

}
