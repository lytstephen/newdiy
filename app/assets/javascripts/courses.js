var ready;

ready = function() {

	// toggle active categories on AJAX filter
	$('#categories li').click( function() {
		$('#categories li.active').removeClass();
		$(this).addClass('active');
	});

	// photo click to enlarge
	$('.modalphotos .course_image').on('click', function() {
		$('#modal').modal({
			show: true,
		})

		var mysrc = this.src.replace('thumbnail', 'large')
		$('#modalimage').attr('src', mysrc);
		$('.modal-body').on('click', function() {
			$('#modal').modal('hide');
		})
	});

}

$(document).ready(ready);
$(document).on('page:load', ready);
