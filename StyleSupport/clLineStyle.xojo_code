#tag Class
Class clLineStyle
	#tag Method, Flags = &h0
		Sub ApplyStyleTo(g as Graphics)
		  
		  g.DrawingColor = self.LineColor
		  g.PenSize = self.PenSize
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(BrushSize as double, BrushColor as color = &cA0A0A0)
		  
		  self.LineColor = BrushColor
		  self.PenSize = BrushSize
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		LineColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		PenSize As Double
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
			Name="LineColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
