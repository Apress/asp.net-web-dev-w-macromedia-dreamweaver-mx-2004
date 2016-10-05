<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>

<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Threading" %>

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
    <td> <div align="center"><font color="#FF0000" size="2" face="Arial, Helvetica, sans-serif"><strong>Lista dei clienti</strong></font></div></td>
  </tr>
  <tr> 
    <td> <form runat="server">
        <div align="center"> 

<%
' our website caters for Italian customers only - create a culture object to compare to user's culture
Dim cultOursite As String
cultOursite = "it-IT"
' the user's preferred local culture (language, date format etc.)
Dim cultLocal As CultureInfo
' we need to take a first guess at the user's locale from browser info
cultLocal = CultureInfo.CreateSpecificCulture(Request.UserLanguages(0))
' start of condition
If (cultLocal.toString()=cultOursite) Then
	' assign the culture information object to the current sessions thread
	Thread.CurrentThread.CurrentCulture = cultLocal
	Thread.CurrentThread.CurrentUICulture = cultLocal
	' display the data with a welcome message
	Response.Write("<b>Benvenuti, questi sono suoi posizioni oggi:</b><br>")
%>

          <ASP:Repeater runat="server" DataSource='<%# DataSet1.DefaultView %>'> 
            <ItemTemplate>Su conto con numero  
              <%# DataSet1.FieldValue("AccNumber", Container) %>
              ha una cantitá di  
              <%# DataSet1.FieldValue("AccCurrency", Container) & Double.Parse(DataSet1.FieldValue("AccBalance", Container)).ToString("n")  %>
              <br>
            </ItemTemplate>
          </ASP:Repeater>

<%
 Else
 	Response.Write("Please click here for our International Customer Service website.")
' end of conditional table
 End If 
%>

        </div>
      </form></td>
  </tr>
</table>
</body>
</html>
