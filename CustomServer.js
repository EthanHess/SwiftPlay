var express = require('express'); 
var bodyParser = require('body-Parser'); 
var app = express(); 

//Allow all just for test, although not safe in production

app.all("/*", function(req, res, next) {

	res.header("Access-Control-Allow-Origin", "*"); 
	res.header("Access-Control-Allow-Headers", "X-Requested-With", "Content-Type, Accept"); 
	res.header("Access-Control-Allow-Methods", "POST, GET");
	next(); 
}); 

app.use(bodyParser.json()); 
app.use(bodyParse.urlencoded({extented: false})); 

var feedObjects = [
	
	{
		id: "1",
		name: "Hey",
		videoLink: "",
		imageURL: ""
	}, 
	{
		id: "2",
		name: "What's",
		videoLink: "",
		imageURL: ""
	},
	{
		id: "3",
		name: "Up",
		videoLink: "",
		imageURL: ""
	}
]; 

app.get('/feedObjects', function(req, res) {
	console.log("Getting feed from server"); 
	res.send(feedObjects); 
}); 

app.listen(6069); //or whatever port number