var ready;

ready = function() {

	$('#categories li').click( function() {
		$('#categories li.active').removeClass();
		$(this).addClass('active');
	});

}

$(document).ready(ready);
$(document).on('page:load', ready);
