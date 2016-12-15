package com.rest.RestfulService;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;

import com.rest.DB.DBClass;
import com.rest.model.User;
import com.rest.util.ToJSON;

@Path("WSProjet")
public class System {
	static User user=new User();
	
	public String time()
	{
	Date date=new Date();
	DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String time=format.format(date);
	return time;
	}
	
	@POST
	@Path("signin")
	//@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	public Response signin(@FormParam("email") String e,@FormParam("pwd") String p,@FormParam("Fname") String f,@FormParam("Lname") String l,@FormParam("biography") String b) throws Exception
	{
		if(e.equals("")){
			return Response.status(400).entity("Please enter your email.").build();
		}
		else if(p.equals("")){
			return Response.status(400).entity("Please enter your password.").build();
		}
		else if(f.equals("")){
			return Response.status(400).entity("Please enter your first name.").build();
		}
		else if(l.equals("")){
			return Response.status(400).entity("Please enter your last name.").build();
		}
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("select * from users where email='"+e+"'");
		while(rs.next())
        {
			return Response.status(200).entity("This email is used.").build();
        }
        PreparedStatement preStatement = conn.prepareStatement("insert into users(email,pwd,Fname,Lname,biography) values(?,?,?,?,?)");
        preStatement.setString(1, e);
        preStatement.setString(2, p);
        preStatement.setString(3, f);
        preStatement.setString(4, l);
        preStatement.setString(5, b);
		int i = preStatement.executeUpdate();
	    preStatement.close();
	    conn.close();
	    if(i>=0){
	    	URI uri=new URI("http://localhost:8080/WSProjet/index.jsp");
	    	return Response.temporaryRedirect(uri).build();
	    	}
	    else 
	    	return Response.status(400).entity(null).build();
	    	
	}

	@POST
	@Path("login")
	public Response login(@FormParam("email") String e,@FormParam("pwd") String p) throws SQLException, URISyntaxException{
		if(e.equals("")){
			return Response.status(400).entity("Please enter your email.").build();
		}
		else if(p.equals("")){
			return Response.status(400).entity("Please enter your password.").build();
		}
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("select * from users where email='"+e+"' and pwd='"+p+"'");
		boolean i=rs.next();
		
		 while(i)
         {
			 user.setEmail(rs.getString(1));
			 user.setFname(rs.getString(3));
			 user.setLname(rs.getString(4));
			 user.setBio(rs.getString(5));
			 URI uri=new URI("http://localhost:8080/WSProjet/Main.jsp");
		     return Response.temporaryRedirect(uri).build();
         }
		 return Response.status(400).entity("Your email or your password is wrong.").build();
    }
	
	@GET
	@Path("info")
	@Produces(MediaType.APPLICATION_JSON)
	public String getUserInfo() throws Exception{
		Connection conn = DBClass.returnConnection();
		PreparedStatement pre = conn.prepareStatement("select * from users where email='"+user.getEmail()+"'");
		ResultSet rs = pre.executeQuery();
		ResultSetMetaData metaData = rs.getMetaData();  
		   int columnCount = metaData.getColumnCount();
		   JSONArray array = new JSONArray();
		   if(rs.next()){
			   JSONObject jsonObj = new JSONObject();
		       for (int i = 1; i <= columnCount; i++) { 
		        	String columnName =metaData.getColumnLabel(i);  
	                String value = rs.getString(columnName);
	                jsonObj.put(columnName, value);  }
		            array.put(jsonObj);
		       }
		       if(array.length()>0){
				  for(int i=0;i<array.length();i++){
				    JSONObject job = array.getJSONObject(i);  // 遍历 jsonarray 数组，把每一个对象转成 json 对象
				    java.lang.System.out.println(job) ;  // 得到 每个对象中的属性值
				  }}
	    rs.close();
	    pre.close();
	    conn.close();
	    if(array!=null){
	    	java.lang.System.out.println(array);
	    }
		return array.toString(); 
	}
	
