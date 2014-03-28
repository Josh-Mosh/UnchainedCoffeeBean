//= require jquery
//= require jquery_ujs

io = io.connect('http://localhost:8080', {force_connection: true});

$(document).ready(function(){

	$(document).on('submit', '.addressSearch', function(){
		var address = $('#address').val();
		codeAddress(address);
		return false;
	});
});

