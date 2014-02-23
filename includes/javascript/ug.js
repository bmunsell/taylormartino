(function($) {

$(document).ready(function() {

$('#spinner').fadeOut();

var MainNav = $('#MainNav');
var MenuHeight = MainNav.height();
MainNav.height(0);
var overlay = $('<div id="overlay"></div>');

$('#MenuBtn').toggle(
	 
	function(event) {
	var docHeight = $(document).height();
	event.preventDefault();
	overlay.appendTo('body').css({'height':docHeight-50}).fadeIn(250);
	//mainNav.show();
	MainNav.offset({left:0}).height(MenuHeight);
	$(this).html('Close');
	},
	
	function(event) {
	event.preventDefault();
	overlay.fadeOut(250);
	MainNav.height(0);
	setTimeout(function() {
	MainNav.offset({left:-9999});
	},250);
	$(this).html('Menu');
	}
	
);

$('#go_to_top').last().click(function(event) {
event.preventDefault();
//var offset = $($(this).attr('href')).offset().top;
$('html, body').animate({scrollTop:0}, 1000);
});

$('#backBtn').click(function(event) {
event.preventDefault();
window.history.back()
});

});

})(jQuery);


/*
  * Normalized hide address bar for iOS & Android
  * (c) Scott Jehl, scottjehl.com
  * MIT License
*/

(function( win ){
	var doc = win.document;
	
	// If there's a hash, or addEventListener is undefined, stop here
	if( !location.hash && win.addEventListener ){
		
		//scroll to 1
		window.scrollTo( 0, 1 );
		var scrollTop = 1,
			getScrollTop = function(){
				return win.pageYOffset || doc.compatMode === "CSS1Compat" && doc.documentElement.scrollTop || doc.body.scrollTop || 0;
			},
		
			//reset to 0 on bodyready, if needed
			bodycheck = setTimeout(function(){
				if( doc.body ){
					clearInterval( bodycheck );
					scrollTop = getScrollTop();
					win.scrollTo( 0, scrollTop === 1 ? 0 : 1 );
				}	
			}, 15 );
		
		win.addEventListener( "load", function(){
			setTimeout(function(){
				//at load, if user hasn't scrolled more than 20 or so...
				if( getScrollTop() < 20 ){
					//reset to hide addr bar at onload
					win.scrollTo( 0, scrollTop === 1 ? 0 : 1 );
				}
			}, 0);
		} );
	}
})( this );