#! /usr/bin/env bash
set -e

python /app/app/celeryworker_pre_start.py

gunicorn --workers 3 --bind 0.0.0.0:8080 backend.wsgi:application