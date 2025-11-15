#tag Class
Class clWoodSource
	#tag Method, Flags = &h0
		Sub Constructor(paramLength as integer)
		  self.Length = paramLength
		  
		  self.UsedIn.RemoveAll
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RemainingLength() As integer
		  var rl as integer = self.Length
		  
		  for each part as clWoodPart in self.UsedIn
		    rl = rl - part.Length
		    
		  next
		  
		  return rl
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Used() As Boolean
		  return UsedIn.Count > 0
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		arrayIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Length As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		UsedIn() As clWoodPart
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
			Name="Length"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="arrayIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
