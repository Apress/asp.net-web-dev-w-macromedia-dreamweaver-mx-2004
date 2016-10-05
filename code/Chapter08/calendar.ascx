<%@ Control language="vb" Debug="true" Inherits="System.Web.UI.UserControl" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web.UI" %>

<script runat="server">
' Created by Costas Hadjisotiriou, costas_h@yahoo.com, (c)2002
' Use freely if you include this header, thank you
	Private _daycolor As String ="#FFFFFF"
	Private _daynamecolor As String ="#FF0000"
	Private _wkndcolor As String ="#00FF00"
	Private _selectedcolor As String ="#FF0000"
	Private _enabled As Boolean =True
	Private _prompt As String ="Use calendar for date selection"
	Private _prevmonthtext As String ="<"
	Private _nextmonthtext As String =">"
	Private _selecteddate As String

	Public Property SelectedDate() As String
		Get
			Return _selecteddate
		End Get
		Set
			_selecteddate = value
		End Set
	End Property
	Public Property DayColor() As String
		Get
			Return _daycolor
		End Get
		Set
			_daycolor = value
		End Set
	End Property
	Public Property DayNameColor() As String
		Get
			Return _daynamecolor
		End Get
		Set
			_daynamecolor = value
		End Set
	End Property
	Public Property WkndColor() As String
		Get
			Return _wkndcolor
		End Get
		Set
			_wkndcolor = value
		End Set
	End Property
	Public Property SelectedColor() As String
		Get
			Return _selectedcolor
		End Get
		Set
			_selectedcolor = value
		End Set
	End Property

	Public Property Enabled() As String
		Get
			Return _enabled
		End Get
		Set
			_enabled = value
		End Set
	End Property
	Public Property Prompt() As String
		Get
			Return _prompt
		End Get
		Set
			_prompt = value
		End Set
	End Property
	Public Property PrevMonthText() As String
		Get
			Return _prevmonthtext
		End Get
		Set
			_prevmonthtext = value
		End Set
	End Property
	Public Property NextMonthText() As String
		Get
			Return _nextmonthtext
		End Get
		Set
			_nextmonthtext = value
		End Set
	End Property

Sub Page_Load()

If (Enabled()) Then
	Dim strOut As String = " "
	Dim location As String
	Const keyIncludedScript As String = "ScriptToInclude"
	Dim currentCapabilities As System.Web.Mobile.MobileCapabilities
 	currentCapabilities = Request.Browser
	
	If (currentCapabilities.HasCapability("preferredRenderingMime", "text/vnd.wap.wml")) Then
		Dim cellcount As Integer
		Dim i As Integer
		Dim k As Integer

		'strOut &= "<onevent type=""onenterforward""><refresh><setvar name=""selD"" value=""" & SelectedDate() & """ /></refresh></onevent>"
		strOut &= "<p align=""right"">Selected date: $(selD)<br/><a href=""c.asp#drawCal('c')"">(draw calendar below)</a>"
		strOut &= "<br/><a href=""c.asp#drawCal('p')"">&lt;</a>$(currMN)($(currM)/$(currY))<a href=""c.asp#drawCal('n')"">&gt;</a>"
		strOut &= "<br/> M- T- W- T- F- S- S-<br/>"

		For i=0 To 5
			For k=1 To 7
				cellcount = (i*7) + k
				strOut &= "<a href=""c.asp#d(" & cellcount & ")"">$(a" & cellcount & ")</a>-"
			Next
			strOut &= "<br/>"
		Next
		strOut &= "<br/>[$(cmin)][$(cmax)]</p>"

		lblTest.Text = strOut
	Else
		If (TypeOf(Page) Is System.Web.UI.MobileControls.MobilePage) Then
			strOut &= "<scr" & "ipt language=""javascript"" src=""c.js"" ></scr" & "ipt>" & vbCrLf
		Else
			If Not Page.IsClientScriptBlockRegistered(keyIncludedScript) Then     
				If (location Is Nothing) Then
					location = "<scr" & "ipt language=""javascript"" src=""c.js"" ></scr" & "ipt>" & vbCrLf
				End If
			        Page.RegisterClientScriptBlock(keyIncludedScript, location)
			End If
		End If
		strOut &= "<table border=0 cellpadding=5 cellspacing=0 ><tr><td bgcolor=""#FFFFFF"" valign=top><font face=""Tahoma"" size=""2"" color=""#0022DD"" ><b>"
		strOut &= Prompt()
		strOut &= ":<br><INPUT type=""text"" id="""
		strOut &= Id()
		strOut &= """ name="""
		strOut &= Id()
		strOut &= """ value="""
		If Not IsNothing(SelectedDate()) Then
			strOut &= SelectedDate() 
		End If
		strOut &= """ /></td></tr><tr><td bgcolor=""#FFFFFF""><table bgcolor=""#00309C"" cellspacing=0 cellpadding=0 ><tr><td align=""left"" width=""20%"">"
		strOut &= "<a href=""javascript:CalCalling='Cal"
		strOut &= Id()
		strOut &= "';getprevcal('"
		strOut &= Id()
		strOut &="')""><font face=""Tahoma"" size=""2"" color=""#FFFFFF"" ><b>"
		strOut &= PrevMonthText()
		strOut &= "</b></font></a></td><td align=""center""><font face=""Tahoma"" size=""2"" color=""#FFFFFF"" ><b><DIV id="""
		strOut &= Id()
		strOut &= "Mname"" ></DIV></b></font></td><td align=""right"" width=""20%""><a href=""javascript:CalCalling='Cal"
		strOut &= Id()
		strOut &= "';getnextcal('"
		strOut &= Id()
		strOut &= "')""><font face=""Tahoma"" size=""2"" color=""#FFFFFF"" ><b>"
		strOut &= NextMonthText()
		strOut &= "</b></font></a></td></tr><tr><td colspan=3 bgcolor=""#FFFFFF""><DIV id="""
		strOut &= Id()
		strOut &= "CalPlace"" onClick=""javascript:CalCalling='Cal"
		strOut &= Id()
		strOut &= "';""></DIV></td></tr></table></td></tr></table>" & vbCrLf
		strOut &= "<scr" & "ipt language=""javascript"" >" & vbCrLf
		strOut &= "var str" & Id() & "DayColor = '" & DayColor() & "';" & vbCrLf
		strOut &= "var str" & Id() & "DayNameColor = '" & DayNameColor() & "';" & vbCrLf
		strOut &= "var str" & Id() & "WkndColor = '" & WkndColor() & "';" & vbCrLf
		strOut &= "var str" & Id() & "SelectedColor = '" & SelectedColor() & "';" & vbCrLf
		If Not IsNothing(SelectedDate()) Then
			strOut &= "var str" & Id() & "SelectedDay = '" & Format(CDate("#" & SelectedDate() & "#"), "dd") & "';" & vbCrLf 
			strOut &= "var str" & Id() & "SelectedYM = '" & Format(CDate("#" & SelectedDate() & "#"), "yyyyMM") & "';" & vbCrLf
		Else
			strOut &= "var str" & Id() & "SelectedDay = ''; " &vbCrLf & "var str" & Id() & "SelectedYM = '';" & vbCrLf
		End If
		strOut &= "</scr" & "ipt>"
		strOut &= "<scr" & "ipt language=""javascript"" >initcal('" & Id() & "');</scr" & "ipt>" & vbCrLf

		lblTest.Text = strOut
	End If

End If
End Sub
</script>
<asp:Literal id="lblTest" runat="server"></asp:Literal>

