//= require jquery
//= require bootstrap/modal
//= require jquery_ujs

io = io.connect('http://localhost:8080', {force_connection: true});

$(document).ready(function(){

	$('.registration').click(function(){
		$('#myModal').modal();
	})

	$('.login').click(function(){
		$('#loginModal').modal();
	})

	$(document).on('submit', '.mapsearch', function(){
		var address = $('#address').val();
		codeAddress(address);
		return false;
	});
	   
	$("#maprefresh").submit(function(){
	  	$.post($(this).attr('action'),
		$(this).serialize(),
		function(data){
			$('.shops').html(data);
		});
	    return false;
	});

	$(document).on('submit', '#new_favorite', function(){
		$.post($(this).attr('action'),
		$(this).serialize(),
		function(data){
			io.emit('new_favorite', data);
		})
		
		$(this).parent().siblings().show();
		$(this).parent().hide();
	    return false;
	})

	/// listens for new favorites being added and appends to activity log ///
	io.on('updated_favorite', function(data){
		$('.show_activities').prepend(data);
	})

	$(document).on('submit', '#delete_favorite', function(){
		$.post($(this).attr('action'),
		$(this).serialize());
		$(this).parent().siblings().show();
		$(this).parent().hide();
	    return false;
	})

	$(document).on('click', '#mapslide', function(){
		$('.map').animate({width: '75%'}, 1000);
		$('.map').css('width', '75%');
		initialize();
	})

	$('.disabled').parent().mouseenter(function(){
		$( this ).tooltip({ show: { effect: "blind", duration: 800 } });
	})

})

