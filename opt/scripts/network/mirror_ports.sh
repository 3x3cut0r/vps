#!/bin/bash

# set parameters
INPUT="${1:-vmbr0}"
OUTPUT="${2:-vmbr1}"

# port mirror
tc qdisc add dev $INPUT ingress
tc filter add dev $INPUT parent ffff: protocol all u32 match u8 0 0 action mirred egress mirror dev $OUTPUT
