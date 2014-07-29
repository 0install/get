<?php
/* Generates an application-tailored Zero Install bootstrap-loader. */

// Constants
$placeholder_app_name = "--------------------AppName--------------------";
$placeholder_app_uri = "----------------------------------------AppUri----------------------------------------";

// Get application parameters
$app_name = $_GET['name'];
$app_uri = $_GET['uri'];

// Validate application parameters
if (strlen($app_name) == 0) die("name is missing!");
if (strlen($app_name) > strlen($placeholder_app_name)) die("name is too long!");
if (strlen($app_uri) == 0) die("uri is missing!");
if (strlen($app_uri) > strlen($placeholder_app_uri)) die("uri is too long!");
if (!filter_var($app_uri, FILTER_VALIDATE_URL)) die("uri is invalid: $app_uri");

// Detect platform
if (!empty($_GET['platform'])) $platform = $_GET['platform'];
elseif (preg_match('/linux/i', $_SERVER['HTTP_USER_AGENT'])) $platform = "linux";
elseif (preg_match('/windows|win32/i', $_SERVER['HTTP_USER_AGENT'])) $platform = "windows";
else die("Unknown platform!");

// Deactivate error reporting to prevent header problems
error_reporting(0);

switch ($platform) {
	case "linux":
		// Load template file
		$template_data = file_get_contents("template-linux.sh");

		// Replace placeholder fields
		$template_data = str_replace($placeholder_app_name, $app_name, $template_data);
		$template_data = str_replace($placeholder_app_uri, $app_uri, $template_data);

		// Output data
		header("Content-Type: text/x-shellscript");
		header("Content-Length: ".strlen($template_data));
		header('Content-Disposition: attachment; filename="install-'.str_replace(' ', '-', strtolower($app_name)).'.sh"', false);
		echo $template_data;
		break;

	case "windows":
		// Load template file
		$template_data = file_get_contents("template-windows.exe");

		// Replace placeholder fields, preserve original file length
		$template_data = str_replace($placeholder_app_name, str_pad($app_name, strlen($placeholder_app_name)), $template_data);
		$template_data = str_replace($placeholder_app_uri, str_pad($app_uri, strlen($placeholder_app_uri)), $template_data);

		// Output data
		header("Content-Type: application/octet-stream");
		header("Content-Length: ".filesize("template-windows.exe"));
		header('Content-Disposition: attachment; filename="Install '.$app_name.'.exe"', false);
		echo $template_data;
		break;

	default:
		die("Platform not supported!");
}
?>
