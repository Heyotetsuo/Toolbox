wmic service where 'name like "%%Adobe%%"' call stopservice
wmic service where 'name like "%%Update%%"' call stopservice
wmic service where 'name like "%%UsoSvc%%"' call stopservice
wmic process where 'name like "%%Adobe%%"' call terminate
wmic process where 'name like "%%Skype%%"' call terminate
wmic process where 'name like "%%UsoClient%%"' call terminate
wmic process where 'name like "%%Microsoft%%"' call terminate
sc stop AGMService
sc stop AGSService
sc stop TabletInputService
sc stop BTAGService
sc stop bthserv
sc stop wuauserv
taskkill -t -f -im Creative*
taskkill -t -f -im ctfmon*
taskkill -t -f -im OneDrive*
taskkill -t -f -im WinStore*
taskkill -t -f -im rundll*
taskkill -t -f -im ProcessLasso*
taskkill -t -f -im Video*
pause
