#!/bin/bash
su -l postgres -c /usr/pgsql-15/bin/initdb
su -l postgres -c "/usr/pgsql-15/bin/pg_ctl -D /var/lib/pgsql/15/data -l /tmp/pg_logfile start"
cat eldump.sql | psql -U postgres