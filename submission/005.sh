#!/usr/bin/env bash

# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

txid=37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517
rawtx=$(bitcoin-cli getrawtransaction $txid)
txaddrs=$(bitcoin-cli decoderawtransaction $rawtx | jq -c '[.vin[] | .txinwitness[1]]')  # access the vin array and map it to the 1th txinwitness

bitcoin-cli createmultisig 1 $txaddrs | jq -r .address