	@POST
	@Path("change")
	public Response change(@FormParam("Fname") String f,@FormParam("Lname") String l,@FormParam("biography") String b) throws SQLException, URISyntaxException{
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		if(!f.equals("")){
			user.setFname(f);
		}
		if(!l.equals("")){
			user.setLname(l);
		}
        if(b.equals("")){
        	user.setBio(b);
		}
		int i = st.executeUpdate("update users set Fname='"+f+"',Lname='"+l+"',biography='"+b+"' where email='"+user.getEmail()+"'");
        st.close();
        conn.close();
        if(i>=0){
	    	URI uri=new URI("http://localhost:8080/WSProjet/Main.jsp");
	    	return Response.temporaryRedirect(uri).build();
	    	}
	    else 
	    	return Response.status(400).entity(null).build();
	}
	
	@POST	
	@Path("delete/user")
	public Response delete() throws SQLException, URISyntaxException{
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		int i = st.executeUpdate("delete from ug where uemail='"+user.getEmail()+"'");
		st.close();
		Statement st1 = conn.createStatement();
		int k = st1.executeUpdate("delete from groups where admin_email='"+user.getEmail()+"'");
		st1.close();
		Statement st2 = conn.createStatement();
		int j = st2.executeUpdate("delete from users where email='"+user.getEmail()+"'");
		st2.close();
	    conn.close();
		if(i>=0&j>=0&k>=0){
	    	URI uri=new URI("http://localhost:8080/WSProjet/index.jsp");
	    	return Response.temporaryRedirect(uri).build();
	    	}
	    else 
	    	return Response.status(400).entity(null).build();
	}
	
	@POST
	@Path("create/group")
	public Response creategroup(@FormParam("name") String n,@FormParam("description") String d) throws SQLException, URISyntaxException{
		Connection conn = DBClass.returnConnection();
		PreparedStatement preStatement = conn.prepareStatement("insert into groups(name,description,admin_email) values(?,?,?)");
        preStatement.setString(1, n);
        preStatement.setString(2, d);
        preStatement.setString(3, user.getEmail());
		int i = preStatement.executeUpdate();
		preStatement.close();
		PreparedStatement preStatement2 = conn.prepareStatement("insert into ug(uemail,gname) values(?,?)");
		preStatement2.setString(1, user.getEmail());
        preStatement2.setString(2, n);
        int j = preStatement2.executeUpdate();
		if(i>=0&j>=0){
	    	URI uri=new URI("http://localhost:8080/WSProjet/Main.jsp");
	    	return Response.temporaryRedirect(uri).build();
	    	}
	    else 
	    	return Response.status(400).entity(null).build();
	}
	
	@GET
	@Path("your/group")
	@Produces(MediaType.APPLICATION_JSON)
	public String getGroup() throws Exception{
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("select * from groups where admin_email='"+user.getEmail()+"'");
		/* ResultSetMetaData metaData = rs.getMetaData();  
		   int columnCount = metaData.getColumnCount();
		   JSONArray array = new JSONArray();
		   if(rs.next()){
			   JSONObject jsonObj = new JSONObject();
		       for (int i = 1; i <= columnCount; i++) { 
		        	String columnName =metaData.getColumnLabel(i);  
	                String value = rs.getString(columnName);
	                jsonObj.put(columnName, value);  }
		            array.put(jsonObj);}
		 */      
		
		JSONArray  array =ToJSON.toJSONArray(rs);
	    rs.close();
	    st.close();
	    conn.close();
	    java.lang.System.out.println(array);
		return array.toString(); 
		
	}
	
	@GET
	@Path("group/joined")
	@Produces(MediaType.APPLICATION_JSON)
	public String groupJoined() throws Exception{
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("select * from ug where uemail='"+user.getEmail()+"'");
		/* ResultSetMetaData metaData = rs.getMetaData();  
		   int columnCount = metaData.getColumnCount();
		   JSONArray array = new JSONArray();
		   if(rs.next()){
			   JSONObject jsonObj = new JSONObject();
		       for (int i = 1; i <= columnCount; i++) { 
		        	String columnName =metaData.getColumnLabel(i);  
	                String value = rs.getString(columnName);
	                jsonObj.put(columnName, value);  }
		            array.put(jsonObj);}
		 */      
		
		JSONArray  array =ToJSON.toJSONArray(rs);
	    rs.close();
	    st.close();
	    conn.close();
	    java.lang.System.out.println(array);
		return array.toString(); 
		
	}

