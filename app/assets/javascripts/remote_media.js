
function sayhello() {
	console.log("sayhello");
	$.get( 'updated', 
			function(data) { 
				$('.media-list').append("<li>Successfully got the page.</li>");
			}
		 );
	setTimeout(sayhello, 1000);
}

$(document).ready(function() {
	setTimeout(sayhello, 1000);
});
