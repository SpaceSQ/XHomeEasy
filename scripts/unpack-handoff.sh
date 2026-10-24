#!/bin/bash
# Confirm the 2026-10-21 handoff tree is present. Does not re-expand raw caches into the app.
set -euo pipefail
ROOT="/Users/David1/XHomeEasy"
DEL="$ROOT/deliverables"
TAR="$DEL/XHomeEasy-DevHandoff-2026-10-21.tar.gz"

if [[ ! -d "$DEL/02-Doc/08-subsystems" || ! -f "$DEL/02-Doc/07-channel-partners/unified/channel-partners-master.csv" ]]; then
  if [[ ! -f "$TAR" ]]; then
    echo "Missing handoff tree and tarball." >&2
    exit 1
  fi
  echo "Extracting handoff tarball into $DEL"
  tar -xzf "$TAR" -C "$DEL"
fi

if [[ -f "$DEL/04-CHECKSUMS.sha256" ]]; then
  echo "Checking SHA-256 manifest (paths relative to deliverables/) ..."
  (cd "$DEL" && shasum -a 256 -c 04-CHECKSUMS.sha256)
fi

echo "Handoff tree ready: $DEL/02-Doc"
echo "App ingest must ignore 02-Doc/99-raw and 03-suite-related."
