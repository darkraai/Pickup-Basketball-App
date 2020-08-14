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

function saveToFirebase(){
		var email = document.getElementById("emailtxtfield").value;
		var name = document.getElementById("nametxtfield").value;

		var emailObject = {
			email: email
		};

		var nameObject = {
			name: name
		};

		firebase.database().ref('subscription-entries').child('emails').push().set(emailObject)
		.then(function(snapshot) {
				console.log('success');
		}, function(error) {
				console.log('error' + error);
		});

		firebase.database().ref('subscription-entries').child('names').push().set(nameObject)
		.then(function(snapshot) {
				console.log('success');
		}, function(error) {
				console.log('error' + error);
		});

		setTimeout(function(){ alert("Thank you for signing up for the email list! You will be notified when the app launches and will receive the premium version for free upon release."); window.location = "./signup-success.html";}, 200);
		return false;
}
