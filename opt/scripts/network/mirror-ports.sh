#!/bin/bash
# Usage:
#   ./mirror-ports.sh <INPUT> <OUTPUT>
#
# Example:
#   ./mirror-ports.sh vmbr0 vmbr1
#

# Set parameters
INPUT="${1:-vmbr0}"
OUTPUT="${2:-vmbr1}"

# Port mirror
tc qdisc add dev $INPUT ingress
tc filter add dev $INPUT parent ffff: protocol all u32 match u8 0 0 action mirred egress mirror dev $OUTPUT
