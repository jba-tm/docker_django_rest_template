#! /usr/bin/env bash
set -e

gunicorn --workers 3 --bind 0.0.0.0:8080 backend.wsgi:application