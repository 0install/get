<?php
/* Generates an application-tailored Zero Install bootstrap-loader. */

// Constants
$placeholder_app_name = "--------------------AppName--------------------";
$placeholder_app_uri = "----------------------------------------AppUri----------------------------------------";

// Get user parameters
$app_name = $_GET['name'];
$app_uri = $_GET['uri'];

// Validate user parameters
if (strlen($app_name) == 0) die("name is missing!");
if (strlen($app_name) > strlen($placeholder_app_name)) die("name is too long!");
if (strlen($app_uri) == 0) die("uri is missing!");
if (strlen($app_uri) > strlen($placeholder_app_uri)) die("uri is too long!");
if (!filter_var($app_uri, FILTER_VALIDATE_URL)) die("uri is invalid: $app_uri");

// Detect platform
if (preg_match('/linux/i', $_SERVER['HTTP_USER_AGENT'])) $template_file = "template-windows.sh";
elseif (preg_match('/windows|win32/i', $_SERVER['HTTP_USER_AGENT'])) $template_file = "template-windows.exe";
else die("Platform not supported!");

// Load template data
$template_data = file_get_contents($template_file);

// Replace placeholder fields
$template_data = str_replace($placeholder_app_name, str_pad($app_name, strlen($placeholder_app_name)), $template_data);
$template_data = str_replace($placeholder_app_uri, str_pad($app_uri, strlen($placeholder_app_uri)), $template_data);

// Deactivate error reporting to prevent header problems
error_reporting(0);

// Output data
header("Content-Type: application/octet-stream");
header("Content-Length: ".filesize($template_file));
header('Content-Disposition: attachment; filename="Install '.$app_name.'.exe"', false);
echo $template_data;
?>
