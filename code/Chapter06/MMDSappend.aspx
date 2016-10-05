<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<MM:DataSet 
id="DataSet1"
runat="Server"
IsStoredProcedure="true"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_connWines") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_connWines") %>'
CommandText='<%# "qryInsertNewRow" %>'
Debug="true" CreateDataSet="false" 
></MM:DataSet>
<MM:PageBind runat="server" PostBackBind="true" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

</body>
</html>
