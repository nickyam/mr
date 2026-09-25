#!/bin/bash
# Local preview ONLY. Writes to public/ (gitignored) so it never pollutes the
# committed repo. Cloudflare builds from source on push, so nothing here is
# ever deployed directly.
cd "$(dirname "$0")"
hugo server --destination public
