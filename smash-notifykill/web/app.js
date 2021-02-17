$(document).ready(function(){
	window.addEventListener("message",function(event){
		var html = "<div id='"+event.data.css+"'>"+event.data.mensagem+" "+event.data.type+" "+event.data.mensagem2+"</div>"
		$(html).fadeIn(500).appendTo("#notifications").delay(event.data.timer).fadeOut(500);
	})
});