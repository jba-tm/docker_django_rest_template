#!/usr/bin/env bash

set -e
set -x

pytest --cov=backend --cov-report=term-missing backend/ "${@}"
