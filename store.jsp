<%@ page import="java.sql.*"%>
<%
String email=request.getParameter("email");
String password=request.getParameter("psw");
String repeatpassword=request.getParameter("psw-repeat");
String remember=request.getParameter("remember");
if(password.equals(repeatpassword)){
try(Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","suman","tiger")){
PreparedStatement ps =conn.prepareStatement("insert into Users(UserEmail,UserPassword)values(?,?)");
ps.setString(1,email);
ps.setString(2,password);
int x=ps.executeUpdate();
if(x!=0){
	out.print("login successfully");
	response.sendRedirect("login.html");
}else{
	out.print("somthing went wrong");
}
}catch(Exception e){
	out.print(e);
}
}else{
	out.print("password not matching");
}
%>