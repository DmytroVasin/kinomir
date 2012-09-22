// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .
//= require rails.validations


// ---------------------------------------------------- Включение и отключение клавиши при добавлении кментария START
$(function(){
var box = 0;
$("#new_comment input:submit").attr("disabled","disabled");
	$("#comment_body").keyup(function()
	{
		box = $(this).val();
		if (box.length > 2) {
			$("#new_comment input:submit").removeAttr("disabled");
		} else {
			$("#new_comment input:submit").attr("disabled","disabled");
		}
	});
// ---------------------------------------------------- Включение и отключение клавиши при добавлении кментария END

// ---------------------------------------------------- проверка нажат ли чебокс при создании поста START
	$("#new_post").submit(function(){
        var n = $("input:checked").length;
        if ( n === 0 ) {
        $("#error_for_check_box").text("выберите область знаний!");
        return false;
        }
	});
// ---------------------------------------------------- проверка нажат ли чебокс при создании поста END
// ---------------------------------------------------- Всплывающее флеш сообщение Start
	if ($('.notic strong').html() !== '') {
		$('.notic').fadeOut(4000);
	} else {
		$('.notic').hide();
	}
	if ($('.aler strong').html() !== '') {
		$('.aler').fadeOut(4000);
	} else {
		$('.aler').hide();
	}
// ---------------------------------------------------- Всплывающее флеш сообщение  END
// ---------------------------------------------------- Current date START
        var today = new Date();
        var offset = -(today.getTimezoneOffset()/60);
        $.cookie('time_zone', offset);
// ---------------------------------------------------- Current date END

// ---------------------------------------------------- STARZ START
$(".hidden_rank").css('display','none');
$('.raiting_votes').css('display', 'block');
$('.raiting_hover').css('display', 'none');
$('.edit_vote').css('display', 'none');

	var hidden_rank;
	var star_widht;
	var margin_doc;
	var widht_votes;
// each - остаток от прошлого велосипеда
$(".hidden_rank").each(function() {
		hidden_rank = $(this).html();
		star_widht = hidden_rank*17;
		$(this).next().children(".raiting_votes").width(star_widht);

	$(this).next().hover(function() {
       $(this).children(".raiting_votes").css('display', 'none');
       $(this).children(".raiting_hover").css('display', 'block');
       }, function() {
       $(this).children(".raiting_votes").css('display', 'block');
       $(this).children(".raiting_hover").css('display', 'none');
	});
	margin_doc = $(this).next().offset();
	$(this).next().mousemove(function(e){
		widht_votes = e.pageX - margin_doc.left;
        if (widht_votes === 0) widht_votes =1;
		user_votes = Math.ceil(widht_votes/17);
		$(this).children('.raiting_hover').width(user_votes*17);
	});
	$(this).next().on('click', function(e){
		widht_votes = e.pageX - margin_doc.left;
		if (widht_votes === 0) widht_votes =1;
		user_votes = Math.ceil(widht_votes/17);
		user_votes -= 1;
		$(this).next().find('input:radio').eq(user_votes).prop('checked', true);
		
		$('#submitt').submit();

	});
});
// ---------------------------------------------------- STARZ END

// ---------------------------------------------------- STARZ INDEX START
$(".hidden_rank_index").css('display','none');
$('.raiting_votes_index').css('display', 'block');

	var hidden_rank_index;
	var star_widht_index;

$(".hidden_rank_index").each(function() {
		hidden_rank_index = $(this).html();
		star_widht_index = hidden_rank_index*17;
		$(this).next().children(".raiting_votes_index").width(star_widht_index);
});
// ---------------------------------------------------- STARZ INDEX END




});