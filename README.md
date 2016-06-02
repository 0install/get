0bootstrap-php
==============
lightweight PHP script that creates bootstrapping EXEs or bash scripts for installing Zero Install and then running a feed

PHP
===
The `bootstrap.php` script takes the following HTTP GET parameters:
 * `name` (required): The name of the application described by the feed.
 * `uri` (required): The URI of the feed.
 * `mode` (optional): `run` (default) or `integrate`

The scripts loads a template file based on the user agent's operating system, substitutes placeholders with the parameters and returns the file as the response.

Linux
=====
`run.sh.template` and `integrate.sh.template` are shell scripts that first tries to detect the distribution's package manager, then uses it to install Zero Install and finally invokes `0install run` or `0install add` for the target feed.
The script contains placeholders that are replaced by the PHP script.

Windows
=======
Download the Zero Install for Windows Bootstrap executable from http://0install.de/files/zero-install.exe and place it in this directory.
The executable contains placeholders that are replaced by the PHP script.
