#!/usr/bin/env bash
IFS=
DJANGO_SECRET_KEY=$(python3 -c 'import random; print("".join(random.SystemRandom().choice("abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)") for _ in range(50)))')


DJANGO_SECRET_KEY=$DJANGO_SECRET_KEY \
docker-compose --env-file ./.env.dev up --detach --build
