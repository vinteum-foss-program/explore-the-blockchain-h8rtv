#!/usr/bin/env bash

# Only one single output remains unspent from block 123,321. What address was it sent to?

txs=$(bitcoin-cli getblock $(bitcoin-cli getblockhash 123321) | jq -r ".tx.[]")

function find_utxo
{
    for txid in $txs
    do
        rawtx=$(bitcoin-cli getrawtransaction $txid)
        tx=$(bitcoin-cli decoderawtransaction $rawtx)
        nouts=$(echo $tx | jq '.vin | length')
        rawtx=$(bitcoin-cli getrawtransaction $txid)
        for nout in $(seq 0 $(($nouts - 1)))
        do
            txout=$(bitcoin-cli gettxout $txid $nout | jq -r .scriptPubKey.address)
            if [ -n "$txout" ]; then
                echo $txout
                return 0
            fi
        done
    done
    return 1
}

find_utxo
