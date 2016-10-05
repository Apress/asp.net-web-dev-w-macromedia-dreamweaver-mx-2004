Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls

'CodeBehind Class for Header.ascx
Public Class Header
	Inherits System.Web.UI.UserControl
	
	Protected WithEvents lblHeaderText As Label
	
	Public Property Text() As String
		Get
			Return Me.lblHeaderText.Text
		End Get
		Set(ByVal Value As String)
			Me.lblHeaderText.Text = Value
		End Set
	End Property

End Class


'CodeBehind Class for Menu.ascx
Public Class Menu
	Inherits System.Web.UI.UserControl
	
	Sub Page_Load(Src As Object, E As EventArgs) Handles MyBase.Load
		Dim Ctl As Control
		For Each Ctl In Me.Controls
			If Ctl.GetType() Is GetType(System.Web.UI.HtmlControls.HtmlAnchor) Then
				Dim TheLink As System.Web.UI.HtmlControls.HtmlAnchor = Ctl
				Dim PageName As String = Request.Path()
				PageName = PageName.Substring(PageName.LastIndexOf("/") + 1)
				Dim LinkPage As String = TheLink.Href
				LinkPage = LinkPage.Substring(LinkPage.LastIndexOf("/") + 1)
				If LinkPage.ToLower().Equals(PageName.ToLower()) Then
					TheLink.Href = ""
					Exit For
				End If
			End If
		Next
	End Sub

End Class


'CodeBehind Class for BookRoom.aspx
Public Class BookRoom
	Inherits System.Web.UI.Page
	
	Protected WithEvents DsRooms As DreamweaverCtrls.DataSet
	Protected WithEvents DsBookedDays As DreamweaverCtrls.DataSet	
	protected WithEvents drpRooms As DropDownList
	Protected WithEvents CalAvailableDates As Calendar
	Protected WithEvents lblSelectedRoom As Label
	Protected WithEvents lblStatus As Label
	Protected WithEvents DateListBookedDays As DataList		
	Protected WithEvents btnBook As Button	
	Protected WithEvents btnSelectRange As Button	
	Protected WithEvents btnClear As Button		

	Dim SelectedDates As System.Collections.ArrayList	
	
	Sub Page_Init(Src As Object, E As EventArgs) Handles MyBase.Init
		Dim i as Integer
		For i = Page.Controls.Count-1 To 0 Step - 1
			If Page.Controls.Item(i).GetType() Is GetType(DreamweaverCtrls.PageBind) Then
				Page.Controls.RemoveAt(i)
			End If
		Next
	End Sub
	
	Sub Page_Load(Src As Object, E As EventArgs) Handles MyBase.Load
		
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
	
	Sub btnBook_Click(Src As Object, E As EventArgs) Handles btnBook.Click
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
	
	
	Sub btnSelectRange_Click(Src As Object, E As EventArgs) Handles btnSelectRange.Click
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
	
	Sub btnClear_Click(Src As Object, E As EventArgs) Handles btnClear.Click
		SelectedDates.Clear()
		lblStatus.Text = ""
	End Sub
	
	Function IsBooked(TheDate As System.DateTime) As Boolean
		Dim Dv As System.Data.DataView = Me.DsBookedDays.DefaultView
		Dv.RowFilter = "BookedDate = '" & TheDate & "'"
		Return Dv.Count > 0
	End Function
	
	Sub CalAvailableDates_PreRender(Src As Object, E As EventArgs) Handles CalAvailableDates.PreRender
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
	
	Sub DateListBookedDays_ItemCreated(Src As Object, E As System.Web.UI.WebControls.DatalistItemEventArgs) Handles DateListBookedDays.ItemCreated
		Dim BookedDate As DateTime = e.Item.DataItem
		Dim Lbl As Label = e.Item.FindControl("lblBookedDate")
		If IsBooked(BookedDate) Then
			Lbl.ForeColor = System.Drawing.Color.Red
		Else
			Lbl.ForeColor = System.Drawing.Color.Green
		End If	
	End Sub
	
	Sub CalAvailableDates_DayRender(sender As Object, e As System.Web.UI.WebControls.DayRenderEventArgs) Handles CalAvailableDates.DayRender
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

End Class


'CodeBehind Class for GetCustomerInfo.aspx
Public Class GetCustomerInfo
	Inherits System.Web.UI.Page
	
	Protected WithEvents DsCustomers As DreamweaverCtrls.DataSet
	Protected WithEvents Insert1 As DreamweaverCtrls.Insert	
	Protected WithEvents lblStatus As Label
	Protected WithEvents btnOk As Button
	Protected WithEvents Header1 As Header
	
	Dim CustomerID As String
	
	Sub Page_Load(Src As Object, E As EventArgs) Handles MyBase.Load
		If Not Page.IsPostBack Then
			If Request.QueryString("RoomID") Is Nothing Then
				lblStatus.Text = "No Room Selected"
				btnOk.Visible = False
				Exit Sub
			End If
		End If
	End Sub
	
	Sub btnOk_Click(Src As Object, E As EventArgs) Handles btnOk.Click
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
	
	Sub Insert1_Inserted(sender As Object, e As DreamweaverCtrls.InsertedEventArgs) Handles Insert1.Inserted
		CustomerID = e.Identity
	End Sub

End Class