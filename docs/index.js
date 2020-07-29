window.onscroll = function(){scroll()};

function scroll() {
	if(document.body.scrollTop > 30 || document.documentElement.scrollTop > 30) {
		document.getElementById("navigation").style.top = "5px";
	} 
	
	else {
		document.getElementById("navigation").style.top = "-300px";
	}
}

function readMore () {
	document.getElementById("read-more-button").style.opacity = "100%";
	document.getElementById("story-text").style.overflow = "visible";
	document.getElementById("story-text").style.height = "80%";
}