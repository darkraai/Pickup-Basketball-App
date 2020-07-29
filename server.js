var express = require("express");
var bodyp = require("body-parser");
const mongoose = require("mongoose");

mongoose.connect('mongodb://localhost:27017/test', {useNewUrlParser: true}) //connecting to database
var db = mongoose.connection;
db.on('error', console.log.bind(console, "connection error")); 
db.once('open', function(callback){ 
	console.log("connection succeeded"); 
});

var schema = new mongoose.Schema({
	name: String,
	email: String,
});

var app = express(); //set up express app

app.use(bodyp.json());
app.use(express.static(__dirname + "/public"));
app.use(express.static('public'));
app.use(bodyp.urlencoded({extended: true}));

app.post('/sign_up', function(req, res) {
	var name = req.body.name;
	var email = req.body.email;

	var data = {
		"name": name,
		"email": email,
	};

	db.collection('email-list').insertOne(data, function(err, collection) {
		if (err) throw err;
		console.log("Signup success");
	});

	return res.redirect('signup-success.html');
});

app.get('/',function(req,res){ 
	res.set({ 
		'Access-control-Allow-Origin': '*'
	}); 
	return res.redirect('./index.html'); 
}).listen(3000);