#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
	set -- mongod "$@"
fi

if [ "$1" = 'mongod' ]; then
	chown -R ${RUN_USER}:${RUN_GROUP} /var/lib/mongodb

	numa='numactl --interleave=all'
	if $numa true &> /dev/null; then
		set -- $numa "$@"
	fi

	exec gosu ${RUN_USER} "$@"
fi

exec "$@"