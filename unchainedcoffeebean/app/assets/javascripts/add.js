//= require jquery
//= require jquery_ujs

$(document).ready(function(){

	$('.new_shop').submit(function(){
		alert('got it on add page');
	})

	$(document).on('submit', '.new_shop', function(){
		$.post($(this).attr('action'),
		$(this).serialize(),
		function(data){
			alert(data);
			console.log(data);
		}, 'json')
	    return false;
	})

	$(document).on('ajax:success', function(){
		alert('ajax:success');
	})

});