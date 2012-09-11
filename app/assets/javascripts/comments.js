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
});