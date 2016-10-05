<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.IO" %>
<html>
<head>
<title>A shopping bill example</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<body>
The total for your order is: <br />
<%
'CREATING AN XMLDOCUMENT
Dim doc As XmlDocument = New XmlDocument()
doc.LoadXml("<?xml version='1.0'?><shopping><item category='bakery'>" & _
            "<type>Bread rolls</type><price>0.45</price><quantity>6</quantity>" & _
            "</item><item category='fruit'>" & _
            "<type>Pears</type><price>0.70</price><quantity>4</quantity>" & _
            "</item></shopping>")

Dim theShoppingList As XmlNodeList = doc.GetElementsByTagName("item")
Dim itemNode As XmlNode
Dim total As Single = 0.0F
' Now we have a list of all the stock nodes in the document.
' We next add up the value of each holding
Dim intCounter As integer
For intCounter = 0 to theShoppingList.Count-1
  itemNode = theShoppingList.Item(intCounter)
  Dim priceNode As XmlNode = itemNode.FirstChild.NextSibling
  Dim quantityNode As XmlNode = itemNode.LastChild
  ' get the quote value for this item
  Dim price As Single = XmlConvert.ToSingle(priceNode.FirstChild.Value)
  ' get the quantity value for this item
  Dim numBought As Single = XmlConvert.ToSingle(quantityNode.FirstChild.Value)
  ' calculate the total item value and add it to the total
  total += (price * numBought)
Next intCounter
Response.write(total)
%>
</body>
</html>
