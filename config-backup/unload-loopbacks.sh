#!/bin/bash

# Find all loopback module IDs
echo "Finding active loopback modules..."
LOOPBACK_MODULES=$(pactl list modules short | grep module-loopback | awk '{print $1}')

# Check if any loopback modules exist
if [ -z "$LOOPBACK_MODULES" ]; then
    echo "No loopback modules found. Nothing to unload."
    exit 0
fi

# Unload each loopback module
for MODULE_ID in $LOOPBACK_MODULES; do
    echo "Unloading module-loopback with ID: $MODULE_ID"
    pactl unload-module $MODULE_ID
done

echo "All loopback modules have been unloaded."
