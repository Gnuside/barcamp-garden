
var remote_media_timeout = 10000;
var remote_media_latest = 0

function sayhello() {
	console.log("sayhello");
	$.get( 'remote_media_updates?since_id=' + remote_media_latest, 
			function(data) { 
				$(data)
				.hide()
				.prependTo('.media-list')
				.fadeIn();
			}
		 );
	setTimeout(sayhello, remote_media_timeout);
}

$(document).ready(function() {
	// test we have a media list on the page
	if ($('.media-list').length) {
		setTimeout(sayhello, remote_media_timeout);
	}
});
