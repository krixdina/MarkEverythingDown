#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if [[ -z "${DASHSCOPE_API_KEY:-}" ]]; then
  echo "DASHSCOPE_API_KEY is not set. Please export it before running start.sh." >&2
  exit 1
fi

export QWEN_API_KEY="$DASHSCOPE_API_KEY"
export QWEN_BASE_URL="https://dashscope.aliyuncs.com/compatible-mode/v1"
export QWEN_MODEL="qwen3.5-flash"

source .venv/bin/activate
python main.py --ui
