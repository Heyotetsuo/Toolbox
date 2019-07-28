' - - - - - - - - - - - - -
' File: TimelapserWin.vbs
' Version: 0.1.0
' Author: Immanuel Morales
' Date: 7/20/2019
' - - - - - - - - - - - - -

dim fs : set fso = createObject("scripting.fileSystemObject")
dim wsh : set wsh = createObject("wscript.shell")
dim shap : set shap = createObject("shell.application")
dim dir : set dir = shap.browseForFolder( 0, "SELECT TIMELAPSE DESTINATION", 1, "" )
dim prefix : prefix = InputBox( "Enter Timelapse Name" )
dim num
dim fname
dim fpath

function lPad(s, l, c)
	dim n : n = 0
	if l > len(s) then n = 1 - len(s)
	lPad = string(n, c) & s
end function


fso.createFolder dir.self.path & "\bak"

dim i : i = 1

do
	num = lPad(i, 5, "0")
	fname = prefix & "_" & num & ".jpg" 
	fpath = dir.self.path & "\bak\" & fname
	sys.desktop.picture.saveToFile fpath
	wscript.sleep 5000
loop
