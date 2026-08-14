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

CONDA_ENV_NAME="${CONDA_ENV_NAME:-mark-everything-down}"
CONDA_SH="/home/krixdina/miniconda3/etc/profile.d/conda.sh"

if command -v conda >/dev/null 2>&1; then
  eval "$(conda shell.bash hook)"
elif [[ -f "$CONDA_SH" ]]; then
  source "$CONDA_SH"
else
  echo "Conda was not found. Add Conda to PATH or set up /home/krixdina/miniconda3." >&2
  exit 1
fi

conda activate "$CONDA_ENV_NAME"
python main.py --ui
