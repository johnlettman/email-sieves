#!/bin/sh
find . -type f -name "*.sieve" -print0 |
    xargs -0 -I{} sh -c 'echo "\nChecking {}..."; check-sieve "{}";'
