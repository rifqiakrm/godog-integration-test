#!/usr/bin/env bash
set -euo pipefail

if [ ! -f ".env" ]; then
  cp .env.sample .env
fi

godog run --format=cucumber > report.json