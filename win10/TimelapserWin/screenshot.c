// - - - - - - - - - - - - -
// File: screenshot.c
// Version: 0.1.0
// Author: Immanuel Morales
// Date: 7/28/2019
// - - - - - - - - - - - - -

#include <windows.h>
#include <GDI_CapturingAnImage.h>

#define MAX_LOADSTRING 100

int main(int argc, char *argv[])
{
	HDC hdcScreen;
	HDC hdcMemDC = NULL;
	HBITMAP hbmScreen = NULL;
	BITMAP bmpScreen;

	// Retrieve the handle to display device context
	// for the client area of the window.
	hdcScreen = GetDC( NULL );
	
	// Create a compatible DC
	// which is used in a BitBlt from the window DC
	hdcMemDC = CreateCompatibleDC( hdcWindow );

	if (!hdcMemDC)
	{
		MessageBox
		(
			hWnd,
			L"CreateCompatibleDC has failed",
			L"Failed",
			MB_OK
		);
		goto done;
	}

	// Get the client area for size calculation
	RECT rcClient;
	GetClientRect
	(
		hWnd,
		&rcClient
	);

	// This is the best stretch mode
	SetStretchBltMode
	(
		hdcWindow,
		HALFTONE
	);

	// The source DC is the entire screen and the
	// destination DC is the current window (HWND)
	if ( !StretchBlt(
		0,
		0,
		rcClient.right,
		rcClient.bottom,
		hdcScreen,
		0,
		0,
		GetSystemMetrics( SM_CXSCREEN ),
		GetSystemMetrics( SM_CYSCREEN ),
		SRCCOPY
	)) {
		MessageBox
		(
			hWnd,
			L"StetchBlt has failed",
			L"Failed",
			MB_OK
		);
		goto done;
	}

	// Create a compatible bitmap from the Window DC
	hbmScreen = CreateCompatibleBitmap
	(
		hdcWindow,
		rcClient.right-rcClient.left,
		rcClient.bottom-rcClient.top
	);
	
	if ( !hbmScreen )
	{
		MessageBox
		(
			hWnd,
			L"CreateCompatibleBitmap Failed",
			L"Failed",
			MB_OK
		);
		goto done;
	}

	// Select the compatible bitmap into the compatible memory DC
	SelectObject
	(
		hdcMemDC,
		hbmScreen
	);

	// Bit block transfer into our compatible memory DC
	if ( !BitBlt(
		0,
		0,
		rcClient.right-rcClient.left,
		hdcWindow,
		0,
		0,
		SRCCOPY
	)) {
		MessageBox
		(
			hWnd,
			L"BitBlt has failed",
			L"Failed",
			MB_OK
		);
		goto done;
	}

	// Get the BITMAP from the HBITMAP
	Get Object
	(
		hbmScreen,
		sizeof( BITMAP ),
		&bmpScreen
	);

	BITMAPFILEHEADER bmfHeader;
	BITMAPINFOHEADER bi;

	bi.biSize = sizeof( BITMAPINFOHEADER );
	bi.biWidth = bmpScreen.bmWidth;
	bi.biHeight = bmpScreen.bmHeight;
	bi.biPlanes = 1;
	bi.biBitCount = 32;
	bi.biCompression = BI_RGB;
	bi.biSizeImage = 0;
	bi.biXPelsPerMeter = 0;
	bi.biYPelsPerMeter = 0;
	bi.biClrUsed = 0;
	bi.biClrImportant = 0;

	DWORD dwBmpSize = ((
		bmpScreen.bmWidth * bi.biBitCount + 31
	) / 32 ) * 4 * bmpScreen.bmHeight;

	// Starting with 32-bit Windows, GlobalAlloc and LocalAlloc are implemented as wrapper functions that
	// call HeapAlloc using a handle to the process's default heap. Therefore, GlobalAlloc and LocalAlloc
	// have greater overhead than HeapAlloc
	HANDLE hDIB = GlobalAlloc( GHND, dwBmpSize );
	char *lpbitmap = (char *)GlobalLock(hDIB);

	// Gets the "bits" from the bitmap and copies them into a buffer
	// which is pointed to by lpbitmap
	GetDIBits
	(
		hdcWindow,
		hbmScreen,
		0,
		(UINT)bmpScreen.bmHeight,
		lpbitmap,
		(BITMAPINFO *)&bi,
		DIB_RGB_COLORS
	);

	// A file is created, this is where we will save the screen capture
	HANDLE hFile = CreateFile
	(
		L"captureqwsx.bmp",
		GENERIC_WRITE,
		0,
		NULL,
		CREATE_ALWAYS,
		FILE_ATTRIBUTE_NORMAL,
		NULL
	);

	// Add the size of the headers to the size of the bitmap to get the total file size
	DWORD dwSizeofDIB = dwBmpSize + sizeof(BITMAPFILEHEADER) + sizeof(BITMAPINFOHEADER);

	// Size of the file
	hmfHeader.bfType = 0x4D42; // BM

	DWORD dwBytesWritten = 0;
	WriteFile
	(
		hFile,
		(LPSTR)&bmfHeader,
		sizeof(BITMAPFILEHEADER),
		&dwBytesWritten,
		NULL
	);
	WriteFile
	(
		hFile,
		(LPSTR)lpbitmap,
		dwBmpSize,
		&dwBytesWritten,
		NULL
	);

	// Unlock and Free the DIB from the heap
	GlobalUnlock( hDIB );
	GlobalFree( hDIB );

	// Close the handle for the file that was created
	CloseHandle( hFile );

	// Clean up
	done:
		DeleteObject( hbmScreen );
		DeleteObject( hdcMemDC );
		ReleaseDC( NULL, hdcScreen );
		ReleaseDC( hWnd, hdcWindow );

	return 0;
}
