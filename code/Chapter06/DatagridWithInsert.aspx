<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<MM:Insert
runat="server"
IsStoredProcedure="true"
CommandText='<%# "qryInsertNewWine" %>'
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_connWines") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_connWines") %>'
Expression='<%# Request.Form("MM_insert") = "form1" and Request.Form("WineName") <> Nothing %>'
CreateDataSet="false"
Debug="true"
>
  <Parameters>
    <Parameter Name="@WineName" Value='<%# IIf((Request.Form("WineName") <> Nothing), Request.Form("WineName"), "") %>' Type="WChar" />
    <Parameter Name="@WineMaker" Value='<%# IIf((Request.Form("WineMaker") <> Nothing), Request.Form("WineMaker"), "") %>' Type="WChar" />
    <Parameter Name="@WineGrape" Value='<%# IIf((Request.Form("WineGrape") <> Nothing), Request.Form("WineGrape"), "") %>' Type="WChar" />
    <Parameter Name="@WineColor" Value='<%# IIf((Request.Form("WineColor") <> Nothing), Request.Form("WineColor"), "") %>' Type="WChar" />
    <Parameter Name="@WineYear" Value='<%# IIf((Request.Form("WineYear") <> Nothing), Request.Form("WineYear"), "") %>' Type="WChar" />
    <Parameter Name="@WineTastingComments" Value='<%# IIf((Request.Form("WineTastingComments") <> Nothing), Request.Form("WineTastingComments"), "") %>' Type="WChar" />
  </Parameters>
</MM:Insert>
<MM:DataSet 
id="DataSet2"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_connWines") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_connWines") %>'
CommandText='<%# "select * from tblWines" %>'
Debug="true" PageSize="10" 
>
</MM:DataSet>
<MM:PageBind runat="server" PostBackBind="true" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)
If IsPostBack Then
WineName.Text=""
End If
End Sub
</script></head>
<body>
  <form method="post" name="form1" runat="server">
  <asp:DataGrid id="DataGrid1" 
  runat="server" 
  AllowSorting="False" 
  AutoGenerateColumns="false" 
  CellPadding="3" 
  CellSpacing="0" 
  ShowFooter="false" 
  ShowHeader="true" 
  DataSource="<%# DataSet2.DefaultView %>" 
  PagerStyle-Mode="NumericPages" 
  AllowPaging="true" 
  AllowCustomPaging="true" 
  PageSize="<%# DataSet2.PageSize %>" 
  VirtualItemCount="<%# DataSet2.RecordCount %>" 
  OnPageIndexChanged="DataSet2.OnDataGridPageIndexChanged"  
>
    <HeaderStyle HorizontalAlign="center" BackColor="#E8EBFD" ForeColor="#3D3DB6" Font-Name="Verdana, Arial, Helvetica, sans-serif" Font-Bold="true" Font-Size="smaller" />  
    <ItemStyle BackColor="#F2F2F2" Font-Name="Verdana, Arial, Helvetica, sans-serif" Font-Size="smaller" />  
    <AlternatingItemStyle BackColor="#E5E5E5" Font-Name="Verdana, Arial, Helvetica, sans-serif" Font-Size="smaller" />  
    <FooterStyle HorizontalAlign="center" BackColor="#E8EBFD" ForeColor="#3D3DB6" Font-Name="Verdana, Arial, Helvetica, sans-serif" Font-Bold="true" Font-Size="smaller" />  
    <PagerStyle BackColor="white" Font-Name="Verdana, Arial, Helvetica, sans-serif" Font-Size="smaller" />  
    <Columns>
    <asp:BoundColumn DataField="WineID" 
        HeaderText="WineID" 
        ReadOnly="true" 
        Visible="True"/>  
    <asp:BoundColumn DataField="WineName" 
        HeaderText="WineName" 
        ReadOnly="true" 
        Visible="True"/>  
    <asp:BoundColumn DataField="WineMaker" 
        HeaderText="WineMaker" 
        ReadOnly="true" 
        Visible="True"/>  
    <asp:BoundColumn DataField="WineGrape" 
        HeaderText="WineGrape" 
        ReadOnly="true" 
        Visible="True"/>  
    <asp:BoundColumn DataField="WineColor" 
        HeaderText="WineColor" 
        ReadOnly="true" 
        Visible="True"/>  
    <asp:BoundColumn DataField="WineYear" 
        HeaderText="WineYear" 
        ReadOnly="true" 
        Visible="True"/>  
    <asp:BoundColumn DataField="WineTastingComments" 
        HeaderText="WineTastingComments" 
        ReadOnly="true" 
        Visible="True"/>  
  </Columns>
  </asp:DataGrid><br>
<table align="center" width="780">
    <tr valign="baseline">
      <td nowrap align="right">WineColor:</td>
      <td>
        <asp:textbox id="WineColor" TextMode="SingleLine" Columns="32" runat="server"  EnableViewState="false"/>
      </td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">WineGrape:</td>
      <td>
        <asp:textbox id="WineGrape" TextMode="SingleLine" Columns="32" runat="server" EnableViewState="false"/>
      </td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">WineMaker:</td>
      <td>
        <asp:textbox id="WineMaker" TextMode="SingleLine" Columns="32" runat="server" EnableViewState="false"/>
      </td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">WineName:</td>
      <td>
        <asp:textbox id="WineName" TextMode="SingleLine" Columns="32" runat="server" EnableViewState="false"/>
      </td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">WineTastingComments:</td>
      <td>
        <asp:textbox id="WineTastingComments" TextMode="SingleLine" Columns="32" runat="server" EnableViewState="false"/>
      </td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">WineYear:</td>
      <td>
        <asp:textbox id="WineYear" TextMode="SingleLine" Columns="32" runat="server" EnableViewState="false"/>
      </td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">&nbsp;</td>
      <td><input type="submit" value="Insert record"></td>
    </tr>
  </table>
  <input type="hidden" name="MM_insert" value="form1">
</form>
<p>&nbsp;</p>
</body>
</html>
