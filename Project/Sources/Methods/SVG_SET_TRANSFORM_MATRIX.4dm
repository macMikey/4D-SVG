//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
  // ----------------------------------------------------
  // Method : SVG_SET_TRANSFORM_MATRIX
  // Created 08/07/08 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description
  //
  // ----------------------------------------------------
C_TEXT:C284($1)
C_REAL:C285($2)
C_REAL:C285($3)
C_REAL:C285($4)
C_REAL:C285($5)
C_REAL:C285($6)
C_REAL:C285($7)

C_LONGINT:C283($Lon_end;$Lon_parameters;$Lon_start)
C_TEXT:C284($kTxt_currentMethod;$Txt_a;$Txt_b;$Txt_objectID;$Txt_value)

If (False:C215)
	C_TEXT:C284(SVG_SET_TRANSFORM_MATRIX ;$1)
	C_REAL:C285(SVG_SET_TRANSFORM_MATRIX ;$2)
	C_REAL:C285(SVG_SET_TRANSFORM_MATRIX ;$3)
	C_REAL:C285(SVG_SET_TRANSFORM_MATRIX ;$4)
	C_REAL:C285(SVG_SET_TRANSFORM_MATRIX ;$5)
	C_REAL:C285(SVG_SET_TRANSFORM_MATRIX ;$6)
	C_REAL:C285(SVG_SET_TRANSFORM_MATRIX ;$7)
End if 

Compiler_SVG 

$Lon_parameters:=Count parameters:C259
$kTxt_currentMethod:=Current method name:C684

If ($Lon_parameters>=3)
	
	$Txt_objectID:=$1
	$Txt_a:=String:C10($2;"&xml")
	$Txt_b:=String:C10($3;"&xml")
	
	If (Asserted:C1132(xml_referenceValid ($Txt_objectID);Get localized string:C991("error_badReference")))
		
		Component_errorHandler ("init";$kTxt_currentMethod)
		
		  //Get the current value of transform attribute if any {
		Component_errorHandler ("ERROR_OFF")
		DOM GET XML ATTRIBUTE BY NAME:C728($Txt_objectID;"transform";$Txt_value)
		
		If (OK=1)
			
			$Lon_start:=Position:C15("matrix(";$Txt_value)
			
			If ($Lon_start>0)
				
				$Lon_end:=Position:C15(")";$Txt_value;$Lon_start+1)
				$Txt_value:=Delete string:C232($Txt_value;$Lon_start;$Lon_end-$Lon_start+1)
				
			End if 
			
			If (Length:C16($Txt_value)>0)
				
				If ($Txt_value[[1]]=" ")
					
					$Txt_value:=Substring:C12($Txt_value;2)
					
				End if 
				
				If (Length:C16($Txt_value)>0)
					
					$Txt_value:=$Txt_value+" "
					
				End if 
			End if 
		End if 
		
		Component_errorHandler ("ERROR_ON")
		  //}
		
		$Txt_value:=$Txt_value+"matrix("+$Txt_a+","+$Txt_b
		
		If ($Lon_parameters>=5)
			
			$Txt_value:=$Txt_value+","+String:C10($4;"&xml")+","+String:C10($5;"&xml")
			
			If ($Lon_parameters>=7)
				
				$Txt_value:=$Txt_value+","+String:C10($6;"&xml")+","+String:C10($7;"&xml")
				
			Else 
				
				$Txt_value:=$Txt_value+",0,0"
				
			End if 
			
		Else 
			
			$Txt_value:=$Txt_value+",0,0,0,0"
			
		End if 
		
		$Txt_value:=$Txt_value+")"
		
		DOM SET XML ATTRIBUTE:C866($Txt_objectID;\
			"transform";$Txt_value)
		
		ASSERT:C1129(Component_errorHandler ("deinit"))
		
	Else 
		
		ASSERT:C1129(Component_putError (8852;$kTxt_currentMethod))  //The reference is not a svg object
		
	End if 
	
Else 
	
	ASSERT:C1129(Component_putError (8850;$kTxt_currentMethod))  //Parameters Missing
	
End if 