#!/bin/bash
# Production build -> public/ (Cloudflare Pages output dir). Run this to verify
# the site locally; Cloudflare builds from source on push, so this is just a
# local check. public/ is gitignored and never committed.
cd "$(dirname "$0")"
hugo --gc --minify
