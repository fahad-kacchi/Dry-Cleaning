<%@ page language="java" import="java.sql.*"%>

<%!
    static Connection con = null;
    static Statement stmt = null;
    static ResultSet rs = null;
    
    //------------------Mysql Database Configuration------------------
	static String PORT = "5432";
	static String DRIVER = "org.postgresql.Driver";
	static String USERNAME = "postgres";
	static String PASSWORD = "password";
	static String DB_NAME = "online_portal";
	static String URL = "jdbc:postgresql://localhost:" +PORT+ "/" +DB_NAME;
%>

<%!
    public static Connection fetchConnection(){
        try{
            Class.forName(DRIVER);
            con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch(Exception e){
        }
        return con;
    }
%>

<%!
    public static void closeConnection(){
        try{
            con.close();
        } catch(Exception e){
        }
    }
%>
