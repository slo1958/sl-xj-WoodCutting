#tag Module
Protected Module TechincalDrawing
	#tag Method, Flags = &h0
		Sub ApplyStyle(extends g as graphics, s as clTextStyle)
		  
		  s.ApplyStyleTo(g)
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawPageFrame(g as graphics, inforect as clDocumentInfoRect, pagetitle as string, currentPage as integer, totalpages as integer = -1)
		   
		  
		  var pageWidth as double = g.width
		  var pageHeight as double = g.Height
		  
		  g.DrawingColor = rgb(0,0,0)
		  
		  // 
		  // 
		  g.DrawRectangle(inforect.marginBigFrame, inforect.marginBigFrame, pageWidth - 2*inforect.marginBigFrame, pageHeight - 2*inforect.marginBigFrame)
		  
		  if inforect = nil then return
		  
		  
		  //
		  // Box bottom right
		  //
		  var box_x as double = pageWidth - inforect.cartoucheWidth- inforect.marginBigFrame
		  var box_y as double = pageHeight - inforect.cartoucheHeight- inforect.marginBigFrame 
		  var small_box_heigth as double = 30
		  var vertical_offsettext as double = 20
		  
		  g.DrawRectangle(box_x, pageHeight - inforect.cartoucheHeight- inforect.marginBigFrame , inforect.cartoucheWidth, inforect.cartoucheHeight)
		  
		  
		  g.ApplyStyle(inforect.StyleMainTitle)
		  
		  
		  g.DrawRectangle(box_x, box_y, inforect.cartoucheWidth, small_box_heigth)
		  g.DrawText(inforect.DocTitle, box_x+5, box_y+vertical_offsettext)
		  
		  box_y = box_y + small_box_heigth
		  
		  g.ApplyStyle(inforect.StyleTitle)
		  
		  if inforect.DocCompany <> "" then
		    g.DrawRectangle(box_x, box_y, inforect.cartoucheWidth, small_box_heigth)
		    g.DrawText(inforect.DocCompany, box_x+5, box_y+vertical_offsettext)
		    
		    box_y = box_y + small_box_heigth
		    
		  end if
		  
		  g.DrawRectangle(box_x, box_y, inforect.cartoucheWidth, small_box_heigth)
		  g.DrawText("Author: " + inforect.DocAuthor, box_x+5, box_y+vertical_offsettext)
		  
		  box_y = box_y + small_box_heigth
		  
		  g.ApplyStyle(inforect.StyleComments)
		  
		  g.DrawRectangle(box_x, box_y, inforect.cartoucheWidth/2, small_box_heigth)
		  g.DrawText("Date: " + inforect.DocDate.SQLDate, box_x+5, box_y+vertical_offsettext)
		  
		  var pageText as string = currentPage.ToString
		  if totalpages>0 then pageText = pageText + "/" + totalpages.ToString
		  
		  g.DrawRectangle(box_x+inforect.cartoucheWidth/2, box_y, inforect.cartoucheWidth/2, small_box_heigth)
		  g.DrawText("Page: " + pageText, box_x+inforect.cartoucheWidth/2+5, box_y+vertical_offsettext)
		  
		  if pagetitle <> "" then
		    g.ApplyStyle(inforect.StyleComments)
		    
		    g.DrawText(pagetitle, box_x + 5, pageHeight - inforect.marginBigFrame - small_box_heigth + vertical_offsettext)
		    
		  end if
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub draw_a_line(g as graphics, x0 as integer, y0 as integer, x1 as integer, y1 as integer, lbl1 as String, lbl2 as string, extra_y as Double)
		  
		  var measureStyle as new clTextStyle("Helvetica", 12, RGB(160,160,160))
		  var labelStyle as clTextStyle = measureStyle.clone(10)
		  labelStyle.Bold
		  
		  g.DrawingColor = RGB(160,160,160)
		  g.PenSize = 0.5
		  
		  var x_str, y_str As double
		  g.DrawingColor = RGB(160,160,160)
		  g.DrawLine x0 ,y0 ,x1 ,y1 
		  
		  g.DrawLine x0-3,y0-3,x0+3,y0+3
		  g.DrawLine x1-3,y1-3,x1+3,y1+3
		  
		  x_str =(x0+x1)/2 
		  
		  
		  g.ApplyStyle(measureStyle)
		  
		  if y0 = y1 then
		    y_str = y0 + g.TextHeight()+2
		    
		  else
		    y_str = (y0+y1)/2 
		    
		  end if
		  
		  g.DrawText lbl1, x_str - g.TextWidth(lbl1)/2, y_str + extra_y
		  
		  g.ApplyStyle(labelStyle)
		  
		  g.DrawText lbl2, x_str - g.TextWidth(lbl2)/2, y_str + g.TextHeight + extra_y
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub draw_vertical_dotted(g as graphics, x0 as double, y0 as double, y1 as double)
		  
		  const delta as double = 10
		  
		  g.DrawingColor = RGB(160,160,160)
		  g.PenSize = 1
		  
		  var y_start as double = y0
		  var y_end as double 
		  
		  while y_end < y1
		    y_end = y_start + delta
		    if y_end > y1 then y_end = y1
		    
		    g.DrawLine(x0, y_start, x0, y_end)
		    
		    y_start = y_start + delta + delta / 2
		    
		  wend
		  
		  return
		  
		  
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
