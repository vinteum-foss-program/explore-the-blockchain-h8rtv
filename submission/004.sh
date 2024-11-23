#!/usr/bin/env bash

# Using descriptors, compute the taproot address at index 100 derived from this extended public key:
#   `xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2`
#
# Sources: 
# - https://github.com/bitcoin/bitcoin/blob/master/doc/descriptors.md
# - https://thunderbiscuit.github.io/Learning-Bitcoin-from-the-Command-Line/03_5_Understanding_the_Descriptor.html

# function([derivation-path]key)#checksum

address="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"

index="100"

descriptor="tr($address/$index)"

checksum=$(bitcoin-cli getdescriptorinfo "$descriptor" | jq -r .checksum)

bitcoin-cli deriveaddresses "$descriptor#$checksum" | jq -r '.[0]'
