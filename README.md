0bootstrap-php
==============
lightweight PHP script that creates bootstrapping EXEs or bash scripts for installing Zero Install plus a feed

PHP
===
The `bootstrap.php` script takes `name` and `uri` HTTP GET parameters. It loads a template file, substitutes placeholders with the parameters and returns the file as the response.

Windows
=======
Use [Inno Setup](http://www.jrsoftware.org/isdl.php) to compile `template-windows.iss` to `template-windows.exe`. `AppParams.ini` is embedded within the EXE in uncompressed form, allowing the PHP script to perform the placeholder replacement.
