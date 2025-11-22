#tag Module
Protected Module CuttingModelDrawing
	#tag Method, Flags = &h0
		Sub ExportDrawingsAsPDF(wrl as clWorld, inforect as clDocumentInfoRect)
		  
		  
		  
		  // The table is sorted per source item, with left over as last cut
		  var res as clDataTable = wrl.ExportCutPlanAsTable("Cutplan")
		  
		  // We need a version sorted by part label for main page
		  var resByItem as clDataTable = res.sort(array(wrl.OutputPartLabel))
		  
		  
		  Var doc As New PDFDocument
		  doc.Landscape = false
		  
		  Var g As Graphics = doc.Graphics
		  
		  
		  
		  var summaryText As String  
		  
		  
		  var titleStyle as new clTextStyle("Helvetica", 20, clTextStyle.Style.Bold)
		  var headerStyle as new clTextStyle("Helvetica", 14, clTextStyle.Style.Bold)
		  var bodyStyle as new clTextStyle("Helvetica", 12)
		  
		  summaryText = "Basic length: " + wrl.WoodSourceLengtrh.ToString+"cm"
		  summaryText = summaryText + EndOfLine + "Number of pieces to process: " + wrl.NbrSourceUsed.ToString + "   measure margin: " + wrl.MeasureMargin.ToString+"cm"
		  summaryText = summaryText + EndOfLine + "Number of pieces afrer cut: " + wrl.NbrAllocated.ToString
		  summaryText = summaryText + EndOfLine + "Number of leftove after cut: " + wrl.NbrLeftOver.ToString
		  summaryText = summaryText + EndOfLine 
		  
		  for each row as clDataRow in resByItem
		    if row.Cell(wrl.OutputPartLabel) <> wrl.OutputLeftOverText then
		      
		      if row.cell(wrl.OutputAllocationMarkLabel)  = "Y" then
		        summaryText = summaryText + EndOfLine +" - " + row.cell(wrl.OutputPartLabel) + " : "  + row.cell(wrl.OutputLengthLabel)+"cm from item #" + row.cell(wrl.OutputSourceLabel)
		        
		      else
		        summaryText = summaryText + EndOfLine +" - " + row.cell(wrl.OutputPartLabel) + " : "  + "Unallocated"
		        
		      end if
		      
		    end if
		  next
		  
		  
		  var bar_top_margin as double =40
		  
		  var bar_heigth as double = 30
		  var bar_offset_x as double = 20
		  var bar_jump_y as double = 150
		  
		  var required_print_space as Double = bar_jump_y * wrl.NbrSourceUsed
		  
		  
		  var numberOfBarsPerPage as integer = (g.Height - inforect.marginBigFrame - inforect.marginBigFrame - inforect.cartoucheHeight) / bar_jump_y
		  var expectedNumberOfPages as integer =   1 +  Ceiling(wrl.NbrSourceUsed / numberOfBarsPerPage)
		  
		  DrawPageFrame(g, inforect,"", doc.CurrentPage,expectedNumberOfPages)
		  
		  g. ApplyTextStyle(titleStyle) 
		  g.DrawText "Summary", 40, 50
		  
		  
		  g. ApplyTextStyle(bodyStyle)
		  g.DrawText summaryText, 40, 80, g.Width-80
		  
		  
		  var currentSourceId as String
		  var currentBarOnPage as integer = numberOfBarsPerPage * 2   // force new page on first call
		  var pageCounter as integer = 1
		  
		  var full_length_measure as Double = wrl.WoodSourceLengtrh
		  
		  var last_cut_at_x as double = 0
		  var extra_y as double = 0
		  var bar_base_y as double = bar_top_margin
		  
		  var full_bar_width as double = g.Width-bar_offset_x - bar_offset_x
		  
		  for each row as clDataRow in res
		    var rowSourceId as string = row.Cell(clWorld.OutputSourceLabel)
		    var rowMark as string = row.cell(clWorld.OutputAllocationMarkLabel)
		    
		    
		    if currentSourceId <> rowSourceId and rowMark = "Y" then
		      bar_base_y = bar_base_y + bar_jump_y
		      currentBarOnPage = currentBarOnPage + 1
		      
		      if currentBarOnPage > numberOfBarsPerPage then
		        g.NextPage
		        
		        // Prepare new page
		        DrawPageFrame(g, inforect, "Cut plan", doc.CurrentPage,expectedNumberOfPages)
		        
		        currentBarOnPage = 1
		        bar_base_y = bar_top_margin
		        
		      end if
		      
		      
		      //  full length Y
		      var full_length_y as double =  bar_base_y+bar_heigth + 70
		      
		      var bar_label as string ="Item #" + row.Cell(wrl.OutputSourceLabel)
		      
		      
		      
		      g.DrawingColor = rgb(0,0,0)
		      g.PenSize = 1
		      g.DrawRectangle (bar_offset_x, bar_base_y, full_bar_width, bar_heigth)
		      
		      g.FontName = "Helvetica"
		      g.FontSize = 12
		      g.bold=True
		      
		      g.DrawText bar_label, bar_offset_x+5, bar_base_y + bar_heigth - 5
		      
		      g.DrawingColor = rgb(160,160,160)
		      
		      DrawVerticalDottedLine(g, bar_offset_x ,bar_base_y+1, full_length_y)
		      DrawVerticalDottedLine(g, g.Width-bar_offset_x ,bar_base_y+1, full_length_y)
		      
		      // Full length bar
		      DrawMeasureLine(g, bar_offset_x, full_length_y, g.Width-bar_offset_x, full_length_y, wrl.WoodSourceLengtrh.ToString+"cm","", 0)
		      
		      last_cut_at_x  = 0
		      extra_y = 0
		      currentSourceId = rowSourceId
		      
		    end if
		    
		    
		    // cut length  Y
		    var cut_line_y as double =  bar_base_y+bar_heigth + 15
		    
		    var cut as Double = row.cell(wrl.OutputLengthLabel)
		    var cut_label as string = row.cell(wrl.OutputPartLabel)
		    
		    var scaled_width as Double = full_bar_width / full_length_measure * cut 
		    var cut_at_x as double = last_cut_at_x + scaled_width
		    
		    DrawVerticalDottedLine(g, bar_offset_x + cut_at_x,bar_base_y+1, cut_line_y)
		    
		    var cut_str as string = format(cut,"##0")+"cm"
		    
		    DrawMeasureLine(g, bar_offset_x + last_cut_at_x, cut_line_y, bar_offset_x + cut_at_x, cut_line_y, cut_str, cut_label,extra_y)
		    
		    extra_y = if(extra_y < 1 and scaled_width < 80 , 22 , 0)
		    
		    last_cut_at_x = cut_at_x
		    
		  next
		  
		  Var f As FolderItem = SpecialFolder.Desktop.Child("WoodCutDrawingReport.pdf")
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
		  
		  g. ApplyTextStyle(MainStyle)
		  MainRowHeight = g.TextHeight()
		  
		  g. ApplyTextStyle(ItemStyle)
		  ItemRowHeight = g.TextHeight
		  
		  
		  var runningY as double 
		  
		  var currentSourceId as String = "-"
		  var itemCounter as integer = 0
		  var pageCounter as integer
		  
		  runningY = TopBottomMargin
		  
		  for each row as clDataRow in res
		    var rowSourceId as string = row.Cell(clWorld.OutputSourceLabel)
		    var rowMark as string = row.cell(clWorld.OutputAllocationMarkLabel)
		    
		    
		    if currentSourceId <> rowSourceId then
		      if (runningY + 3*MainRowHeight + 5*ItemRowHeight > pageHeigth) or pageCounter = 0 then
		        
		        if pageCounter > 0 then g.NextPage
		        
		        pageCounter = pageCounter + 1
		        
		        runningY = TopBottomMargin
		        
		        g. ApplyTextStyle(MainStyle)
		        g.DrawText reportTitle + " - " + reportInfoLabel + " - page " + pageCounter.ToString, LeftMarginMain, runningY
		        
		        runningY = runningY + MainRowHeight + MainRowHeight
		        
		        
		      else
		        runningY = runningY + MainRowHeight
		        
		      end if
		      
		      g. ApplyTextStyle(MainStyle)
		      if rowMark="N" then
		        g.DrawText "Unallocated" , LeftMarginMain, runningY
		        
		      else
		        g.DrawText "Item #" + rowSourceId + " ( " + woodLength.ToString + "cm)", LeftMarginMain, runningY
		        
		      end if
		      
		      runningY = runningY + MainRowHeight
		      currentSourceId = rowSourceId
		      itemCounter = 0
		      
		    end if
		    
		    itemCounter = itemCounter + 1
		    g. ApplyTextStyle(ItemStyle)
		    
		    g.DrawText(itemCounter.ToString, LeftMarginDetail, runningY)
		    
		    g.DrawText row.Cell(clWorld.OutputPartLabel), tabPartid, runningY
		    
		    g.DrawText row.Cell(clWorld.OutputLengthLabel) + "cm", tabLength, runningY
		    runningY = runningY + ItemRowHeight
		    
		    
		  next
		  
		  
		  Var f As FolderItem = SpecialFolder.Desktop.Child("WoodCutTextReport.pdf")
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
