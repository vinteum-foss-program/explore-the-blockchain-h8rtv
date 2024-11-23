#!/usr/bin/env bash

# How many new outputs were created by block 123,456?

# $ bitcoin-cli help getblockstats | grep -n -C 2 outs
# 37-  "minfeerate" : n,              (numeric, optional) Minimum feerate (in satoshis per virtual byte)
# 38-  "mintxsize" : n,               (numeric, optional) Minimum transaction size
# 39:  "outs" : n,                    (numeric, optional) The number of outputs
# 40-  "subsidy" : n,                 (numeric, optional) The block subsidy
# 41-  "swtotal_size" : n,            (numeric, optional) Total size of all segwit transactions

bitcoin-cli getblockstats 123456 | jq .outs
