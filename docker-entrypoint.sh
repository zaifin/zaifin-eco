#!/bin/sh
set -e

echo "Running migrations..."
python manage.py migrate sites --noinput
python manage.py migrate --noinput

echo "Populating DB and creating superuser..."
python manage.py populatedb --createsuperuser

echo "Updating site info..."
python manage.py update_site --domain "${ALLOWED_HOSTS}" --name "Zaifin Eco"

echo "Collecting static files..."
python manage.py collectstatic --no-input

exec "$@"
