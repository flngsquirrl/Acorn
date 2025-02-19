#!/usr/bin/env bash

echo "---- Git whitespace check: begin ----"
git -C .. diff --check
echo "---- Git whitespace check: end ----"
