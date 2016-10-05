Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls

Public Class ColorPage
	Inherits Page
    
	Public ColorList As DropDownList
	Public ColorList2 As DropDownList
	Public welcomeMessage As Label
	Public Calendar1 As Calendar

	sub Page_Load()
		If Not IsPostback Then
			welcomeMessage.Text="Select a background color."
		End If
		AddHandler ColorList.SelectedIndexChanged, AddressOf Me.ColorChanged
		AddHandler ColorList2.SelectedIndexChanged, AddressOf Me.ColorChanged2
	end sub
	sub ColorChanged(sender As Object, e As EventArgs)
		Calendar1.DayStyle.BackColor = System.Drawing.Color.FromName(sender.SelectedItem.Value)
		welcomeMessage.Text="You last selected " & sender.SelectedItem.Value & ". Now select another color."
	end sub
	sub ColorChanged2(sender As Object, e As EventArgs)
		Calendar1.WeekendDayStyle.BackColor = System.Drawing.Color.FromName(sender.SelectedItem.Value)
		welcomeMessage.Text="You last selected " & sender.SelectedItem.Value & ". Now select another color."
	end sub

end Class

