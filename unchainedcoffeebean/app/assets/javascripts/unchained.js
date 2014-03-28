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

	$(document).on('submit', '.new_favorite', function(){
		$.post($(this).attr('action'),
		$(this).serialize());
		
		$(this).parent().siblings().show();
		$(this).parent().hide();
	    return false;
	})

	$(document).on('submit', '#delete_favorite', function(){
		$.post($(this).attr('action'),
		$(this).serialize());
		$(this).parent().siblings().show();
		$(this).parent().hide();
	    return false;
	})
	
	$("#myButton").click(function(){
		io.emit('clicked_button')
	})

	io.on('updated_button', function(message){
		$('.button_div').append(message);
	})
})

