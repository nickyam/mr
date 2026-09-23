#!/bin/bash
# Production build -> docs/ (GitHub Pages source, served from /docs on main).
# ALWAYS run this (never `hugo server`) right before committing, otherwise
# docs/ may contain localhost links baked in by `hugo server`.
cd "$(dirname "$0")"
hugo --gc --minify
