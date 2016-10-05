<%@ Page Language="VB" ContentType="text/xml" ResponseEncoding="iso-8859-1" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.IO" %>
<%
'CREATING AN XMLDOCUMENT
Dim doc As XmlDocument = New XmlDocument()
doc.LoadXml("<?xml version='1.0' ?><portfolio><stock exchange='NASDAQ'>" & _
            "<symbol>ACME</symbol><quote>15.00</quote><quantity>100</quantity>" & _
            "</stock></portfolio>")


'ADDING NEW NODES
' create the new element nodes
Dim newStock As XmlElement = doc.CreateElement("stock")
Dim symbolName As XmlElement = doc.CreateElement("symbol")
Dim quoteVal As XmlElement = doc.CreateElement("quote")
Dim quantity As XmlElement = doc.CreateElement("quantity")
' add the symbol, quote and quantity tags to the stock tag
newStock.AppendChild(symbolName)
newStock.AppendChild(quoteVal)
newStock.AppendChild(quantity)
' next create the text values
symbolName.AppendChild(doc.CreateTextNode("ACM"))
quoteVal.AppendChild(doc.CreateTextNode("23.00"))
quantity.AppendChild(doc.CreateTextNode("50"))
' now add the exchange attribute
newStock.SetAttribute("exchange", "NYSE")
' finally, add the whole structure to the document
doc.DocumentElement.AppendChild(newStock)


'CHANGING NODE DATA
Dim theNodeList As XmlNodeList = doc.GetElementsByTagName("symbol")
Dim theNode As XmlElement
' now we have a list of all the symbol nodes in the document.
' we need to find the one that contains the ACME stock symbol
Dim intCounter As Integer
For intCounter = 0 to theNodeList.Count-1
  If theNodeList.Item(intCounter).FirstChild.Value = "ACME" Then
    theNode = theNodeList.Item(intCounter)
  End If
Next intCounter
' we now have the symbol node. We need the matching quote tag
Dim quoteTag As XmlElement = theNode.NextSibling
' set the value of the quote text node to 22.00
quoteTag.FirstChild.Value = "22.00"

'DELETING NODES
Dim theNodeList2 As XmlNodeList = doc.GetElementsByTagName("symbol")
Dim theNode2 As XmlElement
' now we have a list of all the symbol nodes in the document.
' we need to find the one that contains the ACME stock symbol
For intCounter = 0 to theNodeList2.Count - 1
  If theNodeList2.Item(intCounter).FirstChild.Value = "ACME" Then
    theNode2 = theNodeList2.Item(intCounter)
  End If
Next intCounter
' Then remove the stock tag from the document
' we're removing the whole structure, so we need to remove the
' parent of the symbol tag we found, which is the stock tag
Dim toRemove As XmlNode = theNode2.ParentNode
toRemove.ParentNode.RemoveChild(toRemove)

'SAVING THE XMLDOCUMENT
Dim sw As StringWriter = New StringWriter()
doc.Save(sw)
' write out the string to the screen
Response.Write(sw.ToString())

%>
