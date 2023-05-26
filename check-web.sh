#!/bin/bash

DURATION=$(</dev/stdin)
if (($DURATION <= 25000)); then
    exit 60
else
    if ! curl --silent --fail helipad.embassy:2112 &>/dev/null; then
        echo "Helipad Web interface is unreachable" >&2
        exit 1
    fi
fi
