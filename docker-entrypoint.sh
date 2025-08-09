#!/bin/sh
set -e

echo "Running migrations..."
python manage.py migrate --noinput

echo "Populating DB and creating superuser"
if [ "$(python manage.py showmigrations | grep '\[ \]' | wc -l)" -gt 0 ]; then
    python manage.py populatedb --createsuperuser
fi

echo "Updating site info..."
python manage.py update_site --domain "${ALLOWED_HOSTS}" --name "Zaifin Eco"

echo "Collecting static files..."
python manage.py collectstatic --no-input

echo "Starting server..."
exec "$@"
