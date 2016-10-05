<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<MM:DataSet 
id="DataSet1"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_connWines") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_connWines") %>'
CommandText='<%# "SELECT  tblWines.WineName, tblWines.WineMaker, tblWines.WineColor, tblPurchases.*     FROM tblWines, tblPurchases  WHERE tblWines.WineID = tblPurchases.WineID  ORDER BY tblWines.WineName" %>'
Debug="true" PageSize="10"
>
  <EditOps>
    <EditOpsTable Name="tblPurchases" />
    <Parameter Name="PurchaseQuantity" Type="Integer" />    
    <Parameter Name="PurchasePrice" Type="Currency" />    
    <Parameter Name="PurchaseID" Type="Integer" IsPrimary="true" />      </EditOps>
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
  <asp:DataGrid 
  AllowCustomPaging="true" 
  AllowPaging="true" 
  AllowSorting="False" 
  AutoGenerateColumns="false" 
  CellPadding="3" 
  CellSpacing="0" 
        DataKeyField="PurchaseID" 
  DataSource="<%# DataSet1.DefaultView %>" id="DataGrid1" 
  PagerStyle-Mode="NumericPages" 
  PageSize="<%# DataSet1.PageSize %>" 
  runat="server" 
  ShowFooter="false" 
  ShowHeader="true" 
  onUpdateCommand="DataSet1.OnDataGridUpdate" 
  onEditCommand="DataSet1.OnDataGridEdit" 
  OnPageIndexChanged="DataSet1.OnDataGridPageIndexChanged"
  onCancelCommand="DataSet1.OnDataGridCancel" OnDeleteCommand="DataSet1.OnDataGridDelete" 
  onItemDataBound="DataSet1.OnDataGridItemDataBound" 
  VirtualItemCount="<%# DataSet1.RecordCount %>" 
>
    <HeaderStyle HorizontalAlign="center" BackColor="#E8EBFD" ForeColor="#3D3DB6" Font-Name="Verdana, Arial, Helvetica, sans-serif" Font-Bold="true" Font-Size="smaller" />
    <ItemStyle BackColor="#F2F2F2" Font-Name="Verdana, Arial, Helvetica, sans-serif" Font-Size="smaller" />
    <AlternatingItemStyle BackColor="#E5E5E5" Font-Name="Verdana, Arial, Helvetica, sans-serif" Font-Size="smaller" />
    <FooterStyle HorizontalAlign="center" BackColor="#E8EBFD" ForeColor="#3D3DB6" Font-Name="Verdana, Arial, Helvetica, sans-serif" Font-Bold="true" Font-Size="smaller" />
    <PagerStyle BackColor="white" Font-Name="Verdana, Arial, Helvetica, sans-serif" Font-Size="smaller" />
    <Columns>
    <asp:BoundColumn DataField="WineName" 
        HeaderText="Wine Name" 
        ReadOnly="true" 
        Visible="True"/>    
    <asp:BoundColumn DataField="WineMaker" 
        HeaderText="Wine Maker" 
        ReadOnly="true" 
        Visible="True"/>    
    <asp:BoundColumn DataField="WineColor" 
        HeaderText="Wine Color" 
        ReadOnly="true" 
        Visible="True"/>    
    <asp:BoundColumn DataField="PurchaseDate" 
        HeaderText="Purchase Date" 
        ReadOnly="true" 
        Visible="True"/>    
    <asp:BoundColumn DataField="PurchaseQuantity" 
        HeaderText="Purchase Quantity" 
        ReadOnly="false" 
        Visible="True"/>    
    <asp:BoundColumn DataField="PurchaseShop" 
        HeaderText="Purchase Shop" 
        ReadOnly="true" 
        Visible="True"/>    
    <asp:BoundColumn DataField="PurchasePrice" 
        HeaderText="Purchase Price" 
        ReadOnly="false" 
        Visible="True"/>    
<asp:EditCommandColumn 
        ButtonType="PushButton" 
        CancelText="Cancel" 
        EditText="Edit" 
        HeaderText="Actions" 
        UpdateText="Update" 
        Visible="True"/>    
<asp:ButtonColumn 
        ButtonType="PushButton" 
        CommandName="Delete" 
        HeaderText="Delete" 
        Text="Delete" 
        Visible="True"/>    
</Columns>
  </asp:DataGrid>
</form>
</body>
</html>
