<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<MM:DataSet 
id="DataSet1"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_connWines") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_connWines") %>'
CommandText='<%# "SELECT *  FROM tblWines" %>'
Debug="true" PageSize="10" CurrentPage='<%# IIf((Request.QueryString("DataSet1_CurrentPage") <> Nothing), Request.QueryString("DataSet1_CurrentPage"), 0)  %>'
></MM:DataSet>
<MM:PageBind runat="server" PostBackBind="true" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body><div align="center">
    <table border="1">
<ASP:Repeater runat="server" DataSource='<%# DataSet1.DefaultView %>'>
  <ItemTemplate>
      <tr><td><%# DataSet1.FieldValue("WineName", Container).ToUpper() %>
      </td></tr>
  </ItemTemplate>
</ASP:Repeater>
</table>

    <table border="0" width="50%" align="center">
      <tr>
        <td width="23%" align="center">
          <MM:If runat="server" Expression='<%# (DataSet1.CurrentPage <> 0) %>'>
            <ContentsTemplate> <a href="<%# Request.ServerVariables("SCRIPT_NAME") %>?DataSet1_currentPage=0">First</a> </ContentsTemplate>
          </MM:If>
        </td>
        <td width="31%" align="center">
          <MM:If runat="server" Expression='<%# (DataSet1.CurrentPage <> 0) %>'>
            <ContentsTemplate> <a href="<%# Request.ServerVariables("SCRIPT_NAME") %>?DataSet1_currentPage=<%# Math.Max(DataSet1.CurrentPage - 1, 0) %>">Previous</a> </ContentsTemplate>
          </MM:If>
        </td>
        <td width="23%" align="center">
          <MM:If runat="server" Expression='<%# (DataSet1.CurrentPage < DataSet1.LastPage) %>'>
            <ContentsTemplate> <a href="<%# Request.ServerVariables("SCRIPT_NAME") %>?DataSet1_currentPage=<%# Math.Min(DataSet1.CurrentPage + 1, DataSet1.LastPage) %>">Next</a> </ContentsTemplate>
          </MM:If>
        </td>
        <td width="23%" align="center">
          <MM:If runat="server" Expression='<%# (DataSet1.CurrentPage < DataSet1.LastPage) %>'>
            <ContentsTemplate> <a href="<%# Request.ServerVariables("SCRIPT_NAME") %>?DataSet1_currentPage=<%# DataSet1.LastPage %>">Last</a> </ContentsTemplate>
          </MM:If>
        </td>
      </tr>
    </table></div>
</body>
</html>
