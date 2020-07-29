$name = $email = "";

if($_SERVER["REQUEST_METHOD"] == "POST"){
	$name = test_input($_POST["name"]);
	$email = test_input($_POST["email"]);

	$m = new MongoClient();
	$db = $m->
}

function test_input($n) {
	$n = trim($n);
	$n = stripslashes($n);
	$n = htmlspecialchars($n);

	return $n;
}