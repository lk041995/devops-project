#!/usr/bin/env bash
# Simple smoke tests for the static site — no dependencies required.
# Exits non-zero on failure so Jenkins marks the build as failed.
set -euo pipefail

fail() { echo "❌ TEST FAILED: $1"; exit 1; }

echo "Running tests..."

[ -f index.html ] || fail "index.html is missing"
[ -f style.css ]  || fail "style.css is missing"

grep -q "Jenkins CI Demo" index.html || fail "index.html missing expected title"
grep -q 'href="style.css"' index.html || fail "index.html does not link style.css"

echo "✅ All tests passed"
