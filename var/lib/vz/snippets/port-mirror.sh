#! /usr/bin/env bash

VM_ID=$1;
EXECUTION_PHASE=$2
VM_BRIDGE="vmbr0";
LOGGING=/var/log/port-mirror.log;

function create_mirror {

  /usr/bin/date >> $LOGGING;

  /usr/bin/echo "Creating mirror on $VM_BRIDGE for $VM_ID"... >> $LOGGING;

  /usr/bin/ovs-vsctl \
  -- --id=@tap"$VM_ID"i1 get Port tap"$VM_ID"i1 \
  -- --id=@"$VM_ID"m create Mirror name="$VM_ID"-mirror \
    select-all=true \
    output-port=@tap"$VM_ID"i1 \
    -- set Bridge "$VM_BRIDGE" mirrors=@"$VM_ID"m >> $LOGGING;

  /usr/bin/echo "####################" >> $LOGGING;

}

function clear_mirror {

  /usr/bin/date >> $LOGGING;

  /usr/bin/echo "Clearing mirror on $VM_BRIDGE for $VM_ID..." >> $LOGGING;

  /usr/bin/ovs-vsctl \
    -- --id=@"$VM_ID"m get Mirror "$VM_ID"-mirror \
    -- remove Bridge "$VM_BRIDGE" mirrors @"$VM_ID"m >> $LOGGING;

  /usr/bin/echo "####################" >> $LOGGING;

}

function show_mirrors {

  /usr/bin/date >> $LOGGING;

  /usr/bin/echo "Show existing mirrors..." >> $LOGGING;

  /usr/bin/ovs-vsctl list Mirror >> $LOGGING;

  /usr/bin/echo "####################" >> $LOGGING;

}

if [[ "$EXECUTION_PHASE" == "post-start" ]]; then

  clear_mirror;

  create_mirror;

  show_mirrors;

elif [[ "$EXECUTION_PHASE" == "pre-stop" ]]; then

  clear_mirror;

  show_mirrors;

fi