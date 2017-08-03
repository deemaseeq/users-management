package com.dmitry.services.groups;

import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.hibernate.HibernateException;

import com.dmitry.database.HibernateInteraction;
import com.dmitry.entities.Group;

@Path("/group")
public class GroupService {

	@POST
	@Path("/add")
	@Produces(MediaType.TEXT_PLAIN)
	public String doPostAddGroup(@FormParam("name") String name) {

		if (HibernateInteraction.isGroupExist(name)) {
			return "Group with this name already exists.";
		}

		Group newGroup = new Group();

		newGroup.setName(name);

		try {
			HibernateInteraction.addGroup(newGroup);
			return "Succesful addition";
		} catch (HibernateException e) {
			e.printStackTrace();
			return "Failed to access database. Please try again later.";
		}
	}

	@POST
	@Path("/delete")
	@Produces(MediaType.TEXT_PLAIN)
	public String doPostDeleteGroup(@FormParam("id") int id){
		
		try {
			HibernateInteraction.deleteGroup(id);
			return "Succesful delete";
		} catch (HibernateException e) {
			e.printStackTrace();
			return "Failed to access database. Please try again later.";
		}
	}

	@POST
	@Path("/edit")
	@Produces(MediaType.TEXT_PLAIN)
	public String doPostEditGroup(
			@FormParam("id") int id,
			@FormParam("name") String name) {
		
		Group groupToChange = new Group();
		
		groupToChange.setId(id);
		groupToChange.setName(name);
		
		try {
			HibernateInteraction.editGroup(groupToChange);
			return "Succesful editing";
		} catch (HibernateException e) {
			e.printStackTrace();
			return "Failed to access database. Please try again later.";
		}
	}

}
