<%@ Page Language="VB" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<MM:DataSet 
id="DsRoomDetails"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_ConStr") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_ConStr") %>'
CommandText='<%# "SELECT * FROM qry_Rooms WHERE RoomID = ?" %>'
Debug="true"
>
  <Parameters>
    <Parameter  Name="@RoomID"  Value='<%# IIf((Request.QueryString("RoomID") <> Nothing), Request.QueryString("RoomID"), "") %>'  Type="Integer"   />    </Parameters>
</MM:DataSet>
<MM:PageBind runat="server" PostBackBind="true" />
<%@ Register TagPrefix="CaseStudy" TagName="Header" Src="Header.ascx" %>
<%@ Register TagPrefix="CaseStudy" TagName="Menu" Src="Menu.ascx" %>
<%@ Register TagPrefix="CaseStudy" TagName="Footer" Src="Footer.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Apress Hotel Room Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body> 
<CaseStudy:Header id="Header1" Text='<%# DsRoomDetails.FieldValue("RoomName", Container) & " : Room Details" %>' runat="server"></CaseStudy:Header> 
<table width="750"  border="0" cellpadding="0" cellspacing="0"> 
  <tr> 
    <td width="130" align="center" valign="top" bgcolor="#CCCCCC"><CaseStudy:Menu id="Menu1" runat="server"></CaseStudy:Menu></td> 
    <td width="620" valign="top"><br> 
      <table width="600" border="0" align="center"> 
        <tr> 
          <td><table  border="0">
            <tr>
              <td width="101" align="right"><strong>RoomNo:</strong></td>
              <td width="238"><%# DsRoomDetails.FieldValue("RoomNo", Container) %></td>
              <td width="264" rowspan="5" align="center"><img src="Images/<%# DsRoomDetails.FieldValue("RoomID", Container) %>.gif"></td>
            </tr>
            <tr>
              <td align="right"><strong>RoomName:</strong></td>
              <td><%# DsRoomDetails.FieldValue("RoomName", Container) %></td>
              </tr>
            <tr>
              <td align="right"><strong>EnSuite:</strong></td>
              <td><%# DsRoomDetails.FieldValue("EnSuite", Container).Replace("True", "Yes").Replace("False","No") %></td>
              </tr>
            <tr>
              <td align="right"><strong>CostPerNight:</strong></td>
              <td><%# Double.Parse(DsRoomDetails.FieldValue("CostPerNight", Container)).ToString("C") %></td>
              </tr>
            <tr>
              <td align="right"><strong>RoomType:</strong></td>
              <td><%# DsRoomDetails.FieldValue("RoomTypeText", Container) %></td>
              </tr>
            <tr>
              <td align="right" valign="top"><strong>Description:</strong></td>
              <td colspan="3"><table width="500"  border="0" align="center">
                <tr>
                  <td><%# DsRoomDetails.FieldValue("Description", Container).Replace(VbCrLf, "<br>") %></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td align="right">&nbsp;</td>
              <td colspan="3"><a href="BookRoom.aspx?RoomID=<%# DsRoomDetails.FieldValue("RoomID", Container) %>">Book This Room</a></td>
            </tr>
          </table>          </td>
        </tr> 
      </table></td> 
  </tr> 
</table> 
<CaseStudy:Footer id="Footer1" runat="server"></CaseStudy:Footer>
</body>
</html>
