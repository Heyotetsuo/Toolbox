// Enables scrolling on a website if it's been disabled
// To use, simply paste this code into the browser's console and press return
(function(){
	var all = document.all;
	var style = {};
	var i = 0;
	while ( i < all.length ){
		if ( style.overflow !== "" )
		{
			all[i].style.cssText = "overflow: visible !important";
		}
		if ( style.overflowY !== "" )
		{
			all[i].style.cssText = "overflow-y: visible !important";
		}
		i += 1;
	}
}())
