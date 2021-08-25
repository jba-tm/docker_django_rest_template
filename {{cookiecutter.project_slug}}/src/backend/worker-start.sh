#! /usr/bin/env bash
set -e

python /app/app/celeryworker_pre_start.py

celery worker -A backend -l info -Q main-queue -c 1
