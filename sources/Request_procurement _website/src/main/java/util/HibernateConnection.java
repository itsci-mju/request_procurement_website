package util;

import java.util.Properties;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

import bean.ConfirmForm;
import bean.File_Quotation;

import bean.*;



public class HibernateConnection {
	public static SessionFactory sessionFactory;

	public static SessionFactory doHibernateConnection() {

		
		Properties database = new Properties();
		//database.setProperty("hibernate.hbm2ddl.auto", "create");
		database.setProperty("hibernate.connection.driver_class", "com.mysql.jdbc.Driver");
		database.setProperty("hibernate.connection.username", "root");
		database.setProperty("hibernate.connection.password", "1234");
		database.setProperty("hibernate.connection.url", "jdbc:mysql://localhost:3306/project-6227?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC");
		database.setProperty("hibernate.dialect", "org.hibernate.dialect.MySQL5InnoDBDialect");
		
		
		Configuration cfg = new Configuration().setProperties(database).addPackage("bean")
				
				.addAnnotatedClass(Login.class)
				.addAnnotatedClass(Staff.class)
				.addAnnotatedClass(Major.class)
				.addAnnotatedClass(Product.class)
				.addAnnotatedClass(OrderRequest.class)
				.addAnnotatedClass(Quantity.class)
				.addAnnotatedClass(ConfirmForm.class)
				.addAnnotatedClass(File_Quotation.class)
				

				;
			
		StandardServiceRegistryBuilder ssrb = new StandardServiceRegistryBuilder().applySettings(cfg.getProperties());
		sessionFactory = cfg.buildSessionFactory(ssrb.build());
		return sessionFactory;
	}
}
