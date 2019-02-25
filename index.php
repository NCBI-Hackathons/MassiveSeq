<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
?>

<html>
<head>
    <title>ironhack</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <link rel="icon" href="/favicon.ico?v=2" type="image/x-icon" />    
</head>
<body>

<h1>LargeScale_RNAseq_Ataxia</h1>
<hr />

<p>
Github link: <a href="https://github.com/NCBI-Hackathons/LargeScale_RNAseq_Ataxia">https://github.com/NCBI-Hackathons/LargeScale_RNAseq_Ataxia</a>
</p>

<p>
This site: <a href="ec2-52-15-225-63.us-east-2.compute.amazonaws.com/">ec2-52-15-225-63.us-east-2.compute.amazonaws.com/</a>
</p>

<p>Team assignments: <a href="https://docs.google.com/spreadsheets/d/1XDGMvPgDWn_ZpfuGrQmGbXGLd9NQwfQRfUAqnhbgkpg/edit#gid=0">https://docs.google.com/spreadsheets/d/1XDGMvPgDWn_ZpfuGrQmGbXGLd9NQwfQRfUAqnhbgkpg/edit#gid=0</a></p>

<p>Schedule: <a href="https://docs.google.com/document/d/1Jga7NDVYYy0r5RRZnHnmnTGgQ45lxNq14zKLmjrThkbo/edit#">https://docs.google.com/document/d/1Jga7NDVYYy0r5RRZnHnmnTGgQ45lxNq14zKLmjrThkbo/edit#</a></p>


<?php
// get user IP/browser info
$userip = $_SERVER['REMOTE_ADDR'];
$userhttpagent = $_SERVER['HTTP_USER_AGENT'];
//$userbrowser = get_browser();
//echo $userbrowser;
//echo $userhttpagent;

// this works but for server (me) not client (viewer)
//$details = json_decode(file_get_contents("http://ipinfo.io"));
//echo $details->city;

$details = json_decode(file_get_contents("http://ipinfo.io/{$userip}/json"));
//$viewerCity = $details->city;
// EXAMPLE
//{
//  "ip": "8.8.8.8",
//  "hostname": "google-public-dns-a.google.com",
//  "loc": "37.385999999999996,-122.0838",
//  "org": "AS15169 Google Inc.",
//  "city": "Mountain View",
//  "region": "CA",
//  "country": "US",
//  "postal": 34685
//  "phone": 650 // this one doesn't appear for me at the house in PH
//}

//$arr = var_dump($details);

foreach ($details as $x => $v) {
    echo $x.' '.$v.'<br />';
}

?>
<br />
<br />
<img src="patrick.jpg" />

</body>
</html>
