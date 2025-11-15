#tag Class
Class clWorld
	#tag Method, Flags = &h0
		Sub AssignPartToSource(part as clWoodPart, source as clWoodSource)
		  
		  part.Source = source.arrayIndex
		  source.UsedIn.Add(part)
		  
		  WriteMessage("Part " + part.Id + " length " + str(part.Length) + " cm assign to source " + str(source.arrayIndex))
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AugmentWoodSource() As clWoodSource
		  //
		  // Add one element to the wood source
		  //
		  
		  
		  if self.WoodSource.Count > self.MaxItems then 
		    return nil
		    
		  end if
		  
		  var s as new clWoodSource(WoodSourceLengtrh)
		  
		  self.WoodSource.Add(s)
		  s.arrayIndex = self.WoodSource.LastIndex
		  
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  self.Writer  = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CutModel()
		  
		  WriteMessage("Start model")
		  
		  // Add our first wood source
		  call self.AugmentWoodSource()
		  
		  //wrl.PrepareWoodSource(partLength)
		  
		  
		  for each part as clWoodPart in self.WoodPart
		    if part.Allocated then
		      
		    else
		      var source as clWoodSource = self.FindWoodSourceMinLeftOver(part.Length)
		      
		      if source = nil then
		        source = self.AugmentWoodSource()
		        
		      end if
		      
		      if source <> nil then
		        
		        var RemainingLength as integer = source.RemainingLength - part.Length 
		        
		        AssignPartToSource(part, source)
		        
		        var secPart as clWoodPart = self.FindWoodPart(RemainingLength-CutMargin, RemainingLength)
		        
		        if secPart <> nil then
		          AssignPartToSource(secPart, source)
		          
		        end if
		      end if
		      
		    end if
		    
		  next
		  
		  WriteMessage("Cut plan ready.")
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExportCutPlan(TableName as string) As clDataTable
		  
		  const SourceLabel as string = "Source"
		  const PartLabel as string = "Part_id"
		  const LengthLabel as string = "Length"
		  
		  var tbl as new clDataTable(TableName)
		  
		  call tbl.AddColumn(new clStringDataSerie(SourceLabel))
		  call tbl.AddColumn(new clStringDataSerie(PartLabel))
		  call tbl.AddColumn(new clIntegerDataSerie(LengthLabel))
		  
		  
		  for each source as clWoodSource in self.WoodSource
		    var dr as clDataRow
		    
		    if source.Used then
		      
		      
		      for each part as clWoodPart in source.UsedIn
		        dr = new clDataRow(SourceLabel:str(source.arrayIndex), PartLabel:part.Id, LengthLabel:part.Length)
		        tbl.AddRow(dr)
		        
		      next
		      
		      dr = new clDataRow(SourceLabel:str(source.arrayIndex), PartLabel:"LeftOver", LengthLabel:source.RemainingLength)
		      tbl.AddRow(dr)
		      
		    else
		      dr = new clDataRow(SourceLabel:str(source.arrayIndex), LengthLabel:Source.RemainingLength)
		      
		      tbl.AddRow(dr)
		    end if
		    
		  next
		  
		  Return tbl
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindWoodPart(reqMinLength as integer, reqMaxLength as integer) As clWoodPart
		  
		  for each wp as clWoodPart in self. WoodPart
		    if wp.Allocated then
		      
		    else
		      var rl as integer = wp.Length
		      
		      if (reqMinLength < rl) and (rl <= reqMaxLength) then return wp
		      
		    end if
		    
		  next
		  
		  return nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindWoodSource(reqMinLength as integer, reqMaxLength as integer) As clWoodSource
		  
		  for each ws as clWoodSource in self. WoodSource
		    var rl as integer = ws.RemainingLength
		    
		    if (reqMinLength < rl) and (rl <= reqMaxLength) then return ws
		    
		  next
		  
		  return nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindWoodSourceMinLeftOver(requiredLength as Integer) As clWoodSource
		  
		  var currentSource as clWoodSource = nil
		  var currentLeftOver as integer
		  
		  for each ws as clWoodSource in self. WoodSource
		    var RemainingLength as integer = ws.RemainingLength
		    
		    if RemainingLength >= requiredLength then
		      var leftover as integer = RemainingLength - requiredLength
		      
		      if currentSource = nil then
		        currentSource = ws
		        currentLeftOver = leftover
		        
		      elseif leftover < currentLeftOver then
		        currentSource = ws
		        currentLeftOver = leftover
		        
		      end if
		      
		    end if
		  next
		  
		  return currentSource
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LengthLeftOver() As integer
		  var LeftOver as integer
		  
		  for each source as clWoodSource in self.WoodSource
		    
		    if not source.Used then
		      
		    elseif source.RemainingLength >= self.UsefullLeftOver then
		      LeftOver = LeftOver + source.RemainingLength
		      
		    end if
		    
		  next
		  
		  return LeftOver
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NbrLeftOver() As integer
		  var nbLeftOver as integer
		  
		  for each source as clWoodSource in self.WoodSource
		    
		    if not source.Used then
		      
		    elseif source.RemainingLength >= self.UsefullLeftOver then
		      nbLeftOver = nbLeftOver + 1
		      
		    end if
		    
		  next
		  
		  return nbLeftOver
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NbrSourceUsed() As integer
		  var nbUsed as integer
		  
		  for each source as clWoodSource in self.WoodSource
		    
		    if source.Used then
		      nbUsed = nbUsed + 1
		      
		    end if
		    
		  next
		  
		  return nbUsed
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NbrUnallocated() As integer
		  var nbUnallocated as integer
		  
		  for each part as clWoodPart in self.WoodPart
		    
		    if not part.Allocated then
		      nbUnallocated = nbUnallocated + 1
		      
		      
		    end if
		    
		  next
		  
		  return nbUnallocated
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PrepareWoodParts(src as clDataTable, IDColumn as string, LengthColumn as string, measureMargin as integer)
		  
		  Var tbl as clDataTable = src.Sort(array(LengthColumn), SortOrder.Descending)
		  
		  for each r as clDataRow in tbl
		    var p as new clWoodPart(r.GetCell(IDColumn).StringValue, r.GetCell(LengthColumn).IntegerValue+measureMargin)
		    WoodPart.Add(p)
		    p.arrayIndex = WoodPart.LastIndex
		    
		  next
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PrepareWoodSource(DefaultLength as integer, marginpercent as integer)
		  
		  var requiredtotal as integer
		  
		  for each p as clWoodPart in self.WoodPart
		    requiredtotal = requiredtotal + p.Length
		    
		  next
		  
		  WriteMessage("Total required " + str(requiredtotal)+ " with "+str(marginpercent)+"%")
		  
		  var d as Double = requiredtotal * marginpercent / 100
		  
		  requiredtotal = requiredtotal + d
		  
		  WriteMessage("Total required with margin " + str(requiredtotal))
		  
		  while requiredtotal > 0
		    var s as new clWoodSource(DefaultLength)
		    
		    requiredtotal = requiredtotal - DefaultLength
		    
		    self.WoodSource.Add(s)
		    s.arrayIndex = self.WoodSource.LastIndex
		    
		  Wend
		  
		  
		  WriteMessage("Allocated " + str(self.WoodSource.Count)+ " items")
		  
		  return
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetWriter(msgwr as MessageWriter)
		  
		  self.writer = msgwr
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowStatus()
		  
		  WriteMessage("End of run")
		  
		  var alloc as integer
		  var unalloclength as integer
		  
		  for each part as clWoodPart in self.woodpart
		    if part.Allocated then 
		      alloc = alloc + 1
		    else
		      unalloclength = unalloclength + part.Length
		      
		    end if
		    
		  next
		  
		  WriteMessage("Total parts " + str(self.WoodPart.Count) +" allocate " + str(alloc) + " unallocated " + str(self.WoodPart.Count - alloc))
		  WriteMessage("Unallocated length " + str(unalloclength))
		  
		  var used as integer
		  var leftovercount as integer
		  var leftoverlength as integer
		  
		  for each source as clWoodSource in self.WoodSource
		    if source.Used then
		      used = used + 1
		      
		      if source.RemainingLength > self.UsefullLeftOver then
		        leftovercount = leftovercount + 1
		        leftoverlength = leftoverlength + source.RemainingLength
		        
		      end if
		      
		    end if
		    
		  next
		  
		  WriteMessage("Used source " + str(used))
		  WriteMessage("Nbr left over " + str(leftovercount) + " total length " + str(leftoverlength))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteCutPlan()
		  
		  for each source as clWoodSource in self.WoodSource
		    if source.Used then
		      WriteMessage("---- Source " + str(source.arrayIndex) +" length " + str(source.Length))
		      
		      for each part as clWoodPart in source.UsedIn
		        WriteMessage("Source " + str(source.arrayIndex) +" cut " + str(part.Length)+" for " + part.Id)
		        
		        
		      next
		      
		      WriteMessage("==== Source " + str(source.arrayIndex) +" left over " + str(source.RemainingLength))
		      WriteMessage("")
		      
		    else
		      WriteMessage("Source " + str(source.arrayIndex) +" not used.")
		      
		    end if
		    
		  next
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteMessage(msg as string)
		  if writer = nil then
		    system.DebugLog(msg)
		    
		  else
		    self.writer.Invoke("",msg)
		    system.DebugLog(msg)
		    
		  end if
		  
		  return
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		CutMargin As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		MaxItems As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		UsefullLeftOver As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		WoodPart() As clWoodPart
	#tag EndProperty

	#tag Property, Flags = &h0
		WoodSource() As clWoodSource
	#tag EndProperty

	#tag Property, Flags = &h0
		WoodSourceLengtrh As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		writer As MessageWriter
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
			Name="CutMargin"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UsefullLeftOver"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxItems"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="WoodSourceLengtrh"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
