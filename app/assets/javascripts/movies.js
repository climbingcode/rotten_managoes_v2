// =============
// RATING MODULE
// =============

$(function() {

	var $ratingContainers = $('.rating-container');
	var $notice			  = $('.notice');

	function bindEvents() {

		$ratingContainers.on('click', 'span', function(e) {
			var input     = $(this).closest('.rating-container').find('input');
			var movieId   = $(this).closest('.movie-container').find('input[name="movie"]').val();
			var oldRating = input.val();
			var newRating = $(this).data('rating');
			var $stars 	  = $(this).parent().find('span');
			input.val(newRating);
			sendNewRating(movieId, newRating, $stars);
		});

	};

	function displayRatedStar($stars, ratingValue) {

		$stars.each(function() {
			if ($(this).data('rating') <= ratingValue) {
				$(this).removeClass('fa-star-o').addClass('fa-star');
			} else {
				$(this).removeClass('fa-star').addClass('fa-star-o');
			}
		});

	};

	function sendNewRating(movieId, newRating, $stars) {

		var params = {score: newRating};
		$.post('/movies/' + movieId + '/ratings', params)
		.success(function(res) {
			if (res.error) {
				showNotice(res.error, false);
			} else {
				window.location.href = '/movies'
			}
		});

	};

	function showNotice(message, status) {

		$notice
			.removeClass('hide')
			.find('h2')
			.text(message)
			.addClass('text-danger')
			

		setTimeout(function() {
			$notice
				.addClass('hide')
				.find('h2')
				.text("");
		}, 3000);

	}

	function init() {
		$ratingContainers.each(function() {
			var $stars 		= $(this).find('span');
			var ratingValue = $(this).find('input').val();
			displayRatedStar($stars, ratingValue);
		});
		bindEvents();
	}

	init();

})();

