package com.rest.model;

import java.util.List;

public class Group {
	private int ID;
	private String name;
	private String description;
	private String admin;
	List<User> members;
	
	public void setName(String n){
		this.name=n;
	}
	
	public String getName(){
		return name;
	}
	
	public void setDes(String d){
		this.description=d;
	}
	
	public String getDes(){
		return description;
	}
	
	public void setAdmin(String e){
		this.admin=e;
	}
	
	public String getAdmin(){
		return admin;
	}

	public int getGroupID() {
		return ID;
	}

	public void setGroupID(int g) {
		this.ID = g;
	}

}
