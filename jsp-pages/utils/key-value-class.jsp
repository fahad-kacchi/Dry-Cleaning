<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>

<%!
	public class KeyValue{
		private String key;
		private Object value;
		public KeyValue(String key, Object value){
			this.key = key;
			this.value = value;
		}
		public String getKey(){
			return this.key;
		}
		public Object getValue(){
			return this.value;
		}
		public void setKey(String key){
			this.key = key;
		}
		public void setValue(Object value){
			this.value = value;
		}
	}
%>