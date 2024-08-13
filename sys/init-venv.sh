#!/bin/bash
# SPDX-FileCopyrightText: © 2024 Shaun Wilson
# SPDX-License-Identifier: MIT
##
set -eo pipefail
python3 -m venv --prompt "pycdo" .venv
source .venv/bin/activate
poetry install --no-root
deactivate
