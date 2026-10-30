<?php
/* Generates an application-tailored Zero Install bootstrap-loader. */

// Constants
$placeholder_app_name = ";----------------------------------------AppName----------------------------------------";
$placeholder_app_alias = ";----------------------------------------AppAlias----------------------------------------";
$placeholder_app_uri = ";--------------------------------------------------------------------------------AppUri--------------------------------------------------------------------------------";
$placeholder_integrate_args = ";--------------------------------------------------------------------------------IntegrateArgs--------------------------------------------------------------------------------";

// Sanitize inputs
$app_name = preg_replace('/[^A-Za-z0-9\.,\-_ ]/', '', $_GET['name']);
if (strlen($app_name) == 0) die("name is missing!");
$app_alias = str_replace(' ', '-', strtolower($app_name));
$app_uri = $_GET['uri'];
if (strlen($app_uri) == 0) die("uri is missing!");
if (!filter_var($app_uri, FILTER_VALIDATE_URL)) die("uri is invalid: $app_uri");
$app_integrate = ($_GET['mode'] == 'integrate');
$app_mode = $app_integrate ? 'integrate' : 'run';
$main_catalog = (strpos($app_uri, 'https://apps.0install.net/') === 0);

// Detect platform
if (!empty($_GET['platform'])) $platform = $_GET['platform'];
elseif (preg_match('/linux/i', $_SERVER['HTTP_USER_AGENT'])) $platform = "linux";
elseif (preg_match('/macintosh/i', $_SERVER['HTTP_USER_AGENT'])) $platform = "macos";
elseif (preg_match('/windows|win32/i', $_SERVER['HTTP_USER_AGENT'])) $platform = "windows";
else die("Unknown platform!");

// Deactivate error reporting to prevent header problems
error_reporting(0);

switch ($platform) {
	case "linux":
	case "macos":
		$file_name = "$app_mode-$app_alias.sh";
		if ($main_catalog && is_file($file_name)) {
			// Use pre-generated file
			$data = file_get_contents($file_name);
		} else {
			// Load template file
			$data = file_get_contents("$app_mode.sh.template");

			// Replace placeholder fields
			$data = str_replace($placeholder_app_uri, $app_uri, $data);
			$data = str_replace($placeholder_app_alias, $app_alias, $data);
		}

		// Output data
		header("Content-Type: text/x-shellscript");
		header("Content-Length: ".strlen($data));
		header('Content-Disposition: attachment; filename="'.$file_name.'"', false);
		echo $data;
		break;

	case "windows":
		$file_name = "$app_mode $app_name.exe";
		if ($main_catalog && is_file($file_name)) {
			// Use pre-generated file
			$data = file_get_contents($file_name);
		} else {
			// Load template file
			$data = file_get_contents("zero-install.exe");

			// Replace placeholder fields, preserve original file length
			if (strlen($app_name) > strlen($placeholder_app_name)) die("name is too long!");
			if (strlen($app_uri) > strlen($placeholder_app_uri)) die("uri is too long!");
			$data = str_replace($placeholder_app_name, str_pad($app_name, strlen($placeholder_app_name)), $data);
			$data = str_replace($placeholder_app_uri, str_pad($app_uri, strlen($placeholder_app_uri)), $data);
			if ($app_integrate) {
			  $data = str_replace($placeholder_integrate_args, str_pad("--no-download", strlen($placeholder_integrate_args)), $data);
			}
		}

		// Output data
		header("Content-Type: application/octet-stream");
		header("Content-Length: ".strlen($data));
		header('Content-Disposition: attachment; filename="'.$file_name.'"', false);
		echo $data;
		break;

	default:
		die("Platform not supported!");
}
?>
