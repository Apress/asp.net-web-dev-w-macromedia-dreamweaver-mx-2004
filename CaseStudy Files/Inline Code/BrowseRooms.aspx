<%@ Page Language="VB" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<MM:DataSet 
id="DsRooms"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_ConStr") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_ConStr") %>'
CommandText='<%# "SELECT * FROM qry_Rooms" %>'
Debug="true"
></MM:DataSet>
<MM:PageBind runat="server" PostBackBind="true" />
<%@ Register TagPrefix="CaseStudy" TagName="Header" Src="Header.ascx" %>
<%@ Register TagPrefix="CaseStudy" TagName="Menu" Src="Menu.ascx" %>
<%@ Register TagPrefix="CaseStudy" TagName="Footer" Src="Footer.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Apress Browse Rooms</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body> 
<CaseStudy:Header id="Header1" Text="Browse Rooms" runat="server"></CaseStudy:Header> 
<table width="750"  border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
    <td width="130" align="center" valign="top" bgcolor="#CCCCCC"><CaseStudy:Menu id="Menu1" runat="server"></CaseStudy:Menu></td> 
    <td width="620" valign="top"><br> 
      <table width="600" border="0" align="center"> 
        <tr> 
          <td><table width="610"  border="0"> 
              <tr>
                <td><strong>Room No</strong></td> 
                <td><strong>RoomName</strong></td> 
                <td><strong>EnSuite</strong></td> 
                <td><strong>RoomType</strong></td> 
                <td><strong>CostPerNight</strong></td> 
                <td>&nbsp;</td> 
              </tr> 
              <ASP:Repeater runat="server" DataSource='<%# DsRooms.DefaultView %>'> 
                <ItemTemplate> 
                  <tr>
                    <td><%# DsRooms.FieldValue("RoomNo", Container) %></td> 
                    <td><%# DsRooms.FieldValue("RoomName", Container) %></td> 
                    <td><%# DsRooms.FieldValue("EnSuite", Container).Replace("True", "Yes").Replace("False","No") %></td> 
                    <td><%# DsRooms.FieldValue("RoomTypeText", Container) %></td> 
                    <td><%# Double.Parse(DsRooms.FieldValue("CostPerNight", Container)).ToString("C") %></td> 
                    <td><a href="RoomDetails.aspx?RoomID=<%# DsRooms.FieldValue("RoomID", Container) %>">More...</a></td> 
                  </tr> 
                </ItemTemplate> 
              </ASP:Repeater> 
          </table></td></tr> 
      </table></td> 
  </tr> 
</table> 
<CaseStudy:Footer id="Footer1" runat="server"></CaseStudy:Footer> 
</body>
</html>