	@GET
	@Path("group/info/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public String getGroupInfo(@PathParam("name") String n) throws Exception{
		//group.setName(n);
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("select * from groups where name='"+n+"'");
		ResultSetMetaData metaData = rs.getMetaData();  
		   int columnCount = metaData.getColumnCount();
		   JSONArray array = new JSONArray();
		   if(rs.next()){
			   JSONObject jsonObj = new JSONObject();
		       for (int i = 1; i <= columnCount; i++) { 
		        	String columnName =metaData.getColumnLabel(i);  
	                String value = rs.getString(columnName);
	                jsonObj.put(columnName, value);  }
		            array.put(jsonObj);}
		//JSONArray  jsonArray =ToJSON.toJSONArray(rs);
	    rs.close();
	    st.close();
	    conn.close();
	    java.lang.System.out.println(array);
		return array.toString(); 
	}
	
	@POST
	@Path("change/group/{name}")
	public Response changeInfoGroup(@FormParam("description") String d,@PathParam("name") String n) throws SQLException, URISyntaxException{
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		int i = st.executeUpdate("update groups set description='"+d+"' where name='"+n+"'");
        st.close();
        conn.close();
        if(i>=0){
	    	URI uri=new URI("http://localhost:8080/WSProjet/Main.jsp");
	    	return Response.temporaryRedirect(uri).build();
	    	}
	    else 
	    	return Response.status(400).entity(null).build();
	}
	
	@POST	
	@Path("delete/group/{name}")
	public Response deletegroup(@PathParam("name") String n) throws SQLException, URISyntaxException{
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		int i = st.executeUpdate("delete from ug where gname='"+n+"'");
		st.close();
		Statement st2 = conn.createStatement();
		int j = st2.executeUpdate("delete from groups where name='"+n+"'");
		st2.close();
	    conn.close();
		if(i>=0&j>=0){
	    	URI uri=new URI("http://localhost:8080/WSProjet/Main.jsp");
	    	return Response.temporaryRedirect(uri).build();
	    	}
	    else 
	    	return Response.status(400).entity(null).build();
	}
	
	@GET
	@Path("view/group")
	@Produces(MediaType.APPLICATION_JSON)
	public String viewGroup() throws Exception{
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("select name,description from groups");
		JSONArray  jsonArray =ToJSON.toJSONArray(rs);
	    rs.close();
	    st.close();
	    conn.close();
		return jsonArray.toString(); 
	}
	
	@GET
	@Path("isjoined/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public String isjoined(@PathParam("name") String n) throws SQLException, Exception{
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("select * from ug where gname='"+n+"' and uemail='"+user.getEmail()+"'");
		java.lang.System.out.println(n);
		java.lang.System.out.println(user.getEmail());
		if(rs.next()){
			//JSONArray  jsonArray =ToJSON.toJSONArray(rs);
			ResultSetMetaData metaData = rs.getMetaData();  
			   int columnCount = metaData.getColumnCount();
			   JSONArray array = new JSONArray();
			  
				   JSONObject jsonObj = new JSONObject();
			       for (int i = 1; i <= columnCount; i++) { 
			        	String columnName =metaData.getColumnLabel(i);  
		                String value = rs.getString(columnName);
		                jsonObj.put(columnName, value);  }
			            array.put(jsonObj);
		    rs.close();
		    st.close();
		    conn.close();
		  //  java.lang.System.out.println(array);
			return array.toString();
		}
		else{
		    rs.close();
		    st.close();
		    conn.close();
		  //  java.lang.System.out.println("no");
			return null;
		}
	}
	
	@GET
	@Path("isnotjoined/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public String isnotjoined(@PathParam("name") String n) throws SQLException, Exception{
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("select * from ug where gname='"+n+"' and uemail='"+user.getEmail()+"'");
		if(rs.next()){
			rs.close();
		    st.close();
		    conn.close();
		  //  java.lang.System.out.println("0");
			return null;
		}
		else{
			rs.close();
			st.close();
			Statement st1 = conn.createStatement();
			ResultSet rs1 = st1.executeQuery("select * from users where email='"+user.getEmail()+"'");
			JSONArray  jsonArray =ToJSON.toJSONArray(rs1);
		    rs.close();
		    st.close();
		    conn.close();
		   // java.lang.System.out.println("1");
		    return jsonArray.toString();
		}
		
	}
	
