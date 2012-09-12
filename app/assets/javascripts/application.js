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
//= require_tree .
//= require rails.validations


// Включение и отключение клавиши при добавлении кментария
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
	
// выберите одну тему - к которой принадлежит ваш пост

	$("#new_post").submit(function(){
        var n = $("input:checked").length;
        if ( n === 0 ) {
        $("#error_for_check_box").text("выберите область !");
        return false;
        }
	});
});

