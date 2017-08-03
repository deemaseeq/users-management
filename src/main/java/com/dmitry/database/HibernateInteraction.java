package com.dmitry.database;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.query.Query;

import com.dmitry.entities.Group;
import com.dmitry.entities.User;
import com.dmitry.util.HibernateUtil;

public class HibernateInteraction {

	public static boolean isUserExist(String username) {

		Session session = HibernateUtil.getSessionFactory().openSession();
		
		Query query = session.createQuery("select 1 from User where name = :username");
		query.setParameter("username", username);
		return (query.uniqueResult() != null);
	}

	public static boolean isGroupExist(String groupName) {

		Session session = HibernateUtil.getSessionFactory().openSession();
				
		Query query = session.createQuery("select 1 from Group where name = :groupName");
		query.setParameter("groupName", groupName);
		return (query.uniqueResult() != null);
	}

	public static List<User> getUsers() {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		session.beginTransaction();
		
		List<User> result = session.createQuery("from User").list();
		
		session.getTransaction().commit();
		session.close();
		
		return result;
	}

	public static List<Group> getGroups() {

		Session session = HibernateUtil.getSessionFactory().openSession();
		session.beginTransaction();
		
		List<Group> result = session.createQuery("from Group").list();
		
		session.getTransaction().commit();
		session.close();

		return result;
	}

	public static void addUser(User user) throws HibernateException {

		Session session = HibernateUtil.getSessionFactory().openSession();
		session.beginTransaction();
		
		session.save(user);
		session.getTransaction().commit();
	}

	public static void addGroup(Group group) throws HibernateException {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		session.beginTransaction();
		
		session.save(group);
		session.getTransaction().commit();
	}

	public static void deleteGroup(int id) throws HibernateException {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		session.beginTransaction();
		
		Query query = session.createQuery("delete from Group where id = :id");
		query.setParameter("id", id);
		query.executeUpdate();
		
		session.getTransaction().commit();		
	}

	public static void deleteUser(int id) throws HibernateException {

		Session session = HibernateUtil.getSessionFactory().openSession();
		session.beginTransaction();
		
		Query query = session.createQuery("delete from User where id = :id");
		query.setParameter("id", id);
		query.executeUpdate();
		
		session.getTransaction().commit();	
	}

	public static void editGroup(Group group) throws HibernateException {

		Session session = HibernateUtil.getSessionFactory().openSession();
		session.beginTransaction();
		
		session.update(group);
		session.getTransaction().commit();
	}

	/**
	 * Method to edit user. Overwrites existing user fields by User specified in parameter.
	 * Require improvements.
	 * @param user
	 * @throws HibernateException
	 */
	@Deprecated
	public static void editUser(User user) throws HibernateException {

		Session session = HibernateUtil.getSessionFactory().openSession();
		session.beginTransaction();
		
		session.update(user);
		session.getTransaction().commit();
	}

}
