#tag Module
Protected Module CuttingModelDrawing
	#tag Method, Flags = &h0
		Sub ExportDrawingsAsPDF(wrl as clWorld, inforect as clDocumentInfoRect)
		  
		  Var doc As New PDFDocument
		  doc.Landscape = false
		  
		  Var g As Graphics = doc.Graphics
		  
		  Static sampleTextFirstPage As String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
		  Static sampleTextFirstPageSubsection As String = "Virtute equidem ceteros in mel. Id volutpat neglegentur eos. Eu eum facilisis voluptatum, no eam albucius verterem. Sit congue platonem adolescens ut. Offendit reprimique et has, eu mei homero imperdiet."+EndOfLine+EndOfLine+"Senserit mediocrem vis ex, et dicunt deleniti gubergren mei. Mel id clita mollis repudiare. Sed ad nostro delicatissimi, postea pertinax est an. Adhuc sensibus percipitur sed te, eirmod tritani debitis nec ea. Cu vis quis gubergren."+EndOfLine+EndOfLine+"No his munere interesset. At soluta accusam gloriatur eos, ferri commodo sed id, ei tollit legere nec. Eum et iudico graecis, cu zzril instructior per, usu at augue epicurei. Saepe scaevola takimata vix id. Errem dictas posidonium id vis, ne modo affert incorrupte eos."
		  Static sampleTextSecondPage As String = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
		  
		  
		  
		  var titleStyle as new clTextStyle("Helvetica", 20, clTextStyle.Style.Bold)
		  var headerStyle as new clTextStyle("Helvetica", 14, clTextStyle.Style.Bold)
		  var bodyStyle as new clTextStyle("Helvetica", 12)
		  
		  DrawPageFrame(g, inforect,"", doc.CurrentPage,2)
		  
		  g.ApplyStyle(titleStyle) 
		  g.DrawText "Summary", 40, 50
		  
		  g.ApplyStyle(headerStyle)
		  g.DrawText "First Section", 40, 100
		  
		  g.ApplyStyle(bodyStyle)
		  g.DrawText sampleTextFirstPage, 40, 120, g.Width-80
		  
		  Var firstSectionHeigth As Double = 120 + g.TextHeight(sampleTextFirstPage,g.Width-120)
		  
		  g.ApplyStyle(headerStyle)
		  g.DrawText "First Subsection", 40, firstSectionHeigth+20
		  
		  g.ApplyStyle(bodyStyle)
		  g.DrawText sampleTextFirstPageSubsection, 40, firstSectionHeigth+40, g.Width-80
		  
		  g.NextPage
		  
		  DrawPageFrame(g, inforect, "Last page ", doc.CurrentPage,2)
		  
		  g.ApplyStyle(titleStyle)
		  g.DrawText "page title", 20, 20
		  
		  var bar_base_y as double = 40
		  var bar_heigth as double = 30
		  var bar_offset_x as double = 20
		  var bar_jump_y as double = 150
		  
		  for each bar_label as string in array("Item #14","Item #15")
		    
		    // cut length and ful length Y
		    var cut_line_y as double =  bar_base_y+bar_heigth + 15
		    var full_length_y as double =  bar_base_y+bar_heigth + 70
		    
		    var full_bar_width as double = g.Width-bar_offset_x - bar_offset_x
		    
		    g.DrawingColor = rgb(0,0,0)
		    g.PenSize = 1
		    g.DrawRectangle (bar_offset_x, bar_base_y, full_bar_width, bar_heigth)
		    
		    g.FontName = "Helvetica"
		    g.FontSize = 12
		    g.bold=True
		    
		    g.DrawText bar_label, bar_offset_x+5, bar_base_y + bar_heigth - 5
		    
		    g.DrawingColor = rgb(160,160,160)
		    
		    draw_vertical_dotted(g, bar_offset_x ,bar_base_y+1, full_length_y)
		    draw_vertical_dotted(g, g.Width-bar_offset_x ,bar_base_y+1, full_length_y)
		    
		    var full_length_measure as double = 360
		    var cuts() as pair = array ("NORTH-32":12.0, "SOUTH-21":22.0, "SOUTH-22":122.0)
		    
		    var remaining_length as Double = full_length_measure
		    
		    for each cutp as pair in cuts
		      remaining_length = remaining_length - cutp.Right
		      
		    next
		    
		    cuts.Add("LeftOver":remaining_length)
		    
		    var last_cut_at_x as double = 0
		    var extra_y as double = 0
		    
		    for each cutp as pair in cuts
		      var cut as Double = cutp.right
		      var cut_label as string = cutp.left
		      var scaled_width as Double = full_bar_width / full_length_measure * cut 
		      var cut_at_x as double = last_cut_at_x + scaled_width
		      
		      
		      draw_vertical_dotted(g, bar_offset_x + cut_at_x,bar_base_y+1, cut_line_y)
		      
		      var cut_str as string = format(cut,"##0")+"cm"
		      
		      draw_a_line(g, bar_offset_x + last_cut_at_x, cut_line_y, bar_offset_x + cut_at_x, cut_line_y, cut_str, cut_label,extra_y)
		      
		      extra_y = if(extra_y < 1 and scaled_width < 80 , 22 , 0)
		      
		      last_cut_at_x = cut_at_x
		      
		      
		    next
		    
		    // Line for full size
		    draw_a_line(g, bar_offset_x, full_length_y, g.Width-bar_offset_x, full_length_y, "360cm","", 0)
		    
		    bar_base_y = bar_base_y + bar_jump_y
		    
		  next
		  
		  
		  Var f As FolderItem = SpecialFolder.Desktop.Child("WoodCutReport.pdf")
		  doc.Save(f)
		  f.Open
		  
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExportListAsPDF(wrl as clWorld, reportTitle as string, reportInfoLabel as string)
		  
		  
		  var TopBottomMargin as double = 20
		  var LeftMarginMain as double = 20
		  var LeftMarginDetail as double = 40
		  var tabPartid as double = 80
		  var tabLength as double = 170
		  
		  var nbItemToCut as integer
		  var nbUsedSource as integer
		  
		  nbUsedSource = wrl.NbrSourceUsed
		  nbItemToCut = wrl.NbrAllocated
		  
		  var woodLength as integer = wrl.WoodSourceLengtrh
		  var measureMargin as integer = wrl.MeasureMargin
		   
		  // The table is sorted per source item, with left over as last cut
		  var res as clDataTable = wrl.ExportCutPlanAsTable("Cutplan")
		  
		  
		  // Total nbr of rows is 3 text rows per source (Name,left over, space) + 1 text row per item
		  
		  var MainStyle as new clTextStyle("Helvetica", 12, clTextStyle.Style.Bold)
		  
		  var ItemStyle as new clTextStyle("Helvetica", 12)
		  
		  
		  var MainRowHeight as Double
		  var ItemRowHeight as Double
		  var pageHeigth as double 
		  
		  Var doc As New PDFDocument
		  doc.Landscape = false
		  
		  Var g As Graphics = doc.Graphics
		  
		  pageHeigth = g.Height - TopBottomMargin - TopBottomMargin
		  
		  g.ApplyStyle(MainStyle)
		  MainRowHeight = g.TextHeight()
		  
		  g.ApplyStyle(ItemStyle)
		  ItemRowHeight = g.TextHeight
		  
		  
		  var runningY as double = TopBottomMargin
		  var currentSourceId as String
		  var itemCounter as integer = 0
		  var pageCounter as integer
		  
		  for each row as clDataRow in res
		    var rowSourceId as string = row.Cell(clWorld.OutputSourceLabel)
		    
		    if currentSourceId <> rowSourceId then
		      if (runningY + 3*MainRowHeight + 5*ItemRowHeight > pageHeigth) or pageCounter = 0 then
		        
		        if pageCounter > 0 then g.NextPage
		        
		        pageCounter = pageCounter + 1
		        
		        runningY = TopBottomMargin
		        
		        g.ApplyStyle(MainStyle)
		        g.DrawText reportTitle + " - " + reportInfoLabel + " - page " + pageCounter.ToString, LeftMarginMain, runningY
		        
		        runningY = runningY + MainRowHeight + MainRowHeight
		        
		        
		      else
		        runningY = runningY + MainRowHeight
		        
		      end if
		      
		      g.ApplyStyle(MainStyle)
		      g.DrawText "Item #" + rowSourceId + " ( " + woodLength.ToString + "cm)", LeftMarginMain, runningY
		      
		      runningY = runningY + MainRowHeight
		      currentSourceId = rowSourceId
		      itemCounter = 0
		      
		    end if
		    
		    itemCounter = itemCounter + 1
		    g.ApplyStyle(ItemStyle)
		    
		    g.DrawText(itemCounter.ToString, LeftMarginDetail, runningY)
		    
		    g.DrawText row.Cell(clWorld.OutputPartLabel), tabPartid, runningY
		    
		    g.DrawText row.Cell(clWorld.OutputLengthLabel) + "cm", tabLength, runningY
		    runningY = runningY + ItemRowHeight
		    
		  next
		  
		  
		  Var f As FolderItem = SpecialFolder.Desktop.Child("WoodCutReport.pdf")
		  doc.Save(f)
		  f.Open
		  
		End Sub
	#tag EndMethod


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
