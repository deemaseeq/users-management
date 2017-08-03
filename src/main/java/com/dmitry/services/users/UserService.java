package com.dmitry.services.users;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import com.dmitry.database.HibernateInteraction;
import com.dmitry.entities.Group;
import com.dmitry.entities.User;
import com.dmitry.util.HibernateUtil;

@Path("/user")
public class UserService {

	@POST
	@Path("/add")
	@Produces(MediaType.TEXT_PLAIN)
	public String doPostAddUser(
			@FormParam("username") String username,
			@FormParam("password") String password,
			@FormParam("firstName") String firstName,
			@FormParam("lastName") String lastName,
			@FormParam("birthDate") String birthDate,
			@FormParam("groups") String groups) {

		if (HibernateInteraction.isUserExist(username)) {
			return "User with this name already exists.";
		}
		
		User newUser = new User();
		
		String[] groupStrings = groups.split(",");
		Set<Group> userGroups = new HashSet<>();
		for (int i = 0; i < groupStrings.length; i++) {
			Group group = new Group();
			group.setId(Integer.parseInt(groupStrings[i]));
			userGroups.add(group);
		}

		newUser.setName(username);
		newUser.setFirstName(firstName);
		newUser.setLastName(lastName);
		newUser.setPassword(password);
		newUser.setBirthDate(LocalDate.parse(birthDate));
		newUser.setGroups(userGroups);

		try {
			HibernateInteraction.addUser(newUser);
			return "Succesful addition";
		} catch (HibernateException e) {
			e.printStackTrace();
			return "Failed to access database. Please try again later.";
		}
	}
	
	@POST
	@Path("/delete")
	@Produces(MediaType.TEXT_PLAIN)
	public String doPostDeleteUser(@FormParam("id") int id){
		
		try {
			HibernateInteraction.deleteUser(id);
			return "Succesful delete";
		} catch (HibernateException e) {
			e.printStackTrace();
			return "Failed to access database. Please try again later.";
		}
		
	}
	
	@POST
	@Path("/edit")
	@Produces(MediaType.TEXT_PLAIN)
	public String doPostEditUser(
			@FormParam("id") int id,
			@FormParam("username") String username,
			@FormParam("password") String password,
			@FormParam("firstName") String firstName,
			@FormParam("lastName") String lastName,
			@FormParam("birthDate") String birthDate,
			@FormParam("groups") String groups){
		
		
		try {
			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();
			
			User editableUser = (User) session.get(User.class, Integer.valueOf(id));
			
			editableUser.setName(username);
			editableUser.setFirstName(firstName);
			editableUser.setLastName(lastName);
			editableUser.setPassword(password);
			editableUser.setBirthDate(LocalDate.parse(birthDate));
			
			if(editableUser.getGroups() != null){
				editableUser.getGroups().clear();
			}
			
			String[] groupStrings = groups.split(",");
			for (int i = 0; i < groupStrings.length; i++) {
				Group group = session.load(Group.class, Integer.parseInt(groupStrings[i]));
				editableUser.getGroups().add(group);
			}
			
			session.save(editableUser);
			session.getTransaction().commit();
			
			return "Succesful editing";
			
		} catch (Exception e) {
			e.printStackTrace();
			return "Failed to access database. Please try again later.";
		}
		
		/*try {
			HibernateInteraction.editUser(editableUser, userGroups);
			return "Succesful editing";
		} catch (HibernateException e) {
			e.printStackTrace();
			return "Failed to access database. Please try again later.";
		}*/
	}

}
