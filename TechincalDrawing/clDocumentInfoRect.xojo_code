#tag Class
Class clDocumentInfoRect
	#tag Method, Flags = &h0
		Sub Constructor()
		  self.cartoucheWidth = 300
		  self.cartoucheHeight = 150
		  
		  self.DocDate = DateTime.now
		  
		  self.StyleTitle = new clTextStyle("Helvetica", 14)
		  self.StyleComments = self.StyleTitle.clone(12)
		  self.StyleMainTitle = self.StyleTitle.clone(clTextStyle.Style.Bold)
		  
		  self.marginBigFrame = 5
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdatePDFDocInfo(doc as PDFDocument)
		  
		  // Setting PDF Document general info
		  if self.DocCompany= "" then
		    doc.Creator = self.DocAuthor
		    
		  else
		    doc.Creator = self.DocCompany
		    
		  end if
		  
		  doc.Author = self.DocAuthor
		  
		  // doc.Keywords = tbd
		  doc.Title = self.DocTitle
		  
		  // doc.Subject = ""
		End Sub
	#tag EndMethod


	#tag Note, Name = Create toc entry from example
		
		// ------------> Creating and adding the TOC to the Document
		
		Var FirstPage As New PDFTOCEntry(1,"First Page",0,0)
		Var FirstSection As New PDFTOCEntry(1,"First Section",0,100)
		Var FirstSubSection As New PDFTOCEntry(1,"First Sub-Section", 0, firstSectionHeigth)
		
		
		FirstSection.Addentry FirstSubSection
		FirstPage.AddEntry FirstSection
		
		
		
		Var SecondPage As New PDFTOCEntry(2,"Second Page",0,0)
		Var SecondPageFirstSection As New PDFTOCEntry(2, "First Section", 0, 50)
		
		SecondPage.AddEntry SecondPageFirstSection
		
		d.AddTOCEntry FirstPage
		d.AddTOCEntry SecondPage
	#tag EndNote


	#tag Property, Flags = &h0
		cartoucheHeight As double
	#tag EndProperty

	#tag Property, Flags = &h0
		cartoucheWidth As double
	#tag EndProperty

	#tag Property, Flags = &h0
		DocAuthor As String
	#tag EndProperty

	#tag Property, Flags = &h0
		DocCompany As String
	#tag EndProperty

	#tag Property, Flags = &h0
		DocDate As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		DocTitle As string
	#tag EndProperty

	#tag Property, Flags = &h0
		marginBigFrame As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		StyleComments As clTextStyle
	#tag EndProperty

	#tag Property, Flags = &h0
		StyleMainTitle As clTextStyle
	#tag EndProperty

	#tag Property, Flags = &h0
		StyleTitle As clTextStyle
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="cartoucheWidth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="cartoucheHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DocAuthor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DocCompany"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DocTitle"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
