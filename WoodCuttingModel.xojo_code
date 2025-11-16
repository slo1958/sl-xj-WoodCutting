#tag Module
Protected Module WoodCuttingModel
	#tag Method, Flags = &h0
		Function LoadRequirements(sourceFile as FolderItem) As clDataTable
		  
		  // Set the field separator to ';'
		  var cfg as new clTextFileConfig(";")
		  
		  // Load the datatable
		  var tbl as new clDataTable(new clTextReader(sourceFile, True, cfg))
		  
		  tbl.RenameColumn("Cell Label","Label")
		  
		  // all columns are loaded as string, we can use a column allocator or just update the structure to get our value column as integer
		  call tbl.AddColumn(new clIntegerDataSerie("Value", tbl.Column("Cell Value")))
		  
		  // filter out rows where value is zero, create a boolean array and use the array to filter the rows
		  var tmp as cldatatable = tbl.SelectRowsFilteredOn(tbl.GetIntegerColumn("Value").GetFilterColumnValuesInRange(1,9999))
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LoadRequirements_HardCoded() As clDataTable
		  var tbl as new clDataTable("req")
		  
		  
		  tbl.AddRow(new clDataRow("Label":"EAST 1-A","VALUE":227))
		  tbl.AddRow(new clDataRow("Label":"EAST 1-B","VALUE":160))
		  tbl.AddRow(new clDataRow("Label":"EAST 1-C","VALUE":94))
		  tbl.AddRow(new clDataRow("Label":"EAST 1-D","VALUE":32))
		  
		  
		  tbl.AddRow(new clDataRow("Label":"EAST 1-X","VALUE":250))
		  tbl.AddRow(new clDataRow("Label":"EAST 2-A","VALUE":223))
		  tbl.AddRow(new clDataRow("Label":"EAST 2-B","VALUE":163))
		  tbl.AddRow(new clDataRow("Label":"EAST 2-C","VALUE":99))
		  tbl.AddRow(new clDataRow("Label":"EAST 2-D","VALUE":40))
		  
		  
		  
		  tbl.AddRow(new clDataRow("Label":"SOUTH 1-A","VALUE":257))
		  tbl.AddRow(new clDataRow("Label":"SOUTH 1-B","VALUE":185))
		  tbl.AddRow(new clDataRow("Label":"SOUTH 1-C","VALUE":127))
		  tbl.AddRow(new clDataRow("Label":"SOUTH 1-D","VALUE":58))
		  
		  
		  
		  tbl.AddRow(new clDataRow("Label":"SOUTH 2-A","VALUE":256))
		  tbl.AddRow(new clDataRow("Label":"SOUTH 2-B","VALUE":194))
		  tbl.AddRow(new clDataRow("Label":"SOUTH 2-C","VALUE":130))
		  tbl.AddRow(new clDataRow("Label":"SOUTH 2-D","VALUE":66))
		  
		  
		  
		  tbl.AddRow(new clDataRow("Label":"WEST 1-A","VALUE":230))
		  tbl.AddRow(new clDataRow("Label":"WEST 1-B","VALUE":168))
		  tbl.AddRow(new clDataRow("Label":"WEST 1-C","VALUE":103))
		  tbl.AddRow(new clDataRow("Label":"WEST 1-D","VALUE":40))
		  
		  
		  tbl.AddRow(new clDataRow("Label":"WEST 1-X","VALUE":250))
		  tbl.AddRow(new clDataRow("Label":"WEST 2-A","VALUE":226))
		  tbl.AddRow(new clDataRow("Label":"WEST 2-B","VALUE":160))
		  tbl.AddRow(new clDataRow("Label":"WEST 2-C","VALUE":96))
		  tbl.AddRow(new clDataRow("Label":"WEST 2-D","VALUE":32))
		  
		  
		  
		  tbl.AddRow(new clDataRow("Label":"NORTH 0-A","VALUE":95))
		  tbl.AddRow(new clDataRow("Label":"NORTH 0-B","VALUE":126))
		  tbl.AddRow(new clDataRow("Label":"NORTH 0-C","VALUE":82))
		  tbl.AddRow(new clDataRow("Label":"NORTH 0-D","VALUE":82))
		  tbl.AddRow(new clDataRow("Label":"NORTH 0-E","VALUE":110))
		  tbl.AddRow(new clDataRow("Label":"NORTH 0-F","VALUE":110))
		  
		  tbl.AddRow(new clDataRow("Label":"NORTH 1-A","VALUE":253))
		  tbl.AddRow(new clDataRow("Label":"NORTH 1-B","VALUE":189))
		  tbl.AddRow(new clDataRow("Label":"NORTH 1-C","VALUE":118))
		  tbl.AddRow(new clDataRow("Label":"NORTH 1-D","VALUE":57))
		  
		  
		  
		  
		  
		  
		  return tbl
		  
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub MessageWriter(msgtype as string, msginfo as string)
	#tag EndDelegateDeclaration


	#tag Property, Flags = &h0
		Req As clDataTable
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
	#tag EndViewBehavior
End Module
#tag EndModule
