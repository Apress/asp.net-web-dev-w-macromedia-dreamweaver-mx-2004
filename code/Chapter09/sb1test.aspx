<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<MM:DataSet 
id="DataSet1"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_connPortfolios") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_connPortfolios") %>'
CommandText='<%# "SELECT * FROM tblMembers" %>'
Debug="true" PageSize="10" CurrentPage='<%# IIf((Request.QueryString("DataSet1_CurrentPage") <> Nothing), Request.QueryString("DataSet1_CurrentPage"), 0)  %>'
></MM:DataSet>
<MM:PageBind runat="server" PostBackBind="true" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<table width="75%" border="1" cellspacing="0" cellpadding="5">
  <tr> 
    <td> <div align="center"><font color="#FF0000" size="2" face="Arial, Helvetica, sans-serif"><strong>Account 
        holders list</strong></font></div></td>
  </tr>
  <tr> 
    <td> <form runat="server">
        <div align="center"> 
          <ASP:Repeater runat="server" DataSource='<%# DataSet1.DefaultView %>'> 
            <ItemTemplate>The 
              account number 
              <%# DataSet1.FieldValue("AccNumber", Container) %>
              has a balance of 
              <%# DataSet1.FieldValue("AccCurrency", Container) & Double.Parse(DataSet1.FieldValue("AccBalance", Container)).ToString("n")  %>
              <br>
            </ItemTemplate>
          </ASP:Repeater>
        </div>
      </form></td>
  </tr>
</table>
</body>
</html>
