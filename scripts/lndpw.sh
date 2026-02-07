#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: scripts/lndpw.sh <outFile>" >&2
  echo "Example: scripts/lndpw.sh onchain/lnd/mainnet/maker/wallet.pw" >&2
  exit 1
fi

OUT="$1"
mkdir -p "$(dirname "$OUT")"

read -r -s -p "LND wallet password: " PW1
echo
read -r -s -p "Confirm password: " PW2
echo

if [[ -z "$PW1" ]]; then
  echo "Password cannot be empty." >&2
  exit 1
fi
if [[ "$PW1" != "$PW2" ]]; then
  echo "Passwords do not match." >&2
  exit 1
fi

umask 077
printf '%s' "$PW1" >"$OUT"
chmod 600 "$OUT" 2>/dev/null || true

echo "Wrote password file: $OUT"

