#!/usr/bin/env bash
set -euo pipefail

MODEL="${MODEL:-yuri-qwen}"

if [ "$#" -lt 1 ]; then
    echo "usage: $0 \"prompt\"" >&2
    exit 1
fi

prompt="$*"

ollama run "$MODEL" "$prompt" \
    | sed -e 's/“/「/g' \
          -e 's/”/」/g' \
          -e 's/"\([^"]*\)"/「\1」/g'
