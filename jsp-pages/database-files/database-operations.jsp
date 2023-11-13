<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="common-database.jsp" %>
<%@include file="../utils/Constants.jsp" %>
<%@include file="../utils/key-value-class.jsp" %>

<%!
	public static boolean insertData(List<KeyValue> data, String primaryKey, String tableName, JspWriter out) throws Exception{
		boolean flag = false;
		try{
			String query = generateInsertQuery(data, primaryKey, tableName, out);
			con = fetchConnection();
			stmt = con.createStatement();
			stmt.executeUpdate(query);
			flag = true;
		} catch(Exception e){
			out.println(" INSERT DATA EXCEPTION: " +e);
		} finally {
			closeConnection();
		}
		return flag;
	}
%>

<%!
	public static String generateInsertQuery(List<KeyValue> data, String primaryKey, String tableName, JspWriter out) throws Exception{
		String query = "";
		try{
			query = "insert into "+tableName+" values('"+primaryKey+"'";
			for(KeyValue kv : data){  
				String key = kv.getKey();
				Object value = kv.getValue();
				if(key.equals(DTConstants.INTEGER)){
					query += ","+value;
				} else if(key.equals(DTConstants.STRING)){
					query += ",'"+value.toString()+"'";
				} else if(key.equals(DTConstants.FLOAT)){
					query += ","+value;
				} else if(key.equals(DTConstants.DOUBLE)){
					query += ","+value;
				}
			}  
			query += ")";
		} catch(Exception e){
			out.println(" INSERT DATA EXCEPTION: " +e);
		} finally {
		}
		return query;
	}
%>

<%!
    public static String generatePrimaryKey(String startingCharacter, String tableName, String primaryKey, JspWriter out) throws Exception{

      
         

        String id ="";
        try{

            con = fetchConnection();
             out.println("\nConnection is :" +con);
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select "+primaryKey+" from "+tableName+"";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                id = startingCharacter+"1";
            } else {
                rs.last();
                int intId = Integer.parseInt(rs.getString(primaryKey).split(startingCharacter)[1]);
                intId++;
                id = startingCharacter+intId;
            }
        } catch(Exception e){
            out.println(" Generate primary key exception:\n " +e);
        } finally {
            closeConnection();
        }
        return id;
    }
%>
