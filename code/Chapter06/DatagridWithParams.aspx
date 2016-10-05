<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<MM:DataSet 
id="DataSet1"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_connWines") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_connWines") %>'
CommandText='<%# "SELECT *  FROM tblWines  WHERE tblWines.WineYear>?" %>'
Debug="true" PageSize="10"
>
  <Parameters>
    <Parameter  Name="WhichYear"  Value='<%# IIf((Request.QueryString("WhichYear") <> Nothing), Request.QueryString("WhichYear"), "1997") %>'  Type="Integer"   />
  </Parameters>
</MM:DataSet>
<MM:PageBind runat="server" PostBackBind="true" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<form runat="server">
  <asp:DataGrid id="DataGrid1" 
  runat="server" 
  AllowSorting="False" 
  AutoGenerateColumns="false" 
  CellPadding="3" 
  CellSpacing="0" 
  ShowFooter="false" 
  ShowHeader="true" 
  DataSource="<%# DataSet1.DefaultView %>" 
  PagerStyle-Mode="NextPrev" 
  AllowPaging="true" 
  AllowCustomPaging="true" 
  PageSize="<%# DataSet1.PageSize %>" 
  VirtualItemCount="<%# DataSet1.RecordCount %>" 
  OnPageIndexChanged="DataSet1.OnDataGridPageIndexChanged" 
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
  </asp:DataGrid>
</form>
</body>
</html>
