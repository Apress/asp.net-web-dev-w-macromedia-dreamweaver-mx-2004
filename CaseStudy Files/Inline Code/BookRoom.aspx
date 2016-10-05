<%@ Page Language="VB" %>
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script runat="server">

Dim SelectedDates As System.Collections.ArrayList

Sub Page_Init(Src As Object, E As EventArgs)
	Dim i as Integer
	For i = Page.Controls.Count-1 To 0 Step - 1
		If Page.Controls.Item(i).GetType() Is GetType(DreamweaverCtrls.PageBind) Then
			Page.Controls.RemoveAt(i)
		End If
	Next
End Sub

Sub Page_Load(Src As Object, E As EventArgs)
	
	If Not Session("SelectedDates") Is Nothing Then
		SelectedDates = Session("SelectedDates")
	Else
		SelectedDates = New System.Collections.ArrayList()
	End If
	
	If Not Page.IsPostBack Then
		DsRooms.DoInit()
		Me.drpRooms.DataSource = DsRooms.DefaultView
		Me.drpRooms.DataTextField = "RoomName"
		Me.drpRooms.DataValueField = "RoomID"
		Me.drpRooms.DataBind()
		
		If Not Request.QueryString("RoomID") Is Nothing Then
			Dim RoomID As String = Request.QueryString("RoomID")
			Dim Lst As ListItem
			For Each Lst In Me.drpRooms.Items
				If Lst.Value = RoomID Then
					Lst.Selected = True
					Exit For
				End If
			Next
		End If
		
		CalAvailableDates.VisibleDate = DateTime.Now
		CalAvailableDates.SelectedDate = DateTime.Now
	End If
	
	Me.DsBookedDays.DoInit()
	lblSelectedRoom.Text = drpRooms.SelectedItem.Text
	lblSelectedRoom.DataBind()		
		
End Sub

Sub btnBook_Click(Src As Object, E As EventArgs)
	Dim SelectedDate As DateTime
	if SelectedDates.Count = 0 Then
		lblStatus.Text = "You did not select any dates!"
		Exit Sub
	End If
	For each SelectedDate In SelectedDates
		If IsBooked(SelectedDate) Then
			lblStatus.Text = "Some of your selected dates are already booked!"
			Exit Sub
		End If
	Next
	Response.Redirect("GetCustomerInfo.aspx?RoomID=" & Me.drpRooms.SelectedItem.Value)
End Sub


Sub btnSelectRange_Click(Src As Object, E As EventArgs)
	If SelectedDates.Count = 2 Then
		SelectedDates.Sort()
		Dim CurrentDate As DateTime = SelectedDates.Item(0)
		Do While Not CurrentDate.Equals(SelectedDates.Item(1))
			CurrentDate = CurrentDate.AddDays(1)
			If Not SelectedDates.Contains(CurrentDate) Then
				SelectedDates.Add(CurrentDate)
			End If			
		Loop
		lblStatus.Text = ""
	Else
		lblStatus.Text = "To select a range 2 dates(the start and end) must be selected!"
	End If
End Sub

Sub btnClear_Click(Src As Object, E As EventArgs)
	SelectedDates.Clear()
	lblStatus.Text = ""
End Sub

Function IsBooked(TheDate As System.DateTime) As Boolean
	Dim Dv As System.Data.DataView = Me.DsBookedDays.DefaultView
	Dv.RowFilter = "BookedDate = '" & TheDate & "'"
	Return Dv.Count > 0
End Function

Sub CalAvailableDates_PreRender(Src As Object, E As EventArgs)
	If Page.IsPostBack Then
		If Request.Form("__EVENTTARGET").Equals(CalAvailableDates.ClientID) Then
			If Not Request.Form("__EVENTARGUMENT").SubString(0, 1).Equals("V") Then
				AddRemoveDate()
			End If
		End If		
	End If		
	Me.DateListBookedDays.DataSource = SelectedDates
	Me.DateListBookedDays.DataBind()	
End Sub

Sub DateListBookedDays_ItemCreated(Src As Object, E As System.Web.UI.WebControls.DatalistItemEventArgs)
	Dim BookedDate As DateTime = e.Item.DataItem
	Dim Lbl As Label = e.Item.FindControl("lblBookedDate")
	If IsBooked(BookedDate) Then
		Lbl.ForeColor = System.Drawing.Color.Red
	Else
		Lbl.ForeColor = System.Drawing.Color.Green
	End If	
End Sub

Sub CalAvailableDates_DayRender(sender As Object, e As System.Web.UI.WebControls.DayRenderEventArgs)
	If e.Day.Date <= DateTime.Now.AddDays(-1) Then
		e.Cell.Text = "<span style=""color:silver;"">" & e.Day.Date.Day & "<span>"
		Exit Sub
	End If
	If IsBooked(e.Day.Date) Then
		If SelectedDates.Contains(e.Day.Date) Then
			e.Cell.BackColor = System.Drawing.Color.Red		
		Else
			e.Cell.Text = e.Day.Date.Day
			e.Cell.ForeColor = System.Drawing.Color.Red
			e.Cell.BackColor = System.Drawing.Color.White			
		End If
	Else
		If SelectedDates.Contains(e.Day.Date) Then
			e.Cell.BackColor = System.Drawing.Color.Green
		End If		
	End If	
End Sub

Sub AddRemoveDate()
	If Not SelectedDates.Contains(CalAvailableDates.SelectedDate) Then
		SelectedDates.Add(CalAvailableDates.SelectedDate)
	Else
		SelectedDates.Remove(CalAvailableDates.SelectedDate)
	End If
	SelectedDates.Sort()
	Session("SelectedDates") = SelectedDates
	lblStatus.Text = ""
End Sub
	
</script>
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
        <td><asp:Calendar ID="CalAvailableDates" runat="server" OnPreRender="CalAvailableDates_PreRender" OnDayRender="CalAvailableDates_DayRender"></asp:Calendar></td>
        <td><asp:DataList CellPadding="5" ID="DateListBookedDays" RepeatColumns="3" RepeatDirection="Horizontal" RepeatLayout="Table" runat="server" OnItemCreated="DateListBookedDays_ItemCreated">
          <itemtemplate>
            <asp:Label ID="lblBookedDate" Text="<%# Container.DataItem.ToShortDateString() %>" runat="server"></asp:Label>
          </itemtemplate></asp:DataList></td>
      </tr>
      <tr>
        <td colspan="2"><asp:Button ID="btnBook" runat="server" Text="Book Now" OnClick="btnBook_Click" />
          <asp:Button ID="btnSelectRange" runat="server" Text="Select Range" OnClick="btnSelectRange_Click" />
          <asp:Button ID="btnClear" runat="server" Text="Select  None" OnClick="btnClear_Click" />                    
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