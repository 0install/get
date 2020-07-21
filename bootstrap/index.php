<?php
/* Generates an application-tailored Zero Install bootstrap-loader. */

// Constants
$placeholder_app_mode = "--------------------AppMode--------------------";
$placeholder_app_name = "----------------------------------------AppName----------------------------------------";
$placeholder_app_alias = "----------------------------------------AppAlias----------------------------------------";
$placeholder_app_uri = "--------------------------------------------------------------------------------AppUri--------------------------------------------------------------------------------";

// Sanitize inputs
$app_mode = ($_GET['mode'] == 'integrate') ? 'integrate' : 'run';
$app_name = preg_replace('/[^A-Za-z0-9\.,\-_ ]/', '', $_GET['name']);
if (strlen($app_name) == 0) die("name is missing!");
$app_alias = str_replace(' ', '-', strtolower($app_name));
$app_uri = $_GET['uri'];
if (strlen($app_uri) == 0) die("uri is missing!");
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
		$template_data = file_get_contents("$app_mode.sh.template");

		// Replace placeholder fields
		$template_data = str_replace($placeholder_app_uri, $app_uri, $template_data);
		$template_data = str_replace($placeholder_app_alias, $app_alias, $template_data);

		// Output data
		header("Content-Type: text/x-shellscript");
		header("Content-Length: ".strlen($template_data));
		header('Content-Disposition: attachment; filename="'.$app_mode.'-'.$app_alias.'.sh"', false);
		echo $template_data;
		break;

	case "windows":
		// Load template file
		$template_data = file_get_contents("../zero-install.exe");

		// Replace placeholder fields, preserve original file length
		if (strlen($app_name) > strlen($placeholder_app_name)) die("name is too long!");
		if (strlen($app_uri) > strlen($placeholder_app_uri)) die("uri is too long!");
		$template_data = str_replace($placeholder_app_name, str_pad($app_name, strlen($placeholder_app_name)), $template_data);
		$template_data = str_replace($placeholder_app_uri, str_pad($app_uri, strlen($placeholder_app_uri)), $template_data);
		$template_data = str_replace($placeholder_app_mode, str_pad($app_mode, strlen($placeholder_app_mode)), $template_data);

		// Output data
		header("Content-Type: application/octet-stream");
		header("Content-Length: ".filesize("../zero-install.exe"));
		header('Content-Disposition: attachment; filename="'.$app_mode.' '.$app_name.'.exe"', false);
		echo $template_data;
		break;

	default:
		die("Platform not supported!");
}
?>
