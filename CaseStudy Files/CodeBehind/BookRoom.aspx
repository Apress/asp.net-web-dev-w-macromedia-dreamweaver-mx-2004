<%@ Page Language="VB" inherits="BookRoom" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<MM:DataSet
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_ConStr") %>'
CommandText='<%# "SELECT RoomID, RoomName FROM tbl_Rooms" %>'
Debug="true"
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_ConStr") %>' 
id="DsRooms"
IsStoredProcedure="false"
runat="Server" manualmode="true"
></MM:DataSet>
<MM:DataSet 
id="DsBookedDays"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_ConStr") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_ConStr") %>'
CommandText='<%# "SELECT *  FROM qry_BookedDays  WHERE Room = ? And BookedDate >= ?" %>'
Debug="true"
><Parameters>
  <Parameter  Name="@Room"  Value='<%# Me.drpRooms.SelectedItem.Value   %>'  Type="Integer"   />  
  <Parameter  Name="@BookedDate"  Value='<%# DateTime.Now  %>'  Type="DBDate"   />  
</Parameters></MM:DataSet>
<mm:pagebind runat="server" PostBackBind="true" Ignore="false"></mm:pagebind>
<%@ Register TagPrefix="CaseStudy" TagName="Header" Src="Header.ascx" %>
<%@ Register TagPrefix="CaseStudy" TagName="Menu" Src="Menu.ascx" %>
<%@ Register TagPrefix="CaseStudy" TagName="Footer" Src="Footer.ascx" %>
<html>
<head>
<title>Apress Hotel Book A Room</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<CaseStudy:Header id="Header1" runat="server" text="Book A Room"></CaseStudy:Header>

<table width="750"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="130" align="center" valign="top" bgcolor="#CCCCCC"><CaseStudy:Menu id="Menu1" runat="server"></CaseStudy:Menu></td>
    <td width="620" valign="top"><form runat="server">
	 <br> 	
	 <table border="0" align="center">
      <tr>
        <td colspan="2">Select Room : 
            <asp:DropDownList AutoPostBack="true" ID="drpRooms" runat="server"></asp:DropDownList>
          </td></tr>
      <tr>
        <td colspan="2"></td>
      </tr>
      <tr valign="top">
        <td>&nbsp;</td>
        <td align="center">&nbsp;</td>
      </tr>
      <tr valign="top">
        <td><strong>Available Dates for : 
            <asp:label ID="lblSelectedRoom" runat="server"></asp:label>
        </strong></td>
        <td align="center">&nbsp;</td>
      </tr>
      <tr valign="top">
        <td>&nbsp;</td>
        <td align="center">&nbsp;</td>
      </tr>
      <tr valign="top">
        <td><ul>
          <li>Red Text = Room Already Booked</li>
          <li>              Green background = Your Selections</li>
          <li>              Red background = Your Selections but Room already booked</li>
        </ul>        </td>
        <td align="center">Green text = Date is Available<br>
          Red text = Date is Unavailable</td>
      </tr>
      <tr valign="top">
        <td><asp:Calendar ID="CalAvailableDates" runat="server"></asp:Calendar></td>
        <td><asp:DataList CellPadding="5" ID="DateListBookedDays" RepeatColumns="3" RepeatDirection="Horizontal" RepeatLayout="Table" runat="server" >
          <itemtemplate>
            <asp:Label ID="lblBookedDate" Text="<%# Container.DataItem.ToShortDateString() %>" runat="server"></asp:Label>
          </itemtemplate></asp:DataList></td>
      </tr>
      <tr>
        <td colspan="2"><asp:Button ID="btnBook" runat="server" Text="Book Now" />
          <asp:Button ID="btnSelectRange" runat="server" Text="Select Range" />
          <asp:Button ID="btnClear" runat="server" Text="Select  None" />                    
          <asp:Label ForeColor="#FF0000" ID="lblStatus" runat="server" /></td></tr>
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
    </table>
    </form>	
    </td>
  </tr>
</table>
<CaseStudy:Footer id="Footer1" runat="server"></CaseStudy:Footer>
</body>
</html>