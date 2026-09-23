#!/bin/bash
# Local preview ONLY. Writes to public/ (gitignored) instead of docs/, so it
# never bakes localhost links into the committed GitHub Pages output.
# After previewing, run ./build.sh before committing.
cd "$(dirname "$0")"
hugo server --destination public
