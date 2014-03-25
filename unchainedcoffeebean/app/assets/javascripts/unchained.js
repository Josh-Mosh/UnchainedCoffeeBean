//= require jquery
//= require bootstrap/modal
//= require jquery_ujs
//= require jquery.raty.min.js
//= require jquery-star-rating

$(document).ready(function(){

	$('.registration').click(function(){
		$('#myModal').modal();
	})

	$('.login').click(function(){
		$('#loginModal').modal();
	})

})