	@POST
	@Path("join/group/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response joinGroup(@PathParam("name") String n) throws SQLException, URISyntaxException{
		Connection conn = DBClass.returnConnection();
		PreparedStatement preStatement = conn.prepareStatement("insert into ug(uemail,gname) values(?,?)");
		preStatement.setString(1, user.getEmail());
	    preStatement.setString(2, n);
		int i = preStatement.executeUpdate();
		preStatement.close();
		if(i>=0){
	    	URI uri=new URI("http://localhost:8080/WSProjet/Main.jsp");
	    	return Response.temporaryRedirect(uri).build();
	    	}
	    else 
	    	return Response.status(400).entity(null).build();
	}
	
	@GET
	@Path("look/group/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public String lookGroup(@PathParam("name") String n) throws Exception{
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("select name,description from groups where name='"+n+"'");

			JSONArray  jsonArray =ToJSON.toJSONArray(rs);
		    rs.close();
		    st.close();
		    conn.close();
			return jsonArray.toString();
	}
	
	@GET
	@Path("membership/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public String membership(@PathParam("name") String n) throws Exception{
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("select count(1) from groups where name='"+n+"'");
		JSONArray  array =ToJSON.toJSONArray(rs);
		rs.close();
	    st.close();
	    conn.close();
	    return array.toString();
	}
	

	@GET
	@Path("dashboard/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public String dashboard(@PathParam("name") String n) throws Exception{
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("select time,uemail,content from board where gname='"+n+"'");
		JSONArray  array =ToJSON.toJSONArray(rs);
		rs.close();
	    st.close();
	    conn.close();
	    return array.toString();
	}
		
	@GET
	@Path("members/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public String members(@PathParam("name") String n) throws Exception{
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("select uemail from ug where gname='"+n+"'");
		JSONArray  array =ToJSON.toJSONArray(rs);
		rs.close();
	    st.close();
	    conn.close();
	    java.lang.System.out.println(array);
	    return array.toString();
	}
	
	@GET
	@Path("look/user/{email}")
	@Produces(MediaType.APPLICATION_JSON)
	public String lookUser(@PathParam("email") String e) throws Exception{
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("select email,Fname,Lname,biography from users where email='"+e+"'");
			JSONArray  jsonArray =ToJSON.toJSONArray(rs);
		    rs.close();
		    st.close();
		    conn.close();
		    //java.lang.System.out.println(jsonArray);
			return jsonArray.toString();
	}
	
	@POST	
	@Path("leave/{name}")
	public Response leave(@PathParam("name") String n) throws SQLException, URISyntaxException{
		Connection conn = DBClass.returnConnection();
		Statement st = conn.createStatement();
		int i = st.executeUpdate("delete from ug where uemail='"+user.getEmail()+"' and gname='"+n+"'");
		st.close();
	    conn.close();
		if(i>=0){
	    	URI uri=new URI("http://localhost:8080/WSProjet/Main.jsp");
	    	return Response.temporaryRedirect(uri).build();
	    	}
	    else 
	    	return Response.status(400).entity(null).build();
	}
	
	@POST
	@Path("comment/{name}")
	public Response comment(@FormParam("comment") String c,@PathParam("name") String n) throws SQLException, URISyntaxException{
		Connection conn = DBClass.returnConnection();
		PreparedStatement preStatement = conn.prepareStatement("insert into board(time,uemail,gname,content) values(?,?,?,?)");
        preStatement.setString(1, time());
        preStatement.setString(3, n);
        preStatement.setString(2, user.getEmail());
        preStatement.setString(4, c);
		int i = preStatement.executeUpdate();
		preStatement.close();
        if(i>=0){
	    	URI uri=new URI("http://localhost:8080/WSProjet/group1.jsp");
	    	return Response.temporaryRedirect(uri).build();
	    	}
	    else 
	    	return Response.status(400).entity(null).build();
	}
	
}
