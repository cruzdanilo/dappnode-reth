#!/bin/bash

case "$_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_MAINNET" in
"prysm.dnp.dappnode.eth")
  echo "Using prysm.dnp.dappnode.eth"
  JWT_PATH="/security/prysm/jwtsecret.hex"
  ;;
"lighthouse.dnp.dappnode.eth")
  echo "Using lighthouse.dnp.dappnode.eth"
  JWT_PATH="/security/lighthouse/jwtsecret.hex"
  ;;
"lodestar.dnp.dappnode.eth")
  echo "Using lodestar.dnp.dappnode.eth"
  JWT_PATH="/security/lodestar/jwtsecret.hex"
  ;;
"teku.dnp.dappnode.eth")
  echo "Using teku.dnp.dappnode.eth"
  JWT_PATH="/security/teku/jwtsecret.hex"
  ;;
"nimbus.dnp.dappnode.eth")
  echo "Using nimbus.dnp.dappnode.eth"
  JWT_PATH="/security/nimbus/jwtsecret.hex"
  ;;
*)
  echo "Using default"
  JWT_PATH="/security/default/jwtsecret.hex"
  ;;
esac

# print the jwt to the dappmanager
JWT=$(cat $JWT_PATH)
curl -X POST "http://my.dappnode/data-send?key=jwt&data=${JWT}"

# shellcheck disable=SC2086
exec reth node \
  --metrics 0.0.0.0:9001 \
  --log.file.directory /root/logs \
  --authrpc.jwtsecret ${JWT_PATH} \
  --authrpc.addr 0.0.0.0 --authrpc.port 8551 \
  --http --http.addr 0.0.0.0 --http.port 8545 \
  --ws --ws.addr 0.0.0.0 --ws.port 8546 \
  --http.api eth,net,web3,txpool \
  $EXTRA_OPTS
