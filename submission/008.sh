#!/usr/bin/env bash

# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`


inwitness=$(bitcoin-cli decoderawtransaction $(bitcoin-cli getrawtransaction e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163) | jq -r '.vin[0].txinwitness')
# Result:
# [ "3044022050b45d29a3f2cf098ad0514dff940c78046c377a7e925ded074ad927363dc2dd02207c8a8ca7d099483cf3b50b00366ad2e2771805d6be900097c2c57bc58b4f34a501", "01", "6321025d524ac7ec6501d018d322334f142c7c11aa24b9cffec03161eca35a1e32a71f67029000b2752102ad92d02b7061f520ebb60e932f9743a43fee1db87d2feb1398bf037b3f119fc268ac" ]

script=$(echo $inwitness | jq -r '.[2]')
decodedscript=$(bitcoin-cli decodescript $script)
# Result:
# {
#   "asm": "OP_IF 025d524ac7ec6501d018d322334f142c7c11aa24b9cffec03161eca35a1e32a71f OP_ELSE 144 OP_CHECKSEQUENCEVERIFY OP_DROP 02ad92d02b7061f520ebb60e932f9743a43fee1db87d2feb1398bf037b3f119fc2 OP_ENDIF OP_CHECKSIG",
#   "desc": "raw(6321025d524ac7ec6501d018d322334f142c7c11aa24b9cffec03161eca35a1e32a71f67029000b2752102ad92d02b7061f520ebb60e932f9743a43fee1db87d2feb1398bf037b3f119fc268ac)#8n7kw4g9",
#   "p2sh": "3FM8BvtRqG5uNTgTLXGBxe2cKj3rtBFVHa",
#   "segwit": {
#     "address": "bc1qddkr5ruh97a70ey3xqqsvzn2j7tr3zhamvgfwhtlu5tywsmzm8xqz7d4tx",
#     "asm": "0 6b6c3a0f972fbbe7e4913001060a6a9796388afddb10975d7fe516474362d9cc",
#     "desc": "addr(bc1qddkr5ruh97a70ey3xqqsvzn2j7tr3zhamvgfwhtlu5tywsmzm8xqz7d4tx)#ynaq0rwf",
#     "hex": "00206b6c3a0f972fbbe7e4913001060a6a9796388afddb10975d7fe516474362d9cc",
#     "p2sh-segwit": "32KvHwVHXtoCgvNZZ3jXNZJDgC77yTA1yr",
#     "type": "witness_v0_scripthash"
#   },
#   "type": "nonstandard"
# }

# The second input in $inwitness is 01, which means the first OP_IF will evaluate to true.
# This means that the public key that signed the input was the first one present.
echo $decodedscript | jq -r .asm | awk '{print $2}'
