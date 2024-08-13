#!/bin/bash
# SPDX-FileCopyrightText: © 2024 Shaun Wilson
# SPDX-License-Identifier: MIT
##
source ~/.bashrc
export PS1='\W:\$ '
source .venv/bin/activate
poetry shell
