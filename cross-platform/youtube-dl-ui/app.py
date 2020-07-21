from tkinter import *
from PyQt5 import QtWidgets
import subprocess
import os
import re

urls = []
destroyed = False
top = None

def cleanStr( s ):
	s = re.sub( r'^\n*', '', s )
	s = re.sub( r'\n*$', '', s )
	return s
def destroyOnce():
	global destroyed
	global win
	if destroyed != True:
		destroyed = True
		win.destroy()
def download():
	global app
	a = app.text.dump( '1.0', END )
	destroyOnce()
	for i in a:
		url = cleanStr( i[1] )
		if 'text' in i and url != '':
			cmd = "./youtube-dl '" + url + "' -o '~/Desktop/%(title)s_%(id)s.%(ext)s'"
			print( cmd )
			subprocess.Popen( cmd, shell=True )
class App:
	def __init__( self, master ):
		frame = Frame( master )
		frame.pack()

		self.text = Text()
		self.text.pack()
		self.text.focus()

		self.button = Button(
			frame, text="DOWNLOAD",
			highlightbackground="black",
			command=download
		)
		self.button.pack()

		app = QtWidgets.QApplication([])
		sw = app.desktop().screenGeometry().width()
		sh = app.desktop().screenGeometry().height()

		master.update_idletasks()
		w = master.winfo_width()
		h = master.winfo_height()

		print( "w: " + str(w) + ", h: " + str(h) )

		x = sw/2 - w/2
		y = sh/2 - h/2

		master.geometry( "+%d+%d" % (x,y) )
win = Tk()
win.configure( background="black" )

app = App( win )

win.attributes( '-topmost', True )
win.update()
win.attributes( '-topmost', False )

win.mainloop()
destroyOnce()
