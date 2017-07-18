#!/bin/bash
set -e

echo "changing directory permission..."
for dir in `mount|awk '{print \$3}'`;do
   if [[ $dir =~ ^/var/www/html/ ]]; then
	cmd="chmod -R a+rw $dir";
	echo $cmd;
   	$cmd;
   fi
done	

echo
for f in /docker-entrypoint.d/*; do
	case "$f" in
		*.sh) echo "$0: running $f"; . "$f" ;;
		*)    echo "$0: ignoring $f" ;;
	esac
	echo
done

exec "$@"
