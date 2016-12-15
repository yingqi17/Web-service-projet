package com.rest.model;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="user")
@XmlAccessorType(XmlAccessType.FIELD)
public class User {
	//private int ID;
	private String emailAdd;
	private String pwd;
	private String Fname;
	private String Lname;
	private String biography;
	
	public User(){	
		
	}
/*	
	public int getID() {
		return ID;
	}


	public void setID(int iD) {
		ID = iD;
	}
	*/
	public void setEmail(String e){
		this.emailAdd=e;
	}
	
	public String getEmail(){
		return this.emailAdd;
	}
	
	public void setFname(String f){
		this.Fname=f;
	}
	
	public String getFname(){
		return this.Fname;
	}
	
	public void setLname(String l){
		this.Lname=l;
	}
	
	public String getLname(){
		return this.Lname;
	}
	
	public void setBio(String b){
		this.biography=b;
	}
	
	public String getBio(){
		return this.biography;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

}
