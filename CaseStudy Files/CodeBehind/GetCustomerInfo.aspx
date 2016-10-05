<%@ Page Language="VB" inherits="GetCustomerInfo" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<MM:Insert
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_ConStr") %>'
CommandText='<%# "INSERT INTO tbl_Customers (EmailAddress, FirstName, LastName) VALUES (?, ?, ?)" %>'
CreateDataSet="false"
Debug="true"
Expression='<%# Request.Form("MM_insert") = "form1" %>'
runat="server" id="Insert1"
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_ConStr") %>' manualmode="true"
>
  <Parameters>
    <Parameter Name="@EmailAddress" Value='<%# IIf((Request.Form("txtEmailAddress") <> Nothing), Request.Form("txtEmailAddress"), "") %>' Type="WChar" />
    <Parameter Name="@FirstName" Value='<%# IIf((Request.Form("txtFirstName") <> Nothing), Request.Form("txtFirstName"), "") %>' Type="WChar" />
    <Parameter Name="@LastName" Value='<%# IIf((Request.Form("txtLastName") <> Nothing), Request.Form("txtLastName"), "") %>' Type="WChar" />
  </Parameters>
</MM:Insert>
<MM:DataSet
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_ConStr") %>'
CommandText='<%# "SELECT * FROM tbl_Customers WHERE EmailAddress = ?" %>'
Debug="true"
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_ConStr") %>' 
id="DsCustomers"
IsStoredProcedure="false"
runat="Server" manualmode="true"
>
  <Parameters>
    <Parameter  Name="@EmailAddress"  Value='<%# IIf((Request.Form("txtEmailAddress") <> Nothing), Request.Form("txtEmailAddress"), "") %>'  Type="WChar"   />
  </Parameters>
</MM:DataSet>
<MM:PageBind runat="server" PostBackBind="true" />
<%@ Register TagPrefix="CaseStudy" TagName="Header" Src="Header.ascx" %>
<%@ Register TagPrefix="CaseStudy" TagName="Menu" Src="Menu.ascx" %>
<%@ Register TagPrefix="CaseStudy" TagName="Footer" Src="Footer.ascx" %>
<script runat="server">

Dim CustomerID As String

Sub Page_Load(Src As Object, E As EventArgs)
	If Not Page.IsPostBack Then
		If Request.QueryString("RoomID") Is Nothing Then
			lblStatus.Text = "No Room Selected"
			btnOk.Visible = False
			Exit Sub
		End If
	End If
End Sub

Sub btnOk_Click(Src As Object, E As EventArgs)
	DsCustomers.DoInit()
	If DsCustomers.RecordCount > 0 Then
		CustomerID = DsCustomers.FieldValue("CustomerID")
	Else
		Insert1.DoInit()
	End If
	InsertBookedDates()
End Sub

Sub InsertBookedDates()
	Dim ObjCmd As System.Data.OleDb.OleDbCommand	
	Dim SelectedDates As System.Collections.ArrayList
	
	If Not Session("SelectedDates") Is Nothing Then
		SelectedDates = Session("SelectedDates")
		If SelectedDates.Count = 0 Then
			lblStatus.Text = "You have not booked any dates"
			Exit Sub
		End If
	Else
		lblStatus.Text = "You have not booked any dates"
		Exit Sub		
	End If
	
	ObjCmd = New System.Data.OleDb.OleDbCommand("INSERT INTO [tbl_Bookings] ([Customer],[Room]) VALUES(?,?)", DsCustomers.myConnection)
	ObjCmd.Parameters.Add("Customer", CustomerID)
	ObjCmd.Parameters.Add("Room", Request.QueryString("RoomID"))
	ObjCmd.ExecuteNonQuery()
	
	ObjCmd.Parameters.Clear()
	
	ObjCmd.CommandText = "SELECT @@Identity"
	Dim BookingID As String = ObjCmd.ExecuteScalar()
	
	ObjCmd.CommandText = "INSERT INTO [tbl_BookedDays] ([BookingID],[BookedDate]) VALUES(?,?)"
	ObjCmd.Parameters.Add("BookingID", BookingID)
	ObjCmd.Parameters.Add("BookedDate", "")
		
	Dim SelectedDate As DateTime
	For each SelectedDate In SelectedDates
		ObjCmd.Parameters.Item("BookedDate").Value = SelectedDate
		ObjCmd.ExecuteNonQuery()
	Next	
	
	Session.Remove("SelectedDates")
	
	Me.lblStatus.ForeColor = System.Drawing.Color.Green
	Me.lblStatus.Text = "Your Booking has been placed, Thank You."
	Me.btnOk.Visible = False
	Me.Header1.Text = "Booking placed!"
				
End Sub

</script>
<script runat="server">
	Sub Insert1_Inserted(sender As Object, e As DreamweaverCtrls.InsertedEventArgs)
		CustomerID = e.Identity
	End Sub
</script>
<html>
<head>
<title>Apress Hotel Book Room</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body><form method='POST' enctype="application/x-www-form-urlencoded" name='form1' id="form1" runat='server'>
<CaseStudy:Header id="Header1" runat="server" Text="Finalize Booking"></CaseStudy:Header>

<table width="750"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="130" align="center" valign="top" bgcolor="#CCCCCC"><CaseStudy:Menu id="Menu1" runat="server"></CaseStudy:Menu></td>
    <td width="620" valign="top"><br>
      <table width="437" border="0" align="center">
      <tr>
        <td width="116" align="right">FirstName</td>
        <td width="311"><asp:TextBox ID="txtFirstName" runat="server" />
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" EnableClientScript="true" Display="Dynamic" ErrorMessage="Required" ControlToValidate="txtFirstName" runat="server"></asp:RequiredFieldValidator></td>
      </tr>
      <tr>
        <td align="right">LastName</td>
        <td><asp:TextBox ID="txtLastName" runat="server" />
          <asp:RequiredFieldValidator ID="RequiredFieldValidator2" EnableClientScript="true" Display="Dynamic" ErrorMessage="Required" ControlToValidate="txtLastName" runat="server"></asp:RequiredFieldValidator></td>
      </tr>
      <tr>
        <td align="right">EmailAddress</td>
        <td><asp:TextBox ID="txtEmailAddress" runat="server" />
          <asp:RequiredFieldValidator ID="RequiredFieldValidator3" EnableClientScript="true" Display="Dynamic" ErrorMessage="Required" ControlToValidate="txtEmailAddress" runat="server"></asp:RequiredFieldValidator></td>
      </tr>
      <tr>
        <td align="right">&nbsp;</td>
        <td><asp:Button ID="btnOk" Text="Place Booking" runat="server" />
          <asp:Label ForeColor="#FF0000" ID="lblStatus" runat="server" />          
          
          </td>
      </tr>
    </table>
      <br></td>
  </tr>
</table>
<CaseStudy:Footer id="Footer1" runat="server"></CaseStudy:Footer>
<input type="hidden" name="MM_insert" value="form1">
</form></body>
</html>