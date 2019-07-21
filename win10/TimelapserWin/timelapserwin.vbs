' - - - - - - - - - - - - -
' File: TimelapserWin.vbs
' Version: 0.1.0
' Author: Immanuel Morales
' Date: 7/20/2019
' - - - - - - - - - - - - -

dim fso
dim wsh
dim shap
dim dir
dim prefix
dim suffix
dim fname

set fso = createObject("scripting.fileSystemObject")
set wsh = createObject("wscript.shell")
set shap = createObject("shell.application")

set dir = shap.browseForFolder( 0, "SELECT TIMELAPSE DESTINATION", 1, "" )
prefix = InputBox( "Enter Timelapse Name" )

fso.createFolder dir & "\\bak"

:loop
	
goto :loop
