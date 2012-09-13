
var remote_media_timeout = 10000;
var remote_media_latest = 0

function sayhello() {
	console.log("sayhello");
	$.get( 'remote_media_updates.json?since_id=' + remote_media_latest, 
			function(data) { 
				$(data).each(function(id,media){
					console.log(media)
					remote_media_latest = media.id;
					if (media.platform == 'flickr') {
						$("<li class='span4'>" +
							"<img src='" + media.url + "' />"  +
							"</li>"
						 )
							.hide()
					.prependTo('.media-list')
					.fadeIn('slow');
					}
				});
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
