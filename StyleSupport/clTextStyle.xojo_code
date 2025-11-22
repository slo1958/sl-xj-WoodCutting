#tag Class
Class clTextStyle
	#tag Method, Flags = &h0
		Sub ApplyStyleTo(g as Graphics)
		  
		  if self.TextFont <> "" then g.FontName = self.TextFont
		  
		  if self.TextSize > 0 then g.FontSize = self.TextSize
		  
		  g.Bold = self.TextBold
		  g.Italic = self.TextItalic
		  
		  g.DrawingColor = self.TextColor
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Bold()
		  self.TextBold = True
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Bold_Off()
		  self.TextBold = false
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As clTextStyle
		  var tmp as new clTextStyle(self.TextFont, self.TextSize, self.TextColor)
		  
		  tmp.TextBold = self.TextBold
		  tmp.TextItalic = self.TextItalic
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(NewTextSize as integer) As clTextStyle
		  var tmp as new clTextStyle(self.TextFont, NewTextSize, self.TextColor)
		  
		  tmp.TextBold = self.TextBold
		  tmp.TextItalic = self.TextItalic
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(NewTextSize as integer, Mode as Style) As clTextStyle
		  var tmp as new clTextStyle(self.TextFont, NewTextSize, self.TextColor)
		  
		  tmp.TextBold = (mode = Style.Bold or mode = Style.BoldItalic)
		  
		  tmp.TextItalic =  (mode = Style.Italic or mode = Style.BoldItalic)
		  
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(Mode as Style) As clTextStyle
		  var tmp as new clTextStyle(self.TextFont, self.TextSize, self.TextColor)
		  
		  tmp.TextBold = (mode = Style.Bold or mode = Style.BoldItalic)
		  
		  tmp.TextItalic =  (mode = Style.Italic or mode = Style.BoldItalic)
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(FontName as string, FontSize as integer, FontColor as color = &c000000)
		  
		  self.TextFont = FontName
		  self.TextSize = FontSize
		  self.TextColor = FontColor
		  
		  self.TextBold = False
		  Self.TextItalic = false
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(FontName as string, FontSize as integer, Mode as Style, FontColor as color = &c000000)
		  
		  self.TextFont = FontName
		  self.TextSize = FontSize
		  self.TextColor = FontColor
		  
		  self.TextBold = (mode = Style.Bold or mode = Style.BoldItalic)
		  
		  self.TextItalic =  (mode = Style.Italic or mode = Style.BoldItalic)
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Italic()
		  self.TextItalic = True
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Italic_Off()
		  self.TextItalic = False
		  return
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		TextBold As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		TextColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		TextFont As string
	#tag EndProperty

	#tag Property, Flags = &h0
		TextItalic As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		TextSize As Integer
	#tag EndProperty


	#tag Enum, Name = Style, Type = Integer, Flags = &h0
		Normal
		  Bold
		  Italic
		BoldItalic
	#tag EndEnum


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
			Name="TextSize"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextBold"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextFont"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextItalic"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